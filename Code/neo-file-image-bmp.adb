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
with
  Lumen.Image,
  Lumen.Image.BMP,
  Lumen.Binary.IO;
use
  Lumen.Image,
  Lumen.Image.BMP,
  Lumen.Binary.IO;
separate(Neo.File.Image)
package body BMP
  is
  ----------
  -- Load --
  ----------
    function Load(
      Path : in String_2)
      return Array_Record_Graphic
      is
      File : Binary.IO.File_Type;
      begin
        Binary.IO.Open(File, Path);
        Result := BMP.From_File(File);
        Binary.IO.Close(File);
        return To_Array_Record_Pixel(Result);
      end Load;
  ----------
  -- Save --
  ----------
    procedure Save(
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      is
      begin
        raise Unimplemented_Feature;
      end Save;
  end BMP;
  -- ------------------
  -- -- Enumerations --
  -- ------------------
       -- -- Bitmap Version
      -- type Bitmap_Version is (V1, V3, V2, V4, V5);
      -- pragma Convention(C, Bitmap_Version);
      -- for Bitmap_Version use (V1 => 12, V3 => 40, V2 => 64, V4 => 108, V5 => 124);
      -- for Bitmap_Version'Size use Binary.Word_Bits;
       -- -- Compression Method
      -- type Compression_Method is (BI_RGB, BI_RLE8, BI_RLE4, BI_BITFIELDS, BI_JPEG, BI_PNG);
      -- pragma Convention(C, Compression_Method);
      -- for Compression_Method use (BI_RGB => 0, BI_RLE8 => 1, BI_RLE4 => 2, BI_BITFIELDS =>3,
                                  -- BI_JPEG => 4, BI_PNG => 5);
      -- for Compression_Method'Size use Binary.Word_Bits;
  -- -------------
  -- -- Records --
  -- -------------
    -- type Bitmap_File_Header
      -- is record
        -- Magic      : Binary.Byte_String (1..2); -- Magic Number
        -- File_Size  : Binary.Word;  -- File Size in Bytes
        -- Reserved   : Binary.Short_String (1..2); -- Reserved
        -- Offset     : Binary.Word;  -- Offset to Bitmap Data
      -- end record
      -- with Size => * Binary.Byte_Bits; -- 14 Bytes long
    -- type V1_Info_Header
      -- is record
        -- Width : Binary.Short;  -- width of image in pixels
        -- Height : Binary.S_Short; -- height of image in pixels
        -- Planes    : Binary.Short; -- number of planes for target device, must be 1
        -- Bit_Count : Binary.Short; -- number of bits per pixel / max number of colors
      -- end record;
      -- with Size => 8 * Binary.Byte_Bits; -- 8 Bytes + Version => 12 Bytes long
    -- type Record_Version_3_Addition
      -- is record
        -- Width            : Binary.S_Word;
        -- Height           : Binary.S_Word;
        -- Planes           : Binary.Short;
        -- Bit_Count        : Binary.Short;
        -- Compression      : Compression_Method;
        -- Image_Size       : Binary.Word;
        -- XRes             : Binary.Word;
        -- YRes             : Binary.Word;
        -- Colors_Used      : Binary.Word;
        -- Important_Colors : Binary.Word;
      -- end record
      -- with Size =>36 * Binary.Byte_Bits; -- 36 Bytes + Version => 40 Bytes long
    -- type Record_Version_2_Addition -- Version 2 after 3?
      -- is record
        -- Resolution_Unit : Binary.Short;
        -- Reserved        : Binary.Short;
        -- Orientation     : Binary.Short;
        -- Halftoning      : Binary.Short;
        -- Halftone_Size_1 : Binary.Word;
        -- Halftone_Size_2 : Binary.Word;
        -- Color_Space     : Binary.Word;
        -- App_Data        : Binary.Word;
      -- end record
      -- with Size => * Binary.Byte_Bits; -- 24 Bytes + Version + V3 => 64 Bytes long
    -- type Record_Version_4_Addition
      -- is record
        -- Red_Mask         : Binary.Word; -- (BI_BITFIELDS compression)
        -- Green_Mask       : Binary.Word; -- (BI_BITFIELDS compression)
        -- Blue_Mask        : Binary.Word; -- (BI_BITFIELDS compression)
        -- Alpha_Mask       : Binary.Word;
        -- Color_Space_Type : Binary.Word;
        -- Endpoints        : Binary.Word_String(1..9); -- endpoints for the three colors for LCS_CALIBRATED_RGB
        -- Gamma_Red        : Binary.Word;
        -- Gamma_Green      : Binary.Word;
        -- Gamma_Blue       : Binary.Word;
      -- end record
      -- with Size => 68 * Byte'size; -- 68 Bytes + Version + V3 => 108 Bytes long
    -- type Record_Version_5_Addition
      -- is record
        -- Rendering_Intent : Binary.Word; -- rendering intent for bitmap
        -- Profile_Data     : Binary.Word; -- offset in bytes from beginning of Bitmap_V5_Header to start of profile data, or the data itself
        -- Profile_Size     : Binary.Word; -- size in bytes of embedded profile data
        -- Reserved         : Binary.Word; -- reserved, should be 0
      -- end record
      -- with Size => 16 * Byte'size; -- 16 Bytes + Version + V3 + V4 => 124 Bytes long
  -- ----------
  -- -- Save --
  -- ----------
    -- overriding procedure Save(
      -- Tag     : in Example.Tag;
      -- Path    : in String_2;
      -- Graphic : in Array_Record_Graphic)
      -- is
      -- begin
        -- raise Unimplemented_Feature;
      -- end Save;
  -- ----------
  -- -- Load --
  -- ----------
    -- overriding function Load(
      -- Tag  : in Tag;
      -- Path : in String_2)
      -- return Array_Record_Data
      -- is
      -- Specifics : aliased Access_Record_Specifics := new Record_Specifics(Bit_Map_Format);
      -- Width     :         Integer_4_Positive      := 1;
      -- Height    :         Integer_4_Positive      := 1;
      -- begin
        -- -- Width, Height, and Bits_Per_Pixel for file at path, generate palette
        -- -----------
        -- Build_Result:
        -- -------------
          -- declare
          -- type Integer_Color
            -- is mod Specifics.Bits_Per_Pixel**2;
          -- Color   : constant Enumerated_Color := Enumerated_Color'Pos(Data.Specifics.Bits_Per_Pixel);
          -- Current :          Integer_Color    := Integer_Color'first;
          -- Result  :          Record_Data      := (Specifics, new Array_Record_Color(1..Width, 1..Height));
          -- begin
            -- for Y in Data.Color'range(1) loop
              -- for X in Data.Color'range(2) loop
                -- Integer_Color'stream(File, Current);
                -- case Color is
                  -- when Monochrome_Color | Sixteen_Color | Two_Hundred_Fifty_Six_Color | Sixteen_Color =>
                    -- Data.Color(X, Y) :=(
                      -- Alpha => Byte'last,
                      -- Data  =>( -- 16#101# because max intensity FF goes to FFFF
                        -- Red   => Palette(Integer(Current)).Red)   * 16#0101#,
                        -- Green => Palette(Integer(Current)).Green) * 16#0101#,
                        -- Blue  => Palette(Integer(Current)).Blue)  * 16#0101#));
                  -- when Two_Hundred_Fifty_Six_Per_Primary_Color =>
                    -- Data.Color(X, Y) :=(
                      -- Alpha => Byte'last,
                      -- Data  =>(
                        -- Red   => To_Integer_1_Unsigned(Shift_Right(           To_Integer_4_Unsigned(Current),                 Byte'size * 2)),
                        -- Green => To_Integer_1_Unsigned(Shift_Right(Shift_Left(To_Integer_4_Unsigned(Current), Byte'size),     Byte'size * 2)),
                        -- Blue  => To_Integer_1_Unsigned(Shift_Right(Shift_Left(To_Integer_4_Unsigned(Current), Byte'size * 2), Byte'size * 2));
                -- end case;
              -- end loop;
            -- end loop;
            -- return(Result);
          -- exception
            -- when others =>
              -- raise Currupt;
          -- end Build_Result;
      -- end Load;
  -- end BMP;

#include "config.h"

#include <errno.h>
#include <string.h>

#include <glib/gstdio.h>

#include <libgimp/gimp.h>
#include <libgimp/gimpui.h>

#include "bmp.h"

#include "libgimp/stdplugins-intl.h"

typedef enum
{
  RGB_565,
  RGBA_5551,
  RGB_555,
  RGB_888,
  RGBA_8888,
  RGBX_8888
} RGBMode;

static struct
{
  RGBMode rgb_format;
  gint    use_run_length_encoding;

  /* Weather or not to write BITMAPV5HEADER color space data */
  gint    dont_write_color_space_data;
} BMPSaveData;

static gint    cur_progress = 0;
static gint    max_progress = 0;


static  void      write_image     (FILE   *f,
                                   guchar *src,
                                   gint    width,
                                   gint    height,
                                   gint    use_run_length_encoding,
                                   gint    channels,
                                   gint    bpp,
                                   gint    spzeile,
                                   gint    MapSize,
                                   RGBMode rgb_format);

static  gboolean  save_dialog     (gint    channels);


static void
FromL (gint32  wert,
       guchar *bopuffer)
{
  bopuffer[0] = (wert & 0x000000ff)>>0x00;
  bopuffer[1] = (wert & 0x0000ff00)>>0x08;
  bopuffer[2] = (wert & 0x00ff0000)>>0x10;
  bopuffer[3] = (wert & 0xff000000)>>0x18;
}

static void
FromS (gint16  wert,
       guchar *bopuffer)
{
  bopuffer[0] = (wert & 0x00ff)>>0x00;
  bopuffer[1] = (wert & 0xff00)>>0x08;
}

static void
write_color_map (FILE *f,
                 gint  red[MAXCOLORS],
                 gint  green[MAXCOLORS],
                 gint  blue[MAXCOLORS],
                 gint  size)
{
  gchar trgb[4];
  gint  i;

  size /= 4;
  trgb[3] = 0;
  for (i = 0; i < size; i++)
    {
      trgb[0] = (guchar) blue[i];
      trgb[1] = (guchar) green[i];
      trgb[2] = (guchar) red[i];
      Write (f, trgb, 4);
    }
}

static gboolean
warning_dialog (const gchar *primary,
                const gchar *secondary)
{
  GtkWidget *dialog;
  gboolean   ok;

  dialog = gtk_message_dialog_new (NULL, 0,
                                   GTK_MESSAGE_WARNING, GTK_BUTTONS_OK_CANCEL,
                                   "%s", primary);

  gtk_message_dialog_format_secondary_text (GTK_MESSAGE_DIALOG (dialog),
                                            "%s", secondary);

  gimp_window_set_transient (GTK_WINDOW (dialog));

  ok = (gtk_dialog_run (GTK_DIALOG (dialog)) == GTK_RESPONSE_OK);

  gtk_widget_destroy (dialog);

  return ok;
}

GimpPDBStatusType
WriteBMP (const gchar  *filename,
          gint32        image,
          gint32        drawable_ID,
          GError      **error)
{
  FILE          *outfile;
  gint           Red[MAXCOLORS];
  gint           Green[MAXCOLORS];
  gint           Blue[MAXCOLORS];
  guchar        *cmap;
  gint           rows, cols, Spcols, channels, MapSize, SpZeile;
  glong          BitsPerPixel;
  gint           colors;
  guchar        *pixels;
  GimpPixelRgn   pixel_rgn;
  GimpDrawable  *drawable;
  GimpImageType  drawable_type;
  guchar         puffer[128];
  gint           i;
  gint           mask_info_size;
  gint           color_space_size;
  guint32        Mask[4];

  drawable = gimp_drawable_get (drawable_ID);
  drawable_type = gimp_drawable_type (drawable_ID);

  gimp_pixel_rgn_init (&pixel_rgn, drawable,
                       0, 0, drawable->width, drawable->height, FALSE, FALSE);

  switch (drawable_type)
    {
    case GIMP_RGBA_IMAGE:
      colors       = 0;
      BitsPerPixel = 32;
      MapSize      = 0;
      channels     = 4;
      BMPSaveData.rgb_format = RGBA_8888;
      break;

    case GIMP_RGB_IMAGE:
      colors       = 0;
      BitsPerPixel = 24;
      MapSize      = 0;
      channels     = 3;
      BMPSaveData.rgb_format = RGB_888;
      break;

    case GIMP_GRAYA_IMAGE:
      if (interactive && !warning_dialog (_("Cannot save indexed image with "
    					    "transparency in BMP file format."),
                                          _("Alpha channel will be ignored.")))
          return GIMP_PDB_CANCEL;

     /* fallthrough */

    case GIMP_GRAY_IMAGE:
      colors       = 256;
      BitsPerPixel = 8;
      MapSize      = 1024;

      if (drawable_type == GIMP_GRAYA_IMAGE)
        channels = 2;
      else
        channels = 1;

      for (i = 0; i < colors; i++)
        {
          Red[i]   = i;
          Green[i] = i;
          Blue[i]  = i;
        }
      break;

    case GIMP_INDEXEDA_IMAGE:
      if (interactive && !warning_dialog (_("Cannot save indexed image with "
    			                    "transparency in BMP file format."),
                                          _("Alpha channel will be ignored.")))
          return GIMP_PDB_CANCEL;

     /* fallthrough */

    case GIMP_INDEXED_IMAGE:
      cmap     = gimp_image_get_colormap (image, &colors);
      MapSize  = 4 * colors;

      if (drawable_type == GIMP_INDEXEDA_IMAGE)
        channels = 2;
      else
        channels = 1;

      if (colors > 16)
        BitsPerPixel = 8;
      else if (colors > 2)
        BitsPerPixel = 4;
      else
        BitsPerPixel = 1;

      for (i = 0; i < colors; i++)
        {
          Red[i]   = *cmap++;
          Green[i] = *cmap++;
          Blue[i]  = *cmap++;
        }
      break;

    default:
      g_assert_not_reached ();
    }

  BMPSaveData.use_run_length_encoding = 0;
  BMPSaveData.dont_write_color_space_data = 0;
  mask_info_size = 0;

  if (interactive || lastvals)
    {
      gimp_get_data (SAVE_PROC, &BMPSaveData);
    }

  if ((BitsPerPixel == 8 || BitsPerPixel == 4) && interactive)
    {
      if (! save_dialog (1))
        return GIMP_PDB_CANCEL;
    }
  else if ((BitsPerPixel == 24 || BitsPerPixel == 32))
    {
      if (interactive && !save_dialog (channels))
        return GIMP_PDB_CANCEL;

      switch (BMPSaveData.rgb_format)
        {
        case RGB_888:
          BitsPerPixel = 24;
          break;
        case RGBA_8888:
          BitsPerPixel = 32;
          break;
        case RGBX_8888:
          BitsPerPixel = 32;
          mask_info_size = 16;
          break;
        case RGB_565:
          BitsPerPixel = 16;
          mask_info_size = 16;
          break;
        case RGBA_5551:
          BitsPerPixel = 16;
          mask_info_size = 16;
          break;
        case RGB_555:
          BitsPerPixel = 16;
          break;
        default:
          g_return_val_if_reached (GIMP_PDB_EXECUTION_ERROR);
        }
    }

  gimp_set_data (SAVE_PROC, &BMPSaveData, sizeof (BMPSaveData));

  /* Let's take some file */
  outfile = g_fopen (filename, "wb");
  if (!outfile)
    {
      g_set_error (error, G_FILE_ERROR, g_file_error_from_errno (errno),
                   _("Could not open '%s' for writing: %s"),
                   gimp_filename_to_utf8 (filename), g_strerror (errno));
      return GIMP_PDB_EXECUTION_ERROR;
    }

  /* fetch the image */
  pixels = g_new (guchar, drawable->width * drawable->height * channels);
  gimp_pixel_rgn_get_rect (&pixel_rgn, pixels,
                           0, 0, drawable->width, drawable->height);

  /* And let's begin the progress */
  gimp_progress_init_printf (_("Saving '%s'"),
                             gimp_filename_to_utf8 (filename));

  cur_progress = 0;
  max_progress = drawable->height;

  /* Now, we need some further information ... */
  cols = drawable->width;
  rows = drawable->height;

  /* ... that we write to our headers. */
  if ((BitsPerPixel <= 8) && (cols % (8 / BitsPerPixel)))
    Spcols = (((cols / (8 / BitsPerPixel)) + 1) * (8 / BitsPerPixel));
  else
    Spcols = cols;

  if ((((Spcols * BitsPerPixel) / 8) % 4) == 0)
    SpZeile = ((Spcols * BitsPerPixel) / 8);
  else
    SpZeile = ((gint) (((Spcols * BitsPerPixel) / 8) / 4) + 1) * 4;

  color_space_size = 0;
  if (! BMPSaveData.dont_write_color_space_data)
    color_space_size = 68;

  Bitmap_File_Head.bfSize    = (0x36 + MapSize + (rows * SpZeile) +
                                mask_info_size + color_space_size);
  Bitmap_File_Head.zzHotX    =  0;
  Bitmap_File_Head.zzHotY    =  0;
  Bitmap_File_Head.bfOffs    = (0x36 + MapSize +
                                mask_info_size + color_space_size);
  Bitmap_File_Head.biSize    =  40 + mask_info_size + color_space_size;

  Bitmap_Head.biWidth  = cols;
  Bitmap_Head.biHeight = rows;
  Bitmap_Head.biPlanes = 1;
  Bitmap_Head.biBitCnt = BitsPerPixel;

  if (BMPSaveData.use_run_length_encoding == 0)
  {
    if (mask_info_size > 0)
      Bitmap_Head.biCompr = 3; /* BI_BITFIELDS */
    else
      Bitmap_Head.biCompr = 0; /* BI_RGB */
  }
  else if (BitsPerPixel == 8)
    Bitmap_Head.biCompr = 1;
  else if (BitsPerPixel == 4)
    Bitmap_Head.biCompr = 2;
  else
    Bitmap_Head.biCompr = 0;

  Bitmap_Head.biSizeIm = SpZeile * rows;

  {
    gdouble xresolution;
    gdouble yresolution;
    gimp_image_get_resolution (image, &xresolution, &yresolution);

    if (xresolution > GIMP_MIN_RESOLUTION &&
        yresolution > GIMP_MIN_RESOLUTION)
      {
        /*
         * xresolution and yresolution are in dots per inch.
         * the BMP spec says that biXPels and biYPels are in
         * pixels per meter as long ints (actually, "DWORDS"),
         * so...
         *    n dots    inch     100 cm   m dots
         *    ------ * ------- * ------ = ------
         *     inch    2.54 cm     m       inch
         *
         * We add 0.5 for proper rounding.
         */
        Bitmap_Head.biXPels = (long int) (xresolution * 100.0 / 2.54 + 0.5);
        Bitmap_Head.biYPels = (long int) (yresolution * 100.0 / 2.54 + 0.5);
      }
  }

  if (BitsPerPixel <= 8)
    Bitmap_Head.biClrUsed = colors;
  else
    Bitmap_Head.biClrUsed = 0;

  Bitmap_Head.biClrImp = Bitmap_Head.biClrUsed;

#ifdef DEBUG
  printf("\nSize: %u, Colors: %u, Bits: %u, Width: %u, Height: %u, Comp: %u, Zeile: %u\n",
         (int)Bitmap_File_Head.bfSize,(int)Bitmap_Head.biClrUsed,Bitmap_Head.biBitCnt,(int)Bitmap_Head.biWidth,
         (int)Bitmap_Head.biHeight, (int)Bitmap_Head.biCompr,SpZeile);
#endif

  /* And now write the header and the colormap (if any) to disk */

  Write (outfile, "BM", 2);

  FromL (Bitmap_File_Head.bfSize, &puffer[0x00]);
  FromS (Bitmap_File_Head.zzHotX, &puffer[0x04]);
  FromS (Bitmap_File_Head.zzHotY, &puffer[0x06]);
  FromL (Bitmap_File_Head.bfOffs, &puffer[0x08]);
  FromL (Bitmap_File_Head.biSize, &puffer[0x0C]);

  Write (outfile, puffer, 16);

  FromL (Bitmap_Head.biWidth, &puffer[0x00]);
  FromL (Bitmap_Head.biHeight, &puffer[0x04]);
  FromS (Bitmap_Head.biPlanes, &puffer[0x08]);
  FromS (Bitmap_Head.biBitCnt, &puffer[0x0A]);
  FromL (Bitmap_Head.biCompr, &puffer[0x0C]);
  FromL (Bitmap_Head.biSizeIm, &puffer[0x10]);
  FromL (Bitmap_Head.biXPels, &puffer[0x14]);
  FromL (Bitmap_Head.biYPels, &puffer[0x18]);
  FromL (Bitmap_Head.biClrUsed, &puffer[0x1C]);
  FromL (Bitmap_Head.biClrImp, &puffer[0x20]);

  Write (outfile, puffer, 36);

  if (mask_info_size > 0)
    {
      switch (BMPSaveData.rgb_format)
        {
        default:
        case RGB_888:
        case RGBX_8888:
          Mask[0] = 0xff000000;
          Mask[1] = 0x00ff0000;
          Mask[2] = 0x0000ff00;
          Mask[3] = 0x00000000;
          break;

        case RGBA_8888:
          Mask[0] = 0xff000000;
          Mask[1] = 0x00ff0000;
          Mask[2] = 0x0000ff00;
          Mask[3] = 0x000000ff;
          break;

        case RGB_565:
          Mask[0] = 0xf800;
          Mask[1] = 0x7e0;
          Mask[2] = 0x1f;
          Mask[3] = 0x0;
          break;

        case RGBA_5551:
          Mask[0] = 0x7c00;
          Mask[1] = 0x3e0;
          Mask[2] = 0x1f;
          Mask[3] = 0x8000;
          break;

        case RGB_555:
          Mask[0] = 0x7c00;
          Mask[1] = 0x3e0;
          Mask[2] = 0x1f;
          Mask[3] = 0x0;
          break;
        }

      FromL (Mask[0], &puffer[0x00]);
      FromL (Mask[1], &puffer[0x04]);
      FromL (Mask[2], &puffer[0x08]);
      FromL (Mask[3], &puffer[0x0C]);
      Write (outfile, puffer, mask_info_size);
    }

  if (! BMPSaveData.dont_write_color_space_data)
    {
      /* Write V5 color space fields */

      /* bV5CSType = LCS_sRGB */
      FromL (0x73524742, &puffer[0x00]);

      /* bV5Endpoints is set to 0 (ignored) */
      for (i = 0; i < 0x24; i++)
        puffer[0x04 + i] = 0x00;

      /* bV5GammaRed is set to 0 (ignored) */
      FromL (0x0, &puffer[0x28]);

      /* bV5GammaGreen is set to 0 (ignored) */
      FromL (0x0, &puffer[0x2c]);

      /* bV5GammaBlue is set to 0 (ignored) */
      FromL (0x0, &puffer[0x30]);

      /* bV5Intent = LCS_GM_GRAPHICS */
      FromL (0x00000002, &puffer[0x34]);

      /* bV5ProfileData is set to 0 (ignored) */
      FromL (0x0, &puffer[0x38]);

      /* bV5ProfileSize is set to 0 (ignored) */
      FromL (0x0, &puffer[0x3c]);

      /* bV5Reserved = 0 */
      FromL (0x0, &puffer[0x40]);

      Write (outfile, puffer, color_space_size);
    }

  write_color_map (outfile, Red, Green, Blue, MapSize);

  /* After that is done, we write the image ... */

  write_image (outfile,
               pixels, cols, rows,
               BMPSaveData.use_run_length_encoding,
               channels, BitsPerPixel, SpZeile,
               MapSize, BMPSaveData.rgb_format);

  /* ... and exit normally */

  fclose (outfile);
  gimp_drawable_detach (drawable);
  g_free (pixels);

  return GIMP_PDB_SUCCESS;
}

static inline void Make565(guchar r, guchar g, guchar b, guchar *buf)
{
    gint p;
    p = (((gint)(r / 255.0 * 31.0 + 0.5))<<11) |
        (((gint)(g / 255.0 * 63.0 + 0.5))<<5)  |
         ((gint)(b / 255.0 * 31.0 + 0.5));
    buf[0] = (guchar)(p & 0xff);
    buf[1] = (guchar)(p>>8);
}

static inline void Make5551(guchar r, guchar g, guchar b, guchar a, guchar *buf)
{
    gint p;
    p = (((gint)(r / 255.0 * 31.0 + 0.5))<<10) |
        (((gint)(g / 255.0 * 31.0 + 0.5))<<5)  |
         ((gint)(b / 255.0 * 31.0 + 0.5))      |
         ((gint)(a / 255.0 + 0.5)<<15);
    buf[0] = (guchar)(p & 0xff);
    buf[1] = (guchar)(p>>8);
}

static void
write_image (FILE   *f,
             guchar *src,
             gint    width,
             gint    height,
             gint    use_run_length_encoding,
             gint    channels,
             gint    bpp,
             gint    spzeile,
             gint    MapSize,
             RGBMode rgb_format)
{
  guchar  buf[16] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0 };
  guchar  puffer[8];
  guchar *temp, v;
  guchar *row, *ketten;
  gint    xpos, ypos, i, j, rowstride, length, thiswidth;
  gint    breite, k;
  guchar  n, r, g, b, a;

  xpos = 0;
  rowstride = width * channels;

  /* We'll begin with the 16/24/32 bit Bitmaps, they are easy :-) */

  if (bpp > 8)
    {
      for (ypos = height - 1; ypos >= 0; ypos--)  /* for each row   */
        {
          for (i = 0; i < width; i++)  /* for each pixel */
            {
              temp = src + (ypos * rowstride) + (xpos * channels);
              switch (rgb_format)
                {
                default:
                case RGB_888:
                  buf[2] = *temp++;
                  buf[1] = *temp++;
                  buf[0] = *temp++;
                  xpos++;
                  if (channels > 3 && (guchar) *temp == 0)
                    buf[0] = buf[1] = buf[2] = 0xff;
                  Write (f, buf, 3);
                  break;
                case RGBX_8888:
                  buf[0] = 0;
                  buf[3] = *temp++;
                  buf[2] = *temp++;
                  buf[1] = *temp++;
                  xpos++;
                  if (channels > 3 && (guchar) *temp == 0)
                    buf[0] = buf[1] = buf[2] = 0xff;
                  Write (f, buf, 4);
                  break;
                case RGBA_8888:
                  buf[2] = *temp++;
                  buf[1] = *temp++;
                  buf[0] = *temp++;
                  buf[3] = *temp;
                  xpos++;
                  Write (f, buf, 4);
                  break;
                case RGB_565:
                  r = *temp++;
                  g = *temp++;
                  b = *temp++;
                  if (channels > 3 && (guchar) *temp == 0)
                    r = g = b = 0xff;
                  Make565 (r, g, b, buf);
                  xpos++;
                  Write (f, buf, 2);
                  break;
                case RGB_555:
                  r = *temp++;
                  g = *temp++;
                  b = *temp++;
                  if (channels > 3 && (guchar) *temp == 0)
                    r = g = b = 0xff;
                  Make5551 (r, g, b, 0x0, buf);
                  xpos++;
                  Write (f, buf, 2);
                  break;
                case RGBA_5551:
                  r = *temp++;
                  g = *temp++;
                  b = *temp++;
                  a = *temp;
                  Make5551 (r, g, b, a, buf);
                  xpos++;
                  Write (f, buf, 2);
                  break;
                }
            }

          Write (f, &buf[4], spzeile - (width * (bpp/8)));

          cur_progress++;
          if ((cur_progress % 5) == 0)
            gimp_progress_update ((gdouble) cur_progress /
                                  (gdouble) max_progress);

          xpos = 0;
        }
    }
  else
    {
      switch (use_run_length_encoding)  /* now it gets more difficult */
        {               /* uncompressed 1,4 and 8 bit */
        case 0:
          {
            thiswidth = (width / (8 / bpp));
            if (width % (8 / bpp))
              thiswidth++;

            for (ypos = height - 1; ypos >= 0; ypos--) /* for each row */
              {
                for (xpos = 0; xpos < width;)  /* for each _byte_ */
                  {
                    v = 0;
                    for (i = 1;
                         (i <= (8 / bpp)) && (xpos < width);
                         i++, xpos++)  /* for each pixel */
                      {
                        temp = src + (ypos * rowstride) + (xpos * channels);
                        if (channels > 1 && *(temp+1) == 0) *temp = 0x0;
                        v=v | ((guchar) *temp << (8 - (i * bpp)));
                      }
                    Write (f, &v, 1);
                  }
                Write (f, &buf[3], spzeile - thiswidth);
                xpos = 0;

                cur_progress++;
                if ((cur_progress % 5) == 0)
                  gimp_progress_update ((gdouble) cur_progress /
                                        (gdouble) max_progress);
              }
            break;
          }
        default:
          {              /* Save RLE encoded file, quite difficult */
            length = 0;
            buf[12] = 0;
            buf[13] = 1;
            buf[14] = 0;
            buf[15] = 0;
            row = g_new (guchar, width / (8 / bpp) + 10);
            ketten = g_new (guchar, width / (8 / bpp) + 10);
            for (ypos = height - 1; ypos >= 0; ypos--)
              { /* each row separately */
                j = 0;
                /* first copy the pixels to a buffer,
                 * making one byte from two 4bit pixels
                 */
                for (xpos = 0; xpos < width;)
                  {
                    v = 0;
                    for (i = 1;
                         (i <= (8 / bpp)) && (xpos < width);
                         i++, xpos++)
                      { /* for each pixel */
                        temp = src + (ypos * rowstride) + (xpos * channels);
                        if (channels > 1 && *(temp+1) == 0) *temp = 0x0;
                        v = v | ((guchar) * temp << (8 - (i * bpp)));
                      }
                    row[j++] = v;
                  }
                breite = width / (8 / bpp);
                if (width % (8 / bpp))
                  breite++;
                /* then check for strings of equal bytes */
                for (i = 0; i < breite; i += j)
                  {
                    j = 0;
                    while ((i + j < breite) &&
                           (j < (255 / (8 / bpp))) &&
                           (row[i + j] == row[i]))
                      j++;

                    ketten[i] = j;
                  }

                /* then write the strings and the other pixels to the file */
                for (i = 0; i < breite;)
                  {
                    if (ketten[i] < 3)
                      /* strings of different pixels ... */
                      {
                        j = 0;
                        while ((i + j < breite) &&
                               (j < (255 / (8 / bpp))) &&
                               (ketten[i + j] < 3))
                          j += ketten[i + j];

                        /* this can only happen if j jumps over
                         * the end with a 2 in ketten[i+j]
                         */
                        if (j > (255 / (8 / bpp)))
                          j -= 2;
                        /* 00 01 and 00 02 are reserved */
                        if (j > 2)
                          {
                            Write (f, &buf[12], 1);
                            n = j * (8 / bpp);
                            if (n + i * (8 / bpp) > width)
                              n--;
                            Write (f, &n, 1);
                            length += 2;
                            Write (f, &row[i], j);
                            length += j;
                            if ((j) % 2)
                              {
                                Write (f, &buf[12], 1);
                                length++;
                              }
                          }
                        else
                          {
                            for (k = i; k < i + j; k++)
                              {
                                n = (8 / bpp);
                                if (n + i * (8 / bpp) > width)
                                  n--;
                                Write (f, &n, 1);
                                Write (f, &row[k], 1);
                                /*printf("%i.#|",n); */
                                length += 2;
                              }
                          }
                        i += j;
                      }
                    else
                      /* strings of equal pixels */
                      {
                        n = ketten[i] * (8 / bpp);
                        if (n + i * (8 / bpp) > width)
                          n--;
                        Write (f, &n, 1);
                        Write (f, &row[i], 1);
                        i += ketten[i];
                        length += 2;
                      }
                  }
                Write (f, &buf[14], 2);          /* End of row */
                length += 2;

                cur_progress++;
                if ((cur_progress % 5) == 0)
                  gimp_progress_update ((gdouble) cur_progress /
                                        (gdouble) max_progress);
              }
            fseek (f, -2, SEEK_CUR);     /* Overwrite last End of row ... */
            Write (f, &buf[12], 2);      /* ... with End of file */

            fseek (f, 0x22, SEEK_SET);            /* Write length of image */
            FromL (length, puffer);
            Write (f, puffer, 4);
            fseek (f, 0x02, SEEK_SET);            /* Write length of file */
            length += (0x36 + MapSize);
            FromL (length, puffer);
            Write (f, puffer, 4);
            g_free (ketten);
            g_free (row);
            break;
          }
        }
    }

  gimp_progress_update (1.0);
}

static void


#include "config.h"

#include <errno.h>
#include <string.h>

#include <glib/gstdio.h>

#include <libgimp/gimp.h>

#include "bmp.h"

#include "libgimp/stdplugins-intl.h"


#if !defined(WIN32) || defined(__MINGW32__)
#define BI_RGB          0
#define BI_RLE8         1
#define BI_RLE4         2
#define BI_BITFIELDS    3
#endif

static gint32 ReadImage (FILE                  *fd,
                         gint                   width,
                         gint                   height,
                         guchar                 cmap[256][3],
                         gint                   ncols,
                         gint                   bpp,
                         gint                   compression,
                         gint                   rowbytes,
                         gboolean               grey,
                         const Bitmap_Channel  *masks,
                         GError               **error);


static gint32
ToL (const guchar *puffer)
{
  return (puffer[0] | puffer[1] << 8 | puffer[2] << 16 | puffer[3] << 24);
}

static gint16
ToS (const guchar *puffer)
{
  return (puffer[0] | puffer[1] << 8);
}

static gboolean
ReadColorMap (FILE     *fd,
              guchar    buffer[256][3],
              gint      number,
              gint      size,
              gboolean *grey)
{
  gint   i;
  guchar rgb[4];

  *grey = (number > 2);

  for (i = 0; i < number ; i++)
    {
      if (!ReadOK (fd, rgb, size))
        {
          g_message (_("Bad colormap"));
          return FALSE;
        }

      /* Bitmap save the colors in another order! But change only once! */

      buffer[i][0] = rgb[2];
      buffer[i][1] = rgb[1];
      buffer[i][2] = rgb[0];
      *grey = ((*grey) && (rgb[0]==rgb[1]) && (rgb[1]==rgb[2]));
    }

  return TRUE;
}

static gboolean
ReadChannelMasks (guint32 *tmp, Bitmap_Channel *masks, guint channels)
{
  guint32 mask;
  gint   i, nbits, offset, bit;

  for (i = 0; i < channels; i++)
    {
      mask = tmp[i];
      masks[i].mask = mask;
      nbits = 0;
      offset = -1;
      for (bit = 0; bit < 32; bit++)
        {
          if (mask & 1)
            {
              nbits++;
              if (offset == -1)
                offset = bit;
            }
          mask = mask >> 1;
        }
      masks[i].shiftin = offset;
      masks[i].max_value = (gfloat)((1<<(nbits))-1);

#ifdef DEBUG
      g_print ("Channel %d mask %08x in %d max_val %d\n",
               i, masks[i].mask, masks[i].shiftin, (gint)masks[i].max_value);
#endif
    }

  return TRUE;
}

gint32
ReadBMP (const gchar  *name,
         GError      **error)
{
  FILE     *fd;
  guchar    buffer[64];
  gint      ColormapSize, rowbytes, Maps;
  gboolean  Grey = FALSE;
  guchar    ColorMap[256][3];
  gint32    image_ID;
  gchar     magick[2];
  Bitmap_Channel masks[4];

  filename = name;
  fd = g_fopen (filename, "rb");

  if (!fd)
    {
      g_set_error (error, G_FILE_ERROR, g_file_error_from_errno (errno),
                   _("Could not open '%s' for reading: %s"),
                   gimp_filename_to_utf8 (filename), g_strerror (errno));
      return -1;
    }

  gimp_progress_init_printf (_("Opening '%s'"),
                             gimp_filename_to_utf8 (name));

  /* It is a File. Now is it a Bitmap? Read the shortest possible header */

  if (!ReadOK (fd, magick, 2) || !(!strncmp (magick, "BA", 2) ||
     !strncmp (magick, "BM", 2) || !strncmp (magick, "IC", 2) ||
     !strncmp (magick, "PT", 2) || !strncmp (magick, "CI", 2) ||
     !strncmp (magick, "CP", 2)))
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      fclose (fd);
      return -1;
    }

  while (!strncmp (magick, "BA", 2))
    {
      if (!ReadOK (fd, buffer, 12))
        {
          g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                       _("'%s' is not a valid BMP file"),
                       gimp_filename_to_utf8 (filename));
          return -1;
        }
      if (!ReadOK (fd, magick, 2))
        {
          g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                       _("'%s' is not a valid BMP file"),
                       gimp_filename_to_utf8 (filename));
          return -1;
        }
    }

  if (!ReadOK (fd, buffer, 12))
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  /* bring them to the right byteorder. Not too nice, but it should work */

  Bitmap_File_Head.bfSize    = ToL (&buffer[0x00]);
  Bitmap_File_Head.zzHotX    = ToS (&buffer[0x04]);
  Bitmap_File_Head.zzHotY    = ToS (&buffer[0x06]);
  Bitmap_File_Head.bfOffs    = ToL (&buffer[0x08]);

  if (!ReadOK (fd, buffer, 4))
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  Bitmap_File_Head.biSize    = ToL (&buffer[0x00]);

  /* What kind of bitmap is it? */

  if (Bitmap_File_Head.biSize == 12) /* OS/2 1.x ? */
    {
      if (!ReadOK (fd, buffer, 8))
        {
          g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                       _("Error reading BMP file header from '%s'"),
                       gimp_filename_to_utf8 (filename));
          return -1;
        }

      Bitmap_Head.biWidth   = ToS (&buffer[0x00]);       /* 12 */
      Bitmap_Head.biHeight  = ToS (&buffer[0x02]);       /* 14 */
      Bitmap_Head.biPlanes  = ToS (&buffer[0x04]);       /* 16 */
      Bitmap_Head.biBitCnt  = ToS (&buffer[0x06]);       /* 18 */
      Bitmap_Head.biCompr   = 0;
      Bitmap_Head.biSizeIm  = 0;
      Bitmap_Head.biXPels   = Bitmap_Head.biYPels = 0;
      Bitmap_Head.biClrUsed = 0;
      Bitmap_Head.biClrImp  = 0;
      Bitmap_Head.masks[0]  = 0;
      Bitmap_Head.masks[1]  = 0;
      Bitmap_Head.masks[2]  = 0;
      Bitmap_Head.masks[3]  = 0;

      memset(masks, 0, sizeof(masks));
      Maps = 3;
    }
  else if (Bitmap_File_Head.biSize == 40) /* Windows 3.x */
    {
      if (!ReadOK (fd, buffer, 36))
        {
          g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                       _("Error reading BMP file header from '%s'"),
                       gimp_filename_to_utf8 (filename));
          return -1;
        }

      Bitmap_Head.biWidth   = ToL (&buffer[0x00]);      /* 12 */
      Bitmap_Head.biHeight  = ToL (&buffer[0x04]);      /* 16 */
      Bitmap_Head.biPlanes  = ToS (&buffer[0x08]);       /* 1A */
      Bitmap_Head.biBitCnt  = ToS (&buffer[0x0A]);      /* 1C */
      Bitmap_Head.biCompr   = ToL (&buffer[0x0C]);      /* 1E */
      Bitmap_Head.biSizeIm  = ToL (&buffer[0x10]);      /* 22 */
      Bitmap_Head.biXPels   = ToL (&buffer[0x14]);      /* 26 */
      Bitmap_Head.biYPels   = ToL (&buffer[0x18]);      /* 2A */
      Bitmap_Head.biClrUsed = ToL (&buffer[0x1C]);      /* 2E */
      Bitmap_Head.biClrImp  = ToL (&buffer[0x20]);      /* 32 */
      Bitmap_Head.masks[0]  = 0;
      Bitmap_Head.masks[1]  = 0;
      Bitmap_Head.masks[2]  = 0;
      Bitmap_Head.masks[3]  = 0;

      Maps = 4;
      memset(masks, 0, sizeof(masks));

      if (Bitmap_Head.biCompr == BI_BITFIELDS)
        {
          if (!ReadOK (fd, buffer, 3 * sizeof (guint32)))
            {
              g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                           _("Error reading BMP file header from '%s'"),
                           gimp_filename_to_utf8 (filename));
              return -1;
            }

          Bitmap_Head.masks[0] = ToL(&buffer[0x00]);
          Bitmap_Head.masks[1] = ToL(&buffer[0x04]);
          Bitmap_Head.masks[2] = ToL(&buffer[0x08]);
         ReadChannelMasks (&Bitmap_Head.masks[0], masks, 3);
        }
      else
        switch (Bitmap_Head.biBitCnt)
          {
          case 32:
            masks[0].mask     = 0x00ff0000;
            masks[0].shiftin  = 16;
            masks[0].max_value= (gfloat)255.0;
            masks[1].mask     = 0x0000ff00;
            masks[1].shiftin  = 8;
            masks[1].max_value= (gfloat)255.0;
            masks[2].mask     = 0x000000ff;
            masks[2].shiftin  = 0;
            masks[2].max_value= (gfloat)255.0;
            masks[3].mask     = 0xff000000;
            masks[3].shiftin  = 24;
            masks[3].max_value= (gfloat)255.0;
            break;
         case 24:
            masks[0].mask     = 0xff0000;
            masks[0].shiftin  = 16;
            masks[0].max_value= (gfloat)255.0;
            masks[1].mask     = 0x00ff00;
            masks[1].shiftin  = 8;
            masks[1].max_value= (gfloat)255.0;
            masks[2].mask     = 0x0000ff;
            masks[2].shiftin  = 0;
            masks[2].max_value= (gfloat)255.0;
            masks[3].mask     = 0x0;
            masks[3].shiftin  = 0;
            masks[3].max_value= (gfloat)0.0;
            break;
         case 16:
            masks[0].mask     = 0x7c00;
            masks[0].shiftin  = 10;
            masks[0].max_value= (gfloat)31.0;
            masks[1].mask     = 0x03e0;
            masks[1].shiftin  = 5;
            masks[1].max_value= (gfloat)31.0;
            masks[2].mask     = 0x001f;
            masks[2].shiftin  = 0;
            masks[2].max_value= (gfloat)31.0;
            masks[3].mask     = 0x0;
            masks[3].shiftin  = 0;
            masks[3].max_value= (gfloat)0.0;
            break;
         default:
            break;
         }
    }
  else if (Bitmap_File_Head.biSize >= 56 && Bitmap_File_Head.biSize <= 64)
    /* enhanced Windows format with bit masks */
    {
      if (!ReadOK (fd, buffer, Bitmap_File_Head.biSize - 4))
        {
          g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                       _("Error reading BMP file header from '%s'"),
                       gimp_filename_to_utf8 (filename));
          return -1;
        }

      Bitmap_Head.biWidth   =ToL (&buffer[0x00]);       /* 12 */
      Bitmap_Head.biHeight  =ToL (&buffer[0x04]);       /* 16 */
      Bitmap_Head.biPlanes  =ToS (&buffer[0x08]);       /* 1A */
      Bitmap_Head.biBitCnt  =ToS (&buffer[0x0A]);       /* 1C */
      Bitmap_Head.biCompr   =ToL (&buffer[0x0C]);       /* 1E */
      Bitmap_Head.biSizeIm  =ToL (&buffer[0x10]);       /* 22 */
      Bitmap_Head.biXPels   =ToL (&buffer[0x14]);       /* 26 */
      Bitmap_Head.biYPels   =ToL (&buffer[0x18]);       /* 2A */
      Bitmap_Head.biClrUsed =ToL (&buffer[0x1C]);       /* 2E */
      Bitmap_Head.biClrImp  =ToL (&buffer[0x20]);       /* 32 */
      Bitmap_Head.masks[0]  =ToL (&buffer[0x24]);       /* 36 */
      Bitmap_Head.masks[1]  =ToL (&buffer[0x28]);       /* 3A */
      Bitmap_Head.masks[2]  =ToL (&buffer[0x2C]);       /* 3E */
      Bitmap_Head.masks[3]  =ToL (&buffer[0x30]);       /* 42 */

      Maps = 4;
      ReadChannelMasks (&Bitmap_Head.masks[0], masks, 4);
    }
  else
    {
      GdkPixbuf* pixbuf = gdk_pixbuf_new_from_file(filename, NULL);

      if (pixbuf)
        {
          gint32 layer_ID;

          image_ID = gimp_image_new (gdk_pixbuf_get_width (pixbuf),
                                     gdk_pixbuf_get_height (pixbuf),
                                     GIMP_RGB);

          layer_ID = gimp_layer_new_from_pixbuf (image_ID, _("Background"),
                                                 pixbuf,
                                                 100.,
                                                 GIMP_NORMAL_MODE, 0, 0);
          g_object_unref (pixbuf);

          gimp_image_set_filename (image_ID, filename);
          gimp_image_insert_layer (image_ID, layer_ID, -1, -1);

          return image_ID;
        }
      else
        {

          g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                       _("Error reading BMP file header from '%s'"),
                       gimp_filename_to_utf8 (filename));
          return -1;
        }
    }

  /* Valid bit depth is 1, 4, 8, 16, 24, 32 */
  /* 16 is awful, we should probably shoot whoever invented it */

  switch (Bitmap_Head.biBitCnt)
    {
    case 1:
    case 2:
    case 4:
    case 8:
    case 16:
    case 24:
    case 32:
      break;
    default:
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  /* There should be some colors used! */

  ColormapSize =
    (Bitmap_File_Head.bfOffs - Bitmap_File_Head.biSize - 14) / Maps;

  if ((Bitmap_Head.biClrUsed == 0) && (Bitmap_Head.biBitCnt <= 8))
    ColormapSize = Bitmap_Head.biClrUsed = 1 << Bitmap_Head.biBitCnt;

  if (ColormapSize > 256)
    ColormapSize = 256;

  /* Sanity checks */

  if (Bitmap_Head.biHeight == 0 || Bitmap_Head.biWidth == 0)
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  /* biHeight may be negative, but G_MININT32 is dangerous because:
     G_MININT32 == -(G_MININT32) */
  if (Bitmap_Head.biWidth < 0 ||
      Bitmap_Head.biHeight == G_MININT32)
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  if (Bitmap_Head.biPlanes != 1)
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  if (Bitmap_Head.biClrUsed > 256)
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  /* protect against integer overflows caused by malicious BMPs */
  /* use divisions in comparisons to avoid type overflows */

  if (((guint64) Bitmap_Head.biWidth) > G_MAXINT32 / Bitmap_Head.biBitCnt ||
      ((guint64) Bitmap_Head.biWidth) > (G_MAXINT32 / ABS (Bitmap_Head.biHeight)) / 4)
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   _("'%s' is not a valid BMP file"),
                   gimp_filename_to_utf8 (filename));
      return -1;
    }

  /* Windows and OS/2 declare filler so that rows are a multiple of
   * word length (32 bits == 4 bytes)
   */

  rowbytes= ((Bitmap_Head.biWidth * Bitmap_Head.biBitCnt - 1) / 32) * 4 + 4;

#ifdef DEBUG
  printf ("\nSize: %u, Colors: %u, Bits: %u, Width: %u, Height: %u, "
          "Comp: %u, Zeile: %u\n",
          Bitmap_File_Head.bfSize,
          Bitmap_Head.biClrUsed,
          Bitmap_Head.biBitCnt,
          Bitmap_Head.biWidth,
          Bitmap_Head.biHeight,
          Bitmap_Head.biCompr,
          rowbytes);
#endif

  if (Bitmap_Head.biBitCnt <= 8)
    {
#ifdef DEBUG
      printf ("Colormap read\n");
#endif
      /* Get the Colormap */
      if (!ReadColorMap (fd, ColorMap, ColormapSize, Maps, &Grey))
        return -1;
    }

  fseek (fd, Bitmap_File_Head.bfOffs, SEEK_SET);

  /* Get the Image and return the ID or -1 on error*/
  image_ID = ReadImage (fd,
                        Bitmap_Head.biWidth,
                        ABS (Bitmap_Head.biHeight),
                        ColorMap,
                        Bitmap_Head.biClrUsed,
                        Bitmap_Head.biBitCnt,
                        Bitmap_Head.biCompr,
                        rowbytes,
                        Grey,
                        masks,
                        error);

  if (image_ID < 0)
    return -1;

  if (Bitmap_Head.biXPels > 0 && Bitmap_Head.biYPels > 0)
    {
      /* Fixed up from scott@asofyet's changes last year, njl195 */
      gdouble xresolution;
      gdouble yresolution;

      /* I don't agree with scott's feeling that Gimp should be
       * trying to "fix" metric resolution translations, in the
       * long term Gimp should be SI (metric) anyway, but we
       * haven't told the Americans that yet  */

      xresolution = Bitmap_Head.biXPels * 0.0254;
      yresolution = Bitmap_Head.biYPels * 0.0254;

      gimp_image_set_resolution (image_ID, xresolution, yresolution);
    }

  if (Bitmap_Head.biHeight < 0)
    gimp_image_flip (image_ID, GIMP_ORIENTATION_VERTICAL);

  return image_ID;
}

static gint32
ReadImage (FILE                  *fd,
           gint                   width,
           gint                   height,
           guchar                 cmap[256][3],
           gint                   ncols,
           gint                   bpp,
           gint                   compression,
           gint                   rowbytes,
           gboolean               grey,
           const Bitmap_Channel  *masks,
           GError               **error)
{
  guchar             v, n;
  GimpPixelRgn       pixel_rgn;
  gint               xpos = 0;
  gint               ypos = 0;
  gint32             image;
  gint32             layer;
  GimpDrawable      *drawable;
  guchar            *dest, *temp, *buffer;
  guchar             gimp_cmap[768];
  gushort            rgb;
  glong              rowstride, channels;
  gint               i, i_max, j, cur_progress, max_progress;
  gint               total_bytes_read;
  GimpImageBaseType  base_type;
  GimpImageType      image_type;
  guint32            px32;

  if (! (compression == BI_RGB ||
      (bpp == 8 && compression == BI_RLE8) ||
      (bpp == 4 && compression == BI_RLE4) ||
      (bpp == 16 && compression == BI_BITFIELDS) ||
      (bpp == 32 && compression == BI_BITFIELDS)))
    {
      g_set_error (error, G_FILE_ERROR, G_FILE_ERROR_FAILED,
                   "%s",
                   _("Unrecognized or invalid BMP compression format."));
      return -1;
    }

  /* Make a new image in GIMP */

  switch (bpp)
    {
    case 32:
    case 24:
    case 16:
      base_type = GIMP_RGB;
      if (masks[3].mask != 0)
      {
         image_type = GIMP_RGBA_IMAGE;
         channels = 4;
      }
      else
      {
         image_type = GIMP_RGB_IMAGE;
         channels = 3;
      }
      break;

    case 8:
    case 4:
    case 1:
      if (grey)
        {
          base_type = GIMP_GRAY;
          image_type = GIMP_GRAY_IMAGE;
        }
      else
        {
          base_type = GIMP_INDEXED;
          image_type = GIMP_INDEXED_IMAGE;
        }

      channels = 1;
      break;

    default:
      g_message (_("Unsupported or invalid bitdepth."));
      return -1;
    }

  if ((width < 0) || (width > GIMP_MAX_IMAGE_SIZE))
    {
      g_message (_("Unsupported or invalid image width: %d"), width);
      return -1;
    }

  if ((height < 0) || (height > GIMP_MAX_IMAGE_SIZE))
    {
      g_message (_("Unsupported or invalid image height: %d"), height);
      return -1;
    }

  image = gimp_image_new (width, height, base_type);
  layer = gimp_layer_new (image, _("Background"),
                          width, height,
                          image_type, 100, GIMP_NORMAL_MODE);

  gimp_image_set_filename (image, filename);

  gimp_image_insert_layer (image, layer, -1, 0);
  drawable = gimp_drawable_get (layer);

  /* use g_malloc0 to initialize the dest buffer so that unspecified
     pixels in RLE bitmaps show up as the zeroth element in the palette.
  */
  dest      = g_malloc0 (drawable->width * drawable->height * channels);
  buffer    = g_malloc (rowbytes);
  rowstride = drawable->width * channels;

  ypos = height - 1;  /* Bitmaps begin in the lower left corner */
  cur_progress = 0;
  max_progress = height;

  switch (bpp)
    {
    case 32:
      {
        while (ReadOK (fd, buffer, rowbytes))
          {
            temp = dest + (ypos * rowstride);
            for (xpos= 0; xpos < width; ++xpos)
              {
                px32 = ToL(&buffer[xpos*4]);
                *(temp++)= (guchar)((px32 & masks[0].mask) >> masks[0].shiftin);
                *(temp++)= (guchar)((px32 & masks[1].mask) >> masks[1].shiftin);
                *(temp++)= (guchar)((px32 & masks[2].mask) >> masks[2].shiftin);
                if (channels > 3)
                  *(temp++)= (guchar)((px32 & masks[3].mask) >> masks[3].shiftin);
              }
            if (ypos == 0)
              break;
            --ypos; /* next line */
            cur_progress++;
            if ((cur_progress % 5) == 0)
              gimp_progress_update ((gdouble) cur_progress /
                                    (gdouble) max_progress);
          }

        if (channels == 4)
          {
            gboolean  has_alpha = FALSE;

            /* at least one pixel should have nonzero alpha */
            for (ypos = 0; ypos < height; ypos++)
              {
                temp = dest + (ypos * rowstride);
                for (xpos = 0; xpos < width; xpos++)
                  {
                    if (temp[3])
                      {
                        has_alpha = TRUE;
                        break;
                      }
                    temp += 4;
                  }
                if (has_alpha)
                  break;
              }

            /* workaround unwanted behaviour when all alpha pixels are zero */
            if (!has_alpha)
              {
                for (ypos = 0; ypos < height; ypos++)
                  {
                    temp = dest + (ypos * rowstride);
                    for (xpos = 0; xpos < width; xpos++)
                      {
                        temp[3] = 255;
                        temp += 4;
                      }
                  }
              }
          }
      }
      break;

    case 24:
      {
        while (ReadOK (fd, buffer, rowbytes))
          {
            temp = dest + (ypos * rowstride);
            for (xpos= 0; xpos < width; ++xpos)
              {
                *(temp++)= buffer[xpos * 3 + 2];
                *(temp++)= buffer[xpos * 3 + 1];
                *(temp++)= buffer[xpos * 3];
              }
            if (ypos == 0)
              break;
            --ypos; /* next line */
            cur_progress++;
            if ((cur_progress % 5) == 0)
              gimp_progress_update ((gdouble) cur_progress /
                                    (gdouble) max_progress);
          }
      }
      break;

    case 16:
      {
        while (ReadOK (fd, buffer, rowbytes))
          {
            temp = dest + (ypos * rowstride);
            for (xpos= 0; xpos < width; ++xpos)
              {
                rgb= ToS(&buffer[xpos * 2]);
                *(temp++) = (guchar)(((rgb & masks[0].mask) >> masks[0].shiftin) * 255.0 / masks[0].max_value + 0.5);
                *(temp++) = (guchar)(((rgb & masks[1].mask) >> masks[1].shiftin) * 255.0 / masks[1].max_value + 0.5);
                *(temp++) = (guchar)(((rgb & masks[2].mask) >> masks[2].shiftin) * 255.0 / masks[2].max_value + 0.5);
                if (channels > 3)
                  *(temp++) = (guchar)(((rgb & masks[3].mask) >> masks[3].shiftin) * 255.0 / masks[3].max_value + 0.5);
              }
            if (ypos == 0)
              break;
            --ypos; /* next line */
            cur_progress++;
            if ((cur_progress % 5) == 0)
              gimp_progress_update ((gdouble) cur_progress /
                                    (gdouble) max_progress);
          }
      }
      break;

    case 8:
    case 4:
    case 1:
      {
        if (compression == 0)
          /* no compression */
          {
            while (ReadOK (fd, &v, 1))
              {
                for (i = 1; (i <= (8 / bpp)) && (xpos < width); i++, xpos++)
                  {
                    temp = dest + (ypos * rowstride) + (xpos * channels);
                    *temp=( v & ( ((1<<bpp)-1) << (8-(i*bpp)) ) ) >> (8-(i*bpp));
                    if (grey)
                      *temp = cmap[*temp][0];
                  }
                if (xpos == width)
                  {
                    fread(buffer, rowbytes - 1 - (width * bpp - 1) / 8, 1, fd);
                    if (ypos == 0)
                      break;
                    ypos--;
                    xpos = 0;

                    cur_progress++;
                    if ((cur_progress % 5) == 0)
                      gimp_progress_update ((gdouble) cur_progress /
                                            (gdouble) max_progress);
                  }
                if (ypos < 0)
                  break;
              }
            break;
          }
        else
          {
            /* compressed image (either RLE8 or RLE4) */
            while (ypos >= 0 && xpos <= width)
              {
                if (!ReadOK (fd, buffer, 2))
                  {
                    g_message (_("The bitmap ends unexpectedly."));
                    break;
                  }

                if ((guchar) buffer[0] != 0)
                  /* Count + Color - record */
                  {
                    /* encoded mode run -
                         buffer[0] == run_length
                         buffer[1] == pixel data
                    */
                    for (j = 0;
                         ((guchar) j < (guchar) buffer[0]) && (xpos < width);)
                      {
#ifdef DEBUG2
                        printf("%u %u | ",xpos,width);
#endif
                        for (i = 1;
                             ((i <= (8 / bpp)) &&
                              (xpos < width) &&
                              ((guchar) j < (unsigned char) buffer[0]));
                             i++, xpos++, j++)
                          {
                            temp = dest + (ypos * rowstride) + (xpos * channels);
                            *temp = (buffer[1] &
                                     (((1<<bpp)-1) << (8 - (i * bpp)))) >> (8 - (i * bpp));
                            if (grey)
                              *temp = cmap[*temp][0];
                          }
                      }
                  }
                if (((guchar) buffer[0] == 0) && ((guchar) buffer[1] > 2))
                  /* uncompressed record */
                  {
                    n = buffer[1];
                    total_bytes_read = 0;
                    for (j = 0; j < n; j += (8 / bpp))
                      {
                        /* read the next byte in the record */
                        if (!ReadOK (fd, &v, 1))
                          {
                            g_message (_("The bitmap ends unexpectedly."));
                            break;
                          }
                        total_bytes_read++;

                        /* read all pixels from that byte */
                        i_max = 8 / bpp;
                        if (n - j < i_max)
                          {
                            i_max = n - j;
                          }

                        i = 1;
                        while ((i <= i_max) && (xpos < width))
                          {
                            temp =
                              dest + (ypos * rowstride) + (xpos * channels);
                            *temp = (v >> (8-(i*bpp))) & ((1<<bpp)-1);
                            if (grey)
                              *temp = cmap[*temp][0];
                            i++;
                            xpos++;
                          }
                      }

                    /* absolute mode runs are padded to 16-bit alignment */
                    if (total_bytes_read % 2)
                      fread(&v, 1, 1, fd);
                  }
                if (((guchar) buffer[0] == 0) && ((guchar) buffer[1]==0))
                  /* Line end */
                  {
                    ypos--;
                    xpos = 0;

                    cur_progress++;
                    if ((cur_progress % 5) == 0)
                      gimp_progress_update ((gdouble) cur_progress /
                                            (gdouble)  max_progress);
                  }
                if (((guchar) buffer[0]==0) && ((guchar) buffer[1]==1))
                  /* Bitmap end */
                  {
                    break;
                  }
                if (((guchar) buffer[0]==0) && ((guchar) buffer[1]==2))
                  /* Deltarecord */
                  {
                    if (!ReadOK (fd, buffer, 2))
                      {
                        g_message (_("The bitmap ends unexpectedly."));
                        break;
                      }
                    xpos += (guchar) buffer[0];
                    ypos -= (guchar) buffer[1];
                  }
              }
            break;
          }
      }
      break;

    default:
      g_assert_not_reached ();
      break;
    }

  fclose (fd);
  if (bpp <= 8)
    for (i = 0, j = 0; i < ncols; i++)
      {
        gimp_cmap[j++] = cmap[i][0];
        gimp_cmap[j++] = cmap[i][1];
        gimp_cmap[j++] = cmap[i][2];
      }

  gimp_progress_update (1.0);

  gimp_pixel_rgn_init (&pixel_rgn, drawable,
                       0, 0, drawable->width, drawable->height, TRUE, FALSE);
  gimp_pixel_rgn_set_rect (&pixel_rgn, dest,
                           0, 0, drawable->width, drawable->height);

  if ((!grey) && (bpp<= 8))
    gimp_image_set_colormap (image, gimp_cmap, ncols);

  gimp_drawable_flush (drawable);
  gimp_drawable_detach (drawable);
  g_free (dest);

  return image;