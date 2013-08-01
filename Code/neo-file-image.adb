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
package body Neo.File.Image
  is
  ----------
  -- Test --
  ----------
    procedure Test
      is
      begin
        Put_Title(Localize("IMAGE TEST"));
        --
      end Test;
  ----------
  -- Save --
  ----------
    procedure Save(
      Path    : in String_2;
      Graphic : in Record_Graphic)
      renames Instantiation.Save;
    procedure Save(
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      renames Instantiation.Save;
  ----------
  -- Load --
  ----------
    function Load(
      Path  : in String_2)
      return Record_Graphic
      renames Instantiation.Load;
    function Load(
      Path  : in String_2)
      return Array_Record_Graphic
      renames Instantiation.Load;
  end Neo.File.Image;
