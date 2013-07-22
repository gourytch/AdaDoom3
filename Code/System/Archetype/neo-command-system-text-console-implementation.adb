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
separate(Neo.Command.System.Exception_Handling)
package body Implementation
  is
  ---------------
  -- Set_Alert --
  ---------------
    procedure Set_Alert(
      Status : in Boolean)
      is
      begin
        raise Unimplemented_Feature;
      end Set_Alert;
  -------------
  -- Is_Okay --
  -------------
    function Is_Okay(
      Title        : in String_2;
      Message      : in String_2;
      Buttons      : in Enumerated_Buttons;
      Icon         : in Enumerated_Icon)
      return Boolean
      is
      begin
        raise Unimplemented_Feature;
        return False;
      end Is_Okay;
  -----------------
  -- Run_Console --
  -----------------
    procedure Run_Console(
      Icon_Path : in String_2;
      Title     : in String_2)
      is
      begin
        raise Unimplemented_Feature;
      end Run_Console;
  end Implementation;
