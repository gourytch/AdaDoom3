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
  Ada.Exceptions,
  Ada.Calendar,
  Ada.Calendar.Formatting,
  Neo,
  Neo.Foundation.Output,
  Neo.Foundation.Data_Types,
  Neo.System,
  Neo.System.Text,
  Neo.System.Memory,
  Neo.System.Processor,
  Neo.System.Exception_Handling;--,
  --Neo.System.Network,
  --Neo.System.Window,
  --Neo.System.Input;
use
  Ada.Exceptions,
  Ada.Calendar,
  Ada.Calendar.Formatting,
  Neo,
  Neo.Foundation.Output,
  Neo.Foundation.Data_Types;
procedure Main
  is
  ---------------
  -- Constants --
  ---------------
    DO_DEBUG          : constant Boolean  := True;
    DO_TEST           : constant Boolean  := True;
    DO_TEST_DEBUGGING : constant Boolean  := False;
  -----------
  -- Tasks --
  -----------
    task type Task_Secondary
      is
        entry Run;
        entry Finalize;
      end Task_Secondary;
  ---------------
  -- Variables --
  ---------------
    Start_Time_Image       : String_2                                   := To_String_2(Image(Clock));
    Did_Finalize_Secondary : Boolean                                    := False;
    Exceptions             : array(1..2) of Exception_Occurrence_Access := (others => null);
    Secondary              : Task_Secondary;
  --------------------
  -- Task_Secondary --
  --------------------
    task body Task_Secondary
      is
      begin
        -----------
        accept Run;
        -----------
        ----------
        Game_Loop:
        ----------
          begin
            --Neo.Game.Initialize;
            loop
              select
                ----------------
                accept Finalize;
                ----------------
                exit;
              else
                if DO_TEST then
                  delay 5.0;
                  Put_Line("Surprise!");
                else
                  null; -- Secondary execution goes here
                end if;
              end select;
            end loop;
          exception
            when Error: others =>
              Exceptions(2):= Save_Occurrence(Error);
          end Game_Loop;
        if Exceptions(2) /= null then
          --Neo.System.Window.Finalize; -- Should kill primary execution (Neo.System.Window.Run)
          ----------------
          accept Finalize;
          ----------------
        end if;
      end Task_Secondary;
  -----
  begin
  -----
    for I in Start_Time_Image'range loop
      Start_Time_Image(I) :=(
        case Start_Time_Image(I) is
          when ':'    => '-',
          when ' '    => '_',
          when others => Start_Time_Image(I));
    end loop;
    Set_Put_Debug(DO_DEBUG);
    Set_Catalog_Path(DIRECTORY_CATALOGS & Start_Time_Image & '_' & Neo.System.Get_Username & EXTENSION_CATALOG);
    ----
    Run:
    ----
      begin
        Put_Debug(L("Ready, "));
        --Neo.System.Input.Initialize;
        --Neo.System.Network.Initialize;
        Neo.System.Processor.Initialize;
        Put_Debug_Line(L("set"));
        Secondary.Run;
        Put_Debug_Line(L("Go!"));
        if not DO_TEST then
          null; -- Normal primary execution, most likely a call to Neo.System.Window.Run
        else
          if DO_TEST_DEBUGGING then
            Neo.Foundation.Output.Test;
          end if;
          Neo.System.Test;
          Neo.System.Text.Test;
          Neo.System.Memory.Test;
          Neo.System.Processor.Test;
          Neo.System.Exception_Handling.Test;
        end if;
        Secondary.Finalize;
        Put_Debug_Line(L("Goodbye"));
        Did_Finalize_Secondary := True;
        --Neo.System.Network.Finalize;
        --Neo.System.Input.Finalize;
        --Set_Put_Debug(False);
        --Set_Put(False);
      exception
        when Error: others =>
          if not Did_Finalize_Secondary then
            Secondary.Finalize;
          end if;
          Exceptions(1) := Save_Occurrence(Error);
      end Run;
    for I in Exceptions'range loop
      if Exceptions(I) /= null then
        Put_Line(L("Error: ") & To_String_2(Exception_Name(Exceptions(I).all)));
        Put_Line(To_String_2(Exception_Message(Exceptions(I).all)));
        if Exception_Name(Exceptions(I).all) = "NEO.SYSTEM.SYSTEM_CALL_FAILURE" then
          Neo.System.Put_Last_Error_Number;
        end if;
      end if;
    end loop;
    if
    (Exceptions(1) /= null or Exceptions(2) /= null) and then
    Neo.System.Exception_Handling.Is_Okay(
      Title   => NAME & L(" Error!"),
      Buttons => Neo.System.Exception_Handling.Yes_No_Buttons,
      Icon    => Neo.System.Exception_Handling.Error_Icon,
      Message => NAME & L(" failed and cannot continue. Would you like to view more information?"))
    then
      Neo.System.Exception_Handling.Spawn_Console(DIRECTORY_ASSETS & "ICO/icon.ico");
    end if;
    Neo.Foundation.Output.Finalize;
  end Main;
