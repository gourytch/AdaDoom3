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
package body FITS
  is
  ----------
  -- Load --
  ----------
    overriding function Load(
      Tag         : in FITS.Tag;
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
      Tag     : in FITS.Tag;
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      is
      begin
        raise Unimplemented_Feature;
      end Save;
  end FITS;
