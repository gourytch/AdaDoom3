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
package body Neo.Command.System.Memory
  is pragma Source_File_Name("neo-memory.adb");
  --------------------
  -- Implementation --
  --------------------
    package body Implementation
      is separate;
  -------------
  -- Manager --
  -------------
    package body Manager
      is
        procedure Lock(
          Item : in out Type_To_Manage)
          is
          begin
            Implementation.Lock(Item'address, Item'size / Byte'size);
          exception
            when Call_Failure =>
              Put_Debug_Line(Localize(FAILED_LOCK));
          end Lock;
        procedure Unlock(
          Item : in out Type_To_Manage)
          is
          begin
            Implementation.Unlock(Item'address, Item'size / Byte'size);
          exception
            when Call_Failure =>
              Put_Debug_Line(Localize(FAILED_UNLOCK));
          end Unlock;
      end Manager;
  ----------
  -- Test --
  ----------
    procedure Test
      is
      State : Record_State := (others => <>); -- Get_State is called after for Put_Title, instead of here, for testing purposes
      begin
        Put_Title(Localize("MEMORY TEST"));
        State := Get_State_At_Launch;
        Put_Line(Localize("State at launch: "));
        Put_Line(Localize("Load: ")                       & Float_4_Percent'Wide_Image(State.Load));
        Put_Line(Localize("Disk total: ")                 & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Total));
        Put_Line(Localize("Disk available: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Available));
        Put_Line(Localize("Physical total: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Total));
        Put_Line(Localize("Physical available: ")         & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Available));
        Put_Line(Localize("Page file total: ")            & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Total));
        Put_Line(Localize("Page file available: ")        & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Available));
        Put_Line(Localize("Virtual total: ")              & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Total));
        Put_Line(Localize("Virtual available: ")          & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available));
        Put_Line(Localize("Virtual available extended: ") & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available_Extended));
        New_Line;
        State := Get_State;
        Put_Line(Localize("State currently: "));
        Put_Line(Localize("Load: ")                       & Float_4_Percent'Wide_Image(State.Load));
        Put_Line(Localize("Disk total: ")                 & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Total));
        Put_Line(Localize("Disk available: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Available));
        Put_Line(Localize("Physical total: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Total));
        Put_Line(Localize("Physical available: ")         & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Available));
        Put_Line(Localize("Page file total: ")            & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Total));
        Put_Line(Localize("Page file available: ")        & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Available));
        Put_Line(Localize("Virtual total: ")              & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Total));
        Put_Line(Localize("Virtual available: ")          & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available));
        Put_Line(Localize("Virtual available extended: ") & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available_Extended));
        --Hang_Window;
      end Test;
  ---------------------
  -- Set_Byte_Limits --
  ---------------------
    procedure Set_Byte_Limits(
      Minimum : in Integer_8_Unsigned;
      Maximum : in Integer_8_Unsigned)
      is
      begin
        Implementation.Set_Byte_Limits(Minimum, Maximum);
      exception
        when Call_Failure =>
          Put_Debug_Line(Localize(FAILED_SET_BYTE_LIMITS));
      end Set_Byte_Limits;
  ---------------
  -- Get_State --
  ---------------
    function Get_State
      return Record_State
      is
      begin
        return Implementation.Get_State;
      exception
        when Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_STATE));
      end Get_State;
  end Neo.Command.System.Memory;

