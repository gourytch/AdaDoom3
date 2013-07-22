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
  Neo.Example;
use
  Neo.Example;
separate(Neo.System.Text)
package body Implementation
  is
  ------------------
  -- Get_Language --
  ------------------
    function Get_Language
      return Enumerated_Language
      is
      begin
        raise Unimplemented_Feature;
        return English_Language;
      end Get_Language;
  -------------------
  -- Set_Clipboard --
  -------------------
    procedure Set_Clipboard(
      Text : in String_2)
      is
      begin
        raise Unimplemented_Feature;
      end Set_Clipboard;
  -------------------
  -- Get_Clipboard --
  -------------------
    function Get_Clipboard
      return String_2
      is
      begin
        raise Unimplemented_Feature;
        return NULL_STRING_2;
      end Get_Clipboard;
  end Implementation;
