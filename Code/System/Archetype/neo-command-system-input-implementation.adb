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
separate (Neo.Command.System.Input)
generic
  with
  with
  with
package body Implementation
  is
  -------------------
  -- Set_Vibration --
  -------------------
    procedure Set_Vibration(
      Player                 : in Integer_4_Positive;
      Percent_Frequency_High : in Float_4_Percent;
      Percent_Frequency_Low  : in Float_4_Percent;
      Seconds                : in Duration)
      is
      begin
        raise Unimplemented_Feature;
      end Set_Vibration;
  ----------------------
  -- Lookup_Character --
  ----------------------
    function Lookup_Character(
      Key                                : in Enumerated_Key;
      Is_Capital_Lock_Enabled            : in Boolean;
      Is_Number_Lock_Enabled             : in Boolean;
      Is_Left_Shift_Key_Pressed          : in Boolean;
      Is_Right_Shift_Key_Pressed         : in Boolean;
      Is_Left_Control_Key_Pressed        : in Boolean;
      Is_Right_Control_Key_Pressed       : in Boolean;
      Is_Left_Alternative_Key_Pressed    : in Boolean;
      Is_Right_Alternative_Key_Pressed   : in Boolean;
      Is_Left_System_Key_Pressed         : in Boolean;
      Is_Right_System_Key_Pressed        : in Boolean;
      Is_Application_Menu_Key_Pressed    : in Boolean)
      return Character_2
      is
      begin
        raise Unimplemented_Feature;
        return NULL_CHARACTER_2;
      end Lookup_Character;
  --------------------
  -- Update_Devices --
  --------------------
    procedure Update_Devices
      is
      begin
        raise Unimplemented_Feature;
      end Initialize;
  -------------------
  -- Handle_Events --
  -------------------
    procedure Handle_Events
      is
      begin
        raise Unimplemented_Feature;
      end Poll_Devices;
  --------------
  -- Finalize --
  --------------
    procedure Finalize
      is
      begin
        raise Unimplemented_Feature;
      end Finalize;
  end Neo.System.Input.Implementation;







