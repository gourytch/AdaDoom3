--
--
--
--
--
--
--
--
-- This should be automatically generated
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
