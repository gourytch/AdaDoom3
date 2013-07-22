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
  --Neo.File.Image;
  --Neo.File.Mesh.Map;
  --Neo.File.Mesh.Model;
  Neo.Command.System;
  --Neo.Command.System.Input;
  --Neo.Command.System.Sound;
  --Neo.Command.System.Window;
  Neo.Command.System.Memory;
  --Neo.Command.System.Network;
  Neo.Command.System.Text;
  Neo.Command.System.Text.Console;
  Neo.Command.System.Processor;
generic
  Name       : String_2;
  Icons      : Array_String_2;
  Initialize : Access_Procedure;
  Run        : Access_Procedure;
  Finalize   : Access_Procedure;
  Test       : Access_Procedure := null;
package Neo.Engine
  is
  -----------------
  -- Subprograms --
  -----------------
    procedure Run;
-------
private
-------
  ---------------
  -- Constants --
  ---------------
    START_STAGE_ONE   : constant String_2 := "Ready?";
    START_STAGE_TWO   : constant String_2 := "Set";
    START_STAGE_THREE : constant String_2 := "Run!";
    EXCEPTION_PREFIX  : constant String_2 := "Exception:";
    EXCEPTION_TITLE   : constant String_2 := " Error!";
  -----------
  -- Tasks --
  -----------
    task body Task_Loop
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
  end Neo.Engine
