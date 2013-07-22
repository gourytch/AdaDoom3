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
    overriding function Load(
      Tag         : in BMP.Tag;
      Path        : in String_2;
      Start_Frame : in Integer_4_Positive := 1;
      For_Frames  : in Integer_4_Natural  := 0)
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
    overriding procedure Save(
      Tag     : in Archetype.Tag;
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
