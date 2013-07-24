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
  ----------
  -- Load --
  ----------
    overriding function Load(
      Tag         : in TGA.Tag;
      Path        : in String_2;
      Start_Frame : in Integer_4_Positive := 1;
      For_Frames  : in Integer_4_Natural  := 0)
      return Array_Record_Graphic
      is
      begin
        raise Unimplemented_Feature;
      end Load;
  ----------
  -- Save --
  ----------
    overriding procedure Save(
      Tag     : in TGA.Tag;
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      is
      begin
        raise Unimplemented_Feature;
      end Save;
  end TGA;
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
      -- Width              : Integer_2_Unsigned := 1;
      -- Height             : Integer_2_Unsigned := 1;
      -- Run_Length_Encoded :
      -- Colors             :
      -- begin
        -- Integer_1_Unsigned'read(File'stream, Start_Location);
        -- Integer_1_Unsigned'read(File'stream, Junk);
        -- Integer_1_Unsigned'read(File'stream, Run_Length_Encoded);
        -- for I in 1..9 loop
          -- Integer_1_Unsigned'read(File'stream, Junk);
        -- end loop;
        -- Integer_2_Unsigned'read(File'stream, );
        -- Integer_2_Unsigned'read(File'stream, );
        -- Integer_1_Unsigned'read(File'stream, );
        -- if Enumerated_Colors'pos(Bits_Per_Pixel) in Monochrome_Colors..Sixteen_Colors then
          -- raise Currupt;
        -- end if;
        -- for I in 1..length + 1 loop
          -- Integer_1_Unsigned'read(File'stream, Junk);
        -- end loop;
        -- -- load palette?
        -- --------------
        -- Build_Graphic:
        -- --------------
          -- declare
          -- type Integer_Color
            -- is mod Colors'val**2;
          -- Current : Integer_Color := Integer_Color'first;
          -- Graphic : Record_Graphic(Truevision_Graphics_Adapter_Format) :=(
            -- Pixels            => new Array_Record_Pixel(1..Width, 1..Height),
            -- Run_Length_Encode => Run_Length_Encoded = 1,
            -- Colors            => Colors);
          -- begin
            -- for Y in Graphic.Pixels.Color'range(1) loop
              -- ---------
              -- Row_Loop:
              -- ---------
                -- for X in Graphic.Pixels.Color'range(2) loop
                -- Integer_Color'stream(File, Current);
                -- if Graphic.Run_Length_Encoded then
                  -- if Current < 16#F0# then
                    -- Unique_Colors := True;
                    -- rleID := rleID + 1;
                  -- else
                    -- Unique_Colors := False;
                    -- rleID := rleID - 16#F0#;
                    -- fread(pColors, sizeof(unsigned char) * channels, 1, pFile);
                  -- end if;
                -- end if;
                -- while rleID > 0 loop
                  -- if Graphic.Run_Length_Encoded and Unique_Colors then
                    -- fread(pColors, sizeof(unsigned char) * channels, 1, pFile);
                  -- else
                    -- rleID := 0;
                  -- end if;
                  -- Graphic.Pixels.Color(X, Y) :=(
                    -- Pixels =>
                      -- Blue =>
                        -- Integer_1_Unsigned(Shift_Right(Integer_4_Unsigned(Current),
                          -- Integer_Color'size / Graphic.Color'val / Byte'size * 3)),
                      -- Green =>
                        -- Integer_1_Unsigned(Shift_Right(Shift_Left(Integer_4_Unsigned(Current),
                          -- Integer_Color'size / Graphic.Color'val / Byte'size),
                          -- Integer_Color'size / Graphic.Color'val / Byte'size * 3)),
                      -- Red =>
                        -- Integer_1_Unsigned(Shift_Right(Shift_Left(Integer_4_Unsigned(Current),
                          -- Integer_Color'size / Graphic.Color'val / Byte'size * 2),
                          -- Integer_Color'size / Graphic.Color'val / Byte'size * 3));
                    -- Alpha =>(
                      -- if Colors = Alpha_With_Two_Hundred_Fifty_Six_Per_Colors then
                        -- Integer_1_Unsigned(Shift_Right(Shift_Left(Integer_4_Unsigned(Current),
                          -- Integer_Color'size / Graphic.Color'val / Byte'size * 3),
                          -- Integer_Color'size / Graphic.Color'val / Byte'size * 3))
                      -- else
                        -- Byte'last));
                  -- rleID := rleID - 1;
                  -- colorsRead += channels;
                -- end loop;
                -- if Palette /= null then

                -- end if;
              -- end loop Row_loop;
          -- end loop;
          -- return(Graphic);
        -- end Build_Graphic;
    -- end Load;
  -- end TGA;








