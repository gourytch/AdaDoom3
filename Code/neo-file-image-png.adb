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
  GID,
  GID.Decoding_PNG;
use
  GID,
  GID.Decoding_PNG;
separate(Neo.File.Image)
package body PNG
  is
  ----------
  -- Load --
  ----------
    overriding function Load(
      Tag         : in PNG.Tag;
      Path        : in String_2;
      Start_Frame : in Integer_4_Positive := 1;
      For_Frames  : in Integer_4_Natural  := 0)
      return Array_Record_Graphic
      is
      File          : File_Type;
      Image         : Image_Descriptor;
      next_frame    : Day_Duration := 0.0;
      current_frame : Day_Duration := 0.0;
      up_name       : String       := To_Upper(name);
      begin
        Open(File, In_File, Path);
        Image.Stream          := From'Unchecked_Access;
        Image.Detailed_Format := To_Bounded_String("PNG");
        Image.Format          := GID.PNG;
        GID.Decoding_PNG.Load(Image);
        Close(File);
        return GID.Create_Result(Image);
      end Load;
  ----------
  -- Save --
  ----------
    overriding procedure Save(
      Tag     : in PNG.Tag;
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      is
      begin
        raise Unimplemented_Feature;
      end Save;
  end PNG;
