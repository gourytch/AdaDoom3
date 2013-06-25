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
package body Neo.System.Memory
  is
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
            when System_Call_Failure =>
              Put_Debug_Line(L(FAILED_LOCK));
          end Lock;
        procedure Unlock(
          Item : in out Type_To_Manage)
          is
          begin
            Implementation.Unlock(Item'address, Item'size / Byte'size);
          exception
            when System_Call_Failure =>
              Put_Debug_Line(L(FAILED_UNLOCK));
          end Unlock;
      end Manager;
  ----------
  -- Test --
  ----------
    procedure Test
      is
      State : Record_State := (others => <>); -- Get_State is called after for Put_Title, instead of here, for testing purposes
      begin
        Put_Title(L("MEMORY TEST"));
        State := Get_State_At_Launch;
        Put_Line(L("State at launch: "));
        Put_Line(L("Load: ")                       & Float_4_Percent'Wide_Image(State.Load));
        Put_Line(L("Disk total: ")                 & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Total));
        Put_Line(L("Disk available: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Available));
        Put_Line(L("Physical total: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Total));
        Put_Line(L("Physical available: ")         & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Available));
        Put_Line(L("Page file total: ")            & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Total));
        Put_Line(L("Page file available: ")        & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Available));
        Put_Line(L("Virtual total: ")              & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Total));
        Put_Line(L("Virtual available: ")          & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available));
        Put_Line(L("Virtual available extended: ") & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available_Extended));
        New_Line;
        State := Get_State;
        Put_Line(L("State currently: "));
        Put_Line(L("Load: ")                       & Float_4_Percent'Wide_Image(State.Load));
        Put_Line(L("Disk total: ")                 & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Total));
        Put_Line(L("Disk available: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Disk_Bytes_Available));
        Put_Line(L("Physical total: ")             & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Total));
        Put_Line(L("Physical available: ")         & Integer_8_Unsigned'Wide_Image(State.Number_Of_Physical_Bytes_Available));
        Put_Line(L("Page file total: ")            & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Total));
        Put_Line(L("Page file available: ")        & Integer_8_Unsigned'Wide_Image(State.Number_Of_Page_File_Bytes_Available));
        Put_Line(L("Virtual total: ")              & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Total));
        Put_Line(L("Virtual available: ")          & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available));
        Put_Line(L("Virtual available extended: ") & Integer_8_Unsigned'Wide_Image(State.Number_Of_Virtual_Bytes_Available_Extended));
        Hang_Window;
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
        when System_Call_Failure =>
          Put_Debug_Line(L(FAILED_SET_BYTE_LIMITS));
      end Set_Byte_Limits;
  ---------------
  -- Get_State --
  ---------------
    function Get_State
      return Record_State
      is
      begin
        return Implementation.Get_State;
      end Get_State;
    LAUNCH_STATE : constant Record_State := Get_State; -- Bit of a hack
  -------------------------
  -- Get_State_At_Launch --
  -------------------------
    function Get_State_At_Launch
      return Record_State
      is
      begin
        return LAUNCH_STATE;
      end Get_State_At_Launch;
  end Neo.System.Memory;

