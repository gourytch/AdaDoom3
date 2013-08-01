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
  Neo,
  --Neo.File.Image,
  --Neo.File.Model,
  Neo.Command.System,
  --Neo.Command.System.Input,
  --Neo.Command.System.Sound,
  --Neo.Command.System.Window,
  Neo.Command.System.Memory,
  --Neo.Command.System.Network,
  --Neo.Command.System.Network.Client,
  --Neo.Command.System.Network.Server,
  Neo.Command.System.Text,
  Neo.Command.System.Text.Console,
  Neo.Command.System.Processor;
procedure Main
  is
  ---------------
  -- Constants --
  ---------------
    DO_TEST           : constant Boolean  := True;
    START_STAGE_ONE   : constant String_2 := "Ready?";
    START_STAGE_TWO   : constant String_2 := "Set";
    START_STAGE_THREE : constant String_2 := "Run!";
    EXCEPTION_PREFIX  : constant String_2 := "Exception:";
    EXCEPTION_TITLE   : constant String_2 := " Error!";
  -----------
  -- Tasks --
  -----------
    task Task_Loop
      is
        entry Initialize;
        entry Finalize;
      end Task_Loop;
  ---------------
  -- Variables --
  ---------------
    Main_Task_Loop : Task_Loop;
  -----------------
  -- Subprograms --
  -----------------
    procedure Handle_Graphics;
    procedure Handle_Exception(
      Occurrence : in Exception_Occurrence);
  --------------
  -- Packages --
  --------------
    --package Graphics_Window
    --  is new Neo.Command.System.Window(Handle_Graphics);
  ---------------
  -- Task_Loop --
  ---------------
    task body Task_Loop
      is
      begin
        ------------------
        accept Initialize;
        ------------------
        ----
        Run:
        ----
          begin
            Put_Debug_Line(Localize(START_STAGE_THREE));
            Game.Initialize;
            if DO_TEST then
              Neo.Test;
              Neo.File.Test;
              Neo.File.Archive.Test;
              Neo.File.Image.Test;
              --Neo.File.Sound.Test;
              --Neo.File.Model.Test;
              --Neo.File.Video.Test;
              Neo.Command.Test;
              Neo.Command.System.Test;
              --Neo.Command.System.Input.Test;
              --Neo.Command.System.Sound.Test;
              Neo.Command.System.Memory.Test;
              --Neo.Command.System.Network.Test;
              Neo.Command.System.Processor.Test;
              Neo.Command.System.Text.Test;
              Neo.Command.System.Text.Console.Test;
              --Neo.Command.System.Graphics.Test;
              --Graphics_Window.Test;
            end if;
            loop
              select
                ----------------
                accept Finalize;
                ----------------
                exit;
              else
                Game.Run;
              end select;
            end loop
          exception
            when Occurrence: others =>
              Handle_Exception(Occurrence);
              --Graphics_Window.Finalize;
              ----------------
              accept Finalize;
              ----------------
          end Run;
        Game.Finalize;
      end Task_Loop;
  ----------------------
  -- Handle_Exception --
  ----------------------
    procedure Handle_Exception(
      Occurrence : in Exception_Occurrence)
      is
      begin
        Set_Error(Get_Error &
          Localize(ERROR_PREFIX) & To_String_2(Exception_Name(Occurrence)) & END_LINE &
          To_String_2(Exception_Message(Occurrence))                       & END_LINE &(
            if Exception_Name(Occurrence) = ERROR_NAME then
              Neo.Command.System.Get_Last_Error                            & END_LINE
            else
              NULL_STRING_2));
      end Handle_Exception;
  ---------------------
  -- Handle_Graphics --
  ---------------------
    procedure Handle_Graphics
      is
      begin
        null;
      end Handle_Graphics;
  begin
    Neo.Command.Initialize;
    Neo.Command.System.Text.Initialize;
    Neo.Set_Localize(Neo.Command.System.Text.Localize'access);
    ----
    Run:
    ----
      begin
        Put_Debug_Line(Localize(START_STAGE_ONE));
        -- Initialize system...
        Put_Debug_Line(Localize(START_STAGE_TWO));
        Main_Task_Loop.Initialize;
        ---------
        Finalize:
        ---------
          begin
            Graphics_Window.Run(Name, Icons);
            Main_Task_Loop.Finalize;
          exception
            when Occurrence: others =>
              Handle_Exception(Occurrence);
              Main_Task_Loop.Finalize;
          end Finalize;
        -- Finalize system...
        Put_Debug_Line(Localize(ENDING));
      exception
        when Occurrence: others =>
          Handle_Exception(Occurrence);
      end Run;
    if Get_Error /= NULL_STRING_2 then
      Put_Line(Get_Error);
      if
      not Neo.Command.System.Text.Console.Is_Open and then
      Neo.Command.System.Text.Console.Is_Okay(
        Title   => Name & Localize(ERROR_TITLE),
        Message => Name & Localize(ERROR_MESSAGE),
        Buttons => Neo.Command.System.Text.Console.Yes_No_Buttons,
        Symbol  => Neo.Command.System.Text.Console.Error_Symbol,
        Icons   => Icons)
      then
        Neo.Command.System.Text.Console.Spawn;
      end if;
      Save_Catalog(Neo.Command.System.Get_User_Name);
    end if;
  end Main;
