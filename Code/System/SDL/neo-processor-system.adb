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
  Neo.Archetype;
use
  Neo.Archetype;
separate(Neo.Command.System.Processor)
package body Implementation_For_Operating_System
  is pragma Source_File_Name("neo-processor-system.adb");
  -------------------------
  -- Get_Number_Of_Cores --
  -------------------------
    function Get_Number_Of_Cores
      return Integer_8_Unsigned
      is
      begin
        raise Unimplemented_Feature;
      end Get_Number_Of_Cores;
  ---------------------
  -- Get_Clock_Ticks --
  ---------------------
    function Get_Clock_Ticks
      return Integer_8_Unsigned
      is
      begin
        raise Unimplemented_Feature;
      end Get_Clock_Ticks;
  ----------------------------
  -- Get_Speed_In_Megahertz --
  ----------------------------
    function Get_Speed_In_Megahertz
      return Integer_8_Unsigned
      is
      begin
        raise Unimplemented_Feature;
      end Get_Speed_In_Megahertz;
  end Implementation_For_Operating_System;

