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
  Lumen.Image.PPM,
  Lumen.Binary.IO;
use
  Lumen.Image,
  Lumen.Image.PPM,
  Lumen.Binary.IO;
separate(Neo.File.Image)
package body PPM
  is
  ----------
  -- Load --
  ----------
    overriding function Load(
      Tag         : in PPM.Tag;
      Path        : in String_2;
      Start_Frame : in Integer_4_Positive := 1;
      For_Frames  : in Integer_4_Natural  := 0)
      return Array_Record_Graphic
      is
      File    : Binary.IO.File_Type;
      PPM_Sub : Byte_String(1..2);
      Length  : Natural := 0;
      begin
        Binary.IO.Open(File, Path);
        Binary.IO.Read(File, PPM_Sub, Length);
        Result := PPM.From_File(File, PPM_Sub);
        Binary.IO.Close(File);
        return To_Array_Record_Pixel(Result);
      end Load;
  ----------
  -- Save --
  ----------
    overriding procedure Save(
      Tag     : in PPM.Tag;
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      is
      begin
        raise Unimplemented_Feature;
      end Save;
  end PPM;
