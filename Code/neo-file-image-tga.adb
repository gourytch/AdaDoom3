--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
separate(Neo.File.Image)
package body TGA
  is
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Color
      is(
      Indexed_Color,
      Grayscale_Color,
      Multi_Color);
    for Enumerated_Color
      use(
      Indexed_Color   => 1,
      Multi_Color     => 2,
      Grayscale_Color => 3);
    for Enumerated_Color'size
      use 2;
  -------------
  -- Records --
  -------------
    type Record_Header
      is record
        Identifier_Length : Integer_1_Unsigned     := 0;
        Color_Map_Kind    : Integer_2_Unsigned     := 0;
        Color             : Enumerated_Color       := Multi_Color;
        Image_Compression : Boolean                := False;
        Color_Map_Index   : Integer_2_Unsigned     := 0;
        Color_Map_Length  : Integer_2_Unsigned     := 0;
        Color_Map_Size    : Integer_1_Unsigned     := 0;
        X_Origin          : Integer_2_Unsigned     := 0;
        Y_Origin          : Integer_2_Unsigned     := 0;
        Width             : Integer_2_Unsigned     := 0;
        Height            : Integer_2_Unsigned     := 0;
        Bits_Per_Pixel    : Integer_1_Unsigned     := 0;
        Alpha_Bits        : Integer_4_Bit_Unsigned := 0;
        Flip_Horizonal    : Boolean                := False;
        Flip_Vertical     : Boolean                := False;
        Junk              : Integer_2_Bit_Unsigned := 0; -- "Must be zero to insure future compatibility."
      end record;
    type Record_Footer
      is record
        if not fseek(fp, -26L, SEEK_END) then
          if fread(footer, sizeof (footer), 1, fp) != 1 then
            raise Currupt with "Cannot read footer from " & Path;
          elsif memcmp(footer + 8, magic, sizeof (magic)) = 0 then
            offset = footer[0] footer[1] footer[2] footer[3];
            if offset != 0 and then fseek(fp, offset, SEEK_SET) or else fread(extension, sizeof (extension), 1, fp) != 1 then
              raise Currupt with "Cannot read extension from " & Path;
            end if;
          end if;
        end if;
  ----------
  -- Load --
  ----------
    function Load(
      Path : in String_2)
      return Array_Record_Graphic
      is
      Header : Record_Header     := (others => <>);
      Footer : Record_Footer     := (others => <>);
      Colors : Enumerated_Colors := Enumerated_Colors'first;
      begin
        --
        -- Read information
        --
        Read(Footer);
        Read(Header);
        ----------------
        Skip_Identifier:
        ----------------
          declare
          type Array_Identifier
            is array(1..Header.Identifier_Length)
            of Integer_1_Unsigned
            with Size => Header.Identifier_Length * Byte'size;
          begin
            Read(Identifier);
          end Skip_Identifier;
        Colors := Enumerated_Colors'val(Header.Bits_Per_Pixel);
        --
        -- Correct minor curruption
        --
        if Header.Alpha_Bits = Header.Bits_Per_Pixel then
          Header.Alpha_Bits := 0; -- http://web.archive.org/liveweb/https://bugzilla.gnome.org/show_bug.cgi?id=306675
        end if;
        if
        Header.Alpha_Bits = 0 and then(
        (Header.Color = Multi_Color     and Colors = Alpha_With_Two_Hundred_Fifty_Six_Per_Colors) or
        (Header.Color = Grayscale_Color and Colors = Thirty_Two_Per_Colors))
        then
          Header.Alpha_Bits := 8; -- http://web.archive.org/liveweb/https://bugzilla.gnome.org/show_bug.cgi?id=540969
        end if;
        --
        -- Check for irreconcilable curruption
        --
        if
        Header.bytes * 8 /= Header.bpp and Header.Bits_Per_Pixel /= 15 or
        (Header.Color = Multi_Color     and Colors < Thirty_Two_Per_Colors) or
        (Header.Color = Mapped_Color    and Colors /= Sixteen_Colors) or
        (Header.Color = Grayscale_Color and Colors /= Sixteen_Colors and
          (Header.alphaBits /= 8 or (Header.Bits_Per_Pixel /= 16 and Header.Bits_Per_Pixel /= 15)))
        then
          raise Currupt with Localize("Unhandled sub-format in '%s' (type = %u, bpp = %u)");
        end if;
        if Header.Color = Mapped_Color and Header.Color_Map_Kind /= 1 then
          raise Currupt with Localize("Indexed image has invalid color map type %u");
        elsif Header.Color /= Mapped_Color and Header.Color_Map_Kind /= 0 then
          raise Currupt with Localize("Non-indexed image has invalid color map type %u");
        end if;
        --
        -- Handle colormap
        --
        if Header.Color = Mapped_Color then
          cmap_bytes = (info->colorMapSize + 7 ) / 8;
          tga_cmap = g_new (guchar, info->colorMapLength * cmap_bytes);
          if info->colorMapSize > 24 then
            convert_cmap = g_new (guchar, info->colorMapLength * 4);
          else info->colorMapLength > 256 then
            convert_cmap = g_new (guchar, info->colorMapLength * 3);
          else
            gimp_cmap = g_new (guchar, info->colorMapLength * 3);
          end if;
          if (cmap_bytes <= 4 && fread (tga_cmap, info->colorMapLength * cmap_bytes, 1, fp) == 1)
            if (convert_cmap)
              if (info->colorMapSize == 32)
                bgr2rgb (convert_cmap, tga_cmap, info->colorMapLength, cmap_bytes, 1);
              elsif (info->colorMapSize == 24)
                bgr2rgb (convert_cmap, tga_cmap, info->colorMapLength, cmap_bytes, 0);
              elsif (info->colorMapSize == 16 || info->colorMapSize == 15)
                upsample (convert_cmap, tga_cmap, info->colorMapLength, cmap_bytes, info->alphaBits);
              else
                raise Currupt with Localize("Unsupported colormap depth: %u");
              end if;
            else
              if (info->colorMapSize == 24)
                bgr2rgb (gimp_cmap, tga_cmap, info->colorMapLength, cmap_bytes, 0);
              elsif (info->colorMapSize == 16 || info->colorMapSize == 15)
                upsample (gimp_cmap, tga_cmap, info->colorMapLength, cmap_bytes, info->alphaBits);
              else
                raise Currupt with Locali"Unsupported colormap depth: %u",
              end if;
            end if;
          end if;
        end if;
        --------------
        Build_Graphic:
        --------------
          declare
          type Integer_Color
            is mod Colors'val**2;
          Current : Integer_Color := Integer_Color'first;
          Graphic : Record_Graphic(Truevision_Graphics_Adapter_Format) :=(
            Pixels            => new Array_Record_Pixel(1..Width, 1..Height),
            Run_Length_Encode => Run_Length_Encoded = 1,
            Colors            => Colors);
          begin
            for I in 1..Header.Height / (if Header.Do_Flip_Vertically then Header.Tile_Height else MAXIMUM_TILE_HEIGHT) loop
              if Header.Do_Flip_Vertically then
                tileheight = i ? max_tileheight : (info->height % max_tileheight);
                if tileheight = 0 then
                  tileheight = max_tileheight;
                end if;
              else
                tileheight = MIN (max_tileheight, info->height - i);
              end if;
              for Y in 1..Header.Height loop
                for X in Graphic.Pixels.Color'range(2) loop
                  Integer_Color'stream(File, Current);
                  if Graphic.Run_Length_Encoded then
                    if Current < 16#F0# then
                      Unique_Colors := True;
                      rleID := rleID + 1;
                    else
                      Unique_Colors := False;
                      rleID := rleID - 16#F0#;
                      fread(pColors, sizeof(unsigned char) * channels, 1, pFile);
                    end if;
                  end if;
                  while rleID > 0 loop
                    if Graphic.Run_Length_Encoded and Unique_Colors then
                      fread(pColors, sizeof(unsigned char) * channels, 1, pFile);
                    else
                      rleID := 0;
                    end if;
                    Graphic.Pixels.Color(X, Y) :=(
                      Pixels =>
                        Blue =>
                          Integer_1_Unsigned(Shift_Right(Integer_4_Unsigned(Current),
                            Integer_Color'size / Graphic.Color'val / Byte'size * 3)),
                        Green =>
                          Integer_1_Unsigned(Shift_Right(Shift_Left(Integer_4_Unsigned(Current),
                            Integer_Color'size / Graphic.Color'val / Byte'size),
                            Integer_Color'size / Graphic.Color'val / Byte'size * 3)),
                        Red =>
                          Integer_1_Unsigned(Shift_Right(Shift_Left(Integer_4_Unsigned(Current),
                            Integer_Color'size / Graphic.Color'val / Byte'size * 2),
                            Integer_Color'size / Graphic.Color'val / Byte'size * 3));
                      Alpha =>(
                        if Colors = Alpha_With_Two_Hundred_Fifty_Six_Per_Colors then
                          Integer_1_Unsigned(Shift_Right(Shift_Left(Integer_4_Unsigned(Current),
                            Integer_Color'size / Graphic.Color'val / Byte'size * 3),
                            Integer_Color'size / Graphic.Color'val / Byte'size * 3))
                        else
                          Byte'last));
                    rleID := rleID - 1;
                    colorsRead += channels;
                  end loop;
                  if (info->flipHoriz)
                    alt = buffer + (info->bytes * (info->width - 1));
                    for (x = 0; x * 2 <= info->width; x++)
                      for (s = 0; s < info->bytes; ++s)
                        temp = buffer[s];
                        buffer[s] = alt[s];
                        alt[s] = temp;
                      end loop;
                      buffer += info->bytes;
                      alt -= info->bytes;
                    end loop;
                    flip_line (buffer, info);
                  end if;
                  if Palette /= null then
                    if (alpha)
                      for (x = 0; x < width; x++)
                        *(dest++) = cmap[*src * 4];
                        *(dest++) = cmap[*src * 4 + 1];
                        *(dest++) = cmap[*src * 4 + 2];
                        *(dest++) = cmap[*src * 4 + 3];
                        src++;
                      end if;
                    else
                      for (x = 0; x < width; x++)
                        *(dest++) = cmap[*src * 3];
                        *(dest++) = cmap[*src * 3 + 1];
                        *(dest++) = cmap[*src * 3 + 2];
                        src++;
                      end loop;
                    end if;
                    apply_colormap (row, buffer, info->width, convert_cmap, (info->colorMapSize > 24));
                  end if;
                end loop;
              end loop;
              if Header.Do_Flip_Vertically then
                gimp_pixel_rgn_set_rect(&pixel_rgn, data, 0,info->height - i - tileheight,info->width, tileheight);
              else
                gimp_pixel_rgn_set_rect(&pixel_rgn, data, 0, i,info->width, tileheight);
              end if;
            end loop;
            return(Graphic);
          end Build_Graphic;
      end Load;
--                for (x = 0; x < info->width; x++)
--                  if (repeat == 0 && direct == 0)
--                    head = getc (fp);
--                    if (head == EOF)
--                      return EOF;
--                    else if (head >= 128)
--                      repeat = head - 127;
--                      if (fread (sample, info->bytes, 1, fp) < 1)
--                        return EOF;
--                      end if;
--                    else
--                      direct = head + 1;
--                    end if;
--                  end if;
--                  if (repeat > 0)
--                    for (k = 0; k < info->bytes; ++k)
--                      buffer[k] = sample[k];
--                    end loop;
--                    repeat--;
--                  else -- direct > 0 */
--                    if (fread (buffer, info->bytes, 1, fp) < 1)
--                      return EOF;
--                    end if;
--                    direct--;
--                  end if;
--                  buffer += info->bytes;
--                end loop;
  ----------
  -- Save --
  ----------
    procedure Save(
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      is
      begin
  GimpPixelRgn   pixel_rgn;
  GimpDrawable  *drawable;
  GimpImageType  dtype;
  gint           width;
  gint           height;

  FILE     *fp;
  gint      out_bpp = 0;
  gboolean  status  = TRUE;
  gint      i, row;

  guchar  header[18];
  guchar  footer[26];
  guchar *pixels;
  guchar *data;

  gint    num_colors;
  guchar *gimp_cmap = NULL;

  drawable = gimp_drawable_get (drawable_ID);
  dtype    = gimp_drawable_type (drawable_ID);

  width  = drawable->width;
  height = drawable->height;

  if ((fp = g_fopen (filename, "wb")) == NULL)
    {
      g_set_error (error, G_FILE_ERROR, g_file_error_from_errno (errno),
                   _("Could not open '%s' for writing: %s"),
                   gimp_filename_to_utf8 (filename), g_strerror (errno));
      return FALSE;
    }

  gimp_progress_init_printf (_("Saving '%s'"),
                             gimp_filename_to_utf8 (filename));

  header[0] = 0; -- No image identifier / description */

  if (dtype == GIMP_INDEXED_IMAGE)
    {
      gimp_cmap = gimp_image_get_colormap (image_ID, &num_colors);

      header[1] = 1; -- cmap type */
      header[2] = (tsvals.rle) ? 9 : 1;
      header[3] = header[4] = 0; -- no offset */
      header[5] = num_colors % 256;
      header[6] = num_colors / 256;
      header[7] = 24; -- cmap size / bits */
    }
  else if (dtype == GIMP_INDEXEDA_IMAGE)
    {
      gimp_cmap = gimp_image_get_colormap (image_ID, &num_colors);

      header[1] = 1; -- cmap type */
      header[2] = (tsvals.rle) ? 9 : 1;
      header[3] = header[4] = 0; -- no offset */
      header[5] = (num_colors + 1) % 256;
      header[6] = (num_colors + 1) / 256;
      header[7] = 32; -- cmap size / bits */
    }
  else
    {
      header[1]= 0;

      if (dtype == GIMP_RGB_IMAGE || dtype == GIMP_RGBA_IMAGE)
        {
          header[2]= (tsvals.rle) ? 10 : 2;
        }
      else
        {
          header[2]= (tsvals.rle) ? 11 : 3;
        }

      header[3] = header[4] = header[5] = header[6] = header[7] = 0;
    }

  header[8]  = header[9] = 0;                           -- xorigin */
  header[10] = tsvals.origin ? 0 : (height % 256);      -- yorigin */
  header[11] = tsvals.origin ? 0 : (height / 256);      -- yorigin */


  header[12] = width % 256;
  header[13] = width / 256;

  header[14] = height % 256;
  header[15] = height / 256;

  switch (dtype)
    {
    case GIMP_INDEXED_IMAGE:
    case GIMP_GRAY_IMAGE:
    case GIMP_INDEXEDA_IMAGE:
      out_bpp = 1;
      header[16] = 8; -- bpp */
      header[17] = tsvals.origin ? 0 : 0x20; -- alpha + orientation */
      break;

    case GIMP_GRAYA_IMAGE:
      out_bpp = 2;
      header[16] = 16; -- bpp */
      header[17] = tsvals.origin ? 8 : 0x28; -- alpha + orientation */
      break;

    case GIMP_RGB_IMAGE:
      out_bpp = 3;
      header[16] = 24; -- bpp */
      header[17] = tsvals.origin ? 0 : 0x20; -- alpha + orientation */
      break;

    case GIMP_RGBA_IMAGE:
      out_bpp = 4;
      header[16] = 32; -- bpp */
      header[17] = tsvals.origin ? 8 : 0x28; -- alpha + orientation */
      break;
    }

  -- write header to front of file */
  fwrite (header, sizeof (header), 1, fp);

  if (dtype == GIMP_INDEXED_IMAGE)
    {
      -- write out palette */
      for (i = 0; i < num_colors; ++i)
        {
          fputc (gimp_cmap[(i * 3) + 2], fp);
          fputc (gimp_cmap[(i * 3) + 1], fp);
          fputc (gimp_cmap[(i * 3) + 0], fp);
        }
    }
  else if (dtype == GIMP_INDEXEDA_IMAGE)
    {
      -- write out palette */
      for (i = 0; i < num_colors; ++i)
        {
          fputc (gimp_cmap[(i * 3) + 2], fp);
          fputc (gimp_cmap[(i * 3) + 1], fp);
          fputc (gimp_cmap[(i * 3) + 0], fp);
          fputc (255, fp);
        }

      fputc (0, fp);
      fputc (0, fp);
      fputc (0, fp);
      fputc (0, fp);
    }

  gimp_tile_cache_ntiles ((width / gimp_tile_width ()) + 1);

  gimp_pixel_rgn_init (&pixel_rgn, drawable, 0, 0, width, height, FALSE, FALSE);

  pixels = g_new (guchar, width * drawable->bpp);
  data   = g_new (guchar, width * out_bpp);

  for (row = 0; row < height; ++row)
    {
      if (tsvals.origin)
        {
          gimp_pixel_rgn_get_row (&pixel_rgn,
                                  pixels, 0, height - (row + 1), width);
        }
      else
        {
          gimp_pixel_rgn_get_row (&pixel_rgn,
                                  pixels, 0, row, width);
        }

      if (dtype == GIMP_RGB_IMAGE)
        {
          bgr2rgb (data, pixels, width, drawable->bpp, 0);
        }
      else if (dtype == GIMP_RGBA_IMAGE)
        {
          bgr2rgb (data, pixels, width, drawable->bpp, 1);
        }
      else if (dtype == GIMP_INDEXEDA_IMAGE)
        {
          for (i = 0; i < width; ++i)
            {
              if (pixels[i * 2 + 1] > 127)
                data[i] = pixels[i * 2];
              else
                data[i] = num_colors;
            }
        }
      else
        {
          memcpy (data, pixels, width * drawable->bpp);
        }

      if (tsvals.rle)
        {
          rle_write (fp, data, width, out_bpp);
        }
      else
        {
          fwrite (data, width * out_bpp, 1, fp);
        }

      if (row % 16 == 0)
        gimp_progress_update ((gdouble) row / (gdouble) height);
    }
      end Save;
  end TGA;


static void
rle_write (FILE   *fp,
           guchar *buffer,
           guint   width,
           guint   bytes)
{
  gint    repeat = 0;
  gint    direct = 0;
  guchar *from   = buffer;
  guint   x;

  for (x = 1; x < width; ++x)
    {
      if (memcmp (buffer, buffer + bytes, bytes))
        {
          -- next pixel is different */
          if (repeat)
            {
              putc (128 + repeat, fp);
              fwrite (from, bytes, 1, fp);
              from = buffer + bytes; -- point to first different pixel */
              repeat = 0;
              direct = 0;
            }
          else
            {
              direct += 1;
            }
        }
      else
        {
          -- next pixel is the same */
          if (direct)
            {
              putc (direct - 1, fp);
              fwrite (from, bytes, direct, fp);
              from = buffer; -- point to first identical pixel */
              direct = 0;
              repeat = 1;
            }
          else
            {
              repeat += 1;
            }
        }

      if (repeat == 128)
        {
          putc (255, fp);
          fwrite (from, bytes, 1, fp);
          from = buffer + bytes;
          direct = 0;
          repeat = 0;
        }
      else if (direct == 128)
        {
          putc (127, fp);
          fwrite (from, bytes, direct, fp);
          from = buffer+ bytes;
          direct = 0;
          repeat = 0;
        }

      buffer += bytes;
    }

  if (repeat > 0)
    {
      putc (128 + repeat, fp);
      fwrite (from, bytes, 1, fp);
    }
  else
    {
      putc (direct, fp);
      fwrite (from, bytes, direct + 1, fp);
    }
}

sta

}











