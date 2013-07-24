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
package body Neo.Command.System.Text
  is pragma Source_File_Name("neo-text.adb");
  --------------------
  -- Implementation --
  --------------------
    package body Implementation
      is separate;
  ----------
  -- Test --
  ----------
    procedure Test
      is
      begin
        Put_Title(Localize("TEXT TEST"));
        Put_Line(Localize("Language: ") & Enumerated_Language'Wide_Image(Get_Language));
        Put_Line(Get_Clipboard);
        Set_Clipboard(Localize("Yes"));
        Put_Line(Localize("But does it work? ") & Get_Clipboard & "!");
      end Test;
  ------------------
  -- Get_Language --
  ------------------
    function Get_Language
      return Enumerated_Language
      is
      begin
        return Implementation.Get_Language;
      exception
        when Call_Failure =>
          Put_Debug_Line(FAILED_GET_LANGUAGE); -- Can't localize this string
          return English_Language;
      end Get_Language;
  -------------------
  -- Get_Clipboard --
  -------------------
    function Get_Clipboard
      return String_2
      is
      begin
        return Implementation.Get_Clipboard;
      exception
        when Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_CLIPBOARD));
          return NULL_STRING_2;
      end Get_Clipboard;
  -------------------
  -- Set_Clipboard --
  -------------------
    procedure Set_Clipboard(
      Text : in String_2)
      is
      begin
        Implementation.Set_Clipboard(Text);
      exception
        when Call_Failure =>
          Put_Debug_Line(Localize(FAILED_SET_CLIPBOARD));
          null;
      end Set_Clipboard;
end Neo.Command.System.Text;
