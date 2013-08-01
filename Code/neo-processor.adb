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
package body Neo.Command.System.Processor
  is pragma Source_File_Name("neo-processor.adb");
  --------------------
  -- Implementation --
  --------------------
    package body Implementation_For_Architecture
      is separate;
    package body Implementation_For_Operating_System
      is separate;
  ----------
  -- Test --
  ----------
    procedure Test
      is
      Specifics : constant Record_Specifics := Get_Specifics;
      begin
        Put_Title(Localize("PROCESSOR TEST"));
        Set_Precision(Double_Extended_Precision);
        Set_Rounding(Nearest_Rounding);
        Check_Exceptions;
        Put_Line(Localize("Clock ticks: ") & Integer_8_Unsigned'Wide_Image(Get_Clock_Ticks));
        Put_Line(Localize("Sleep 0.1..."));
        delay 0.1;
        Put_Line(Localize("Clock ticks: ") & Integer_8_Unsigned'Wide_Image(Get_Clock_Ticks));
        Put_Line(Localize("Sleep 0.025..."));
        delay 0.025;
        Put_Line(Localize("Clock ticks: ")       & Integer_8_Unsigned'Wide_Image(Get_Clock_Ticks));
        Put_Line(Localize("Number of cores:")    & Integer_8_Unsigned'Wide_Image(Get_Number_Of_Cores));
        Put_Line(Localize("Speed in megahertz:") & Integer_8_Unsigned'Wide_Image(Get_Speed_In_Megahertz));
        Put_Line(Localize("Vendor: ")            & Enumerated_Vendor'Wide_Image(Specifics.Vendor));
        case Specifics.Vendor is
          when ARM_Licenced_Vendor =>
            if Specifics.Has_NEON then
              Put_Line(Localize("Has NEON"));
            end if;
            if Specifics.Has_Vector_Floating_Point then
              Put_Line(Localize("Has VFP"));
            end if;
          when Apple_IBM_Motorola_Vendor =>
            if Specifics.Has_Vector_Multimedia_Instructions then
              Put_Line(Localize("Has VMI"));
            end if;
            if Specifics.Has_Vector_Scalar_Instructions then
              Put_Line(Localize("Has VSI"));
            end if;
            if Specifics.Has_Altivec_Additional_Registers then
              Put_Line(Localize("Has VMX128"));
            end if;
            if Specifics.Has_Altivec then
              Put_Line(Localize("Has Altivec"));
            end if;
          when Intel_Vendor | Advanced_Micro_Devices_Vendor =>
            if Specifics.Vendor = Advanced_Micro_Devices_Vendor then
              if Specifics.Has_3DNow then
                Put_Line(Localize("Has 3DNow!"));
              end if;
              if Specifics.Has_3DNow_Supplement then
                Put_Line(Localize("Has 3DNow!+"));
              end if;
              if Specifics.Has_Streaming_SIMD_Extensions_4_Supplement then
                Put_Line(Localize("Has SSE4a"));
              end if;
              if Specifics.Has_Multi_Media_Extensions_Supplement then
                Put_Line(Localize("Has MMX+"));
              end if;
            end if;
            if Specifics.Has_Multi_Media_Extensions then
              Put_Line(Localize("Has MMX"));
            end if;
            if Specifics.Has_Fused_Multiply_Add_3 then
              Put_Line(Localize("Has FMA3"));
            end if;
            if Specifics.Has_Fused_Multiply_Add_4 then
              Put_Line(Localize("Has FMA4"));
            end if;
            if Specifics.Has_Streaming_SIMD_Extensions_1 then
              Put_Line(Localize("Has SSE"));
            end if;
            if Specifics.Has_Streaming_SIMD_Extensions_2 then
              Put_Line(Localize("Has SSE2"));
            end if;
            if Specifics.Has_Streaming_SIMD_Extensions_3 then
              Put_Line(Localize("Has SSE3"));
            end if;
            if Specifics.Has_Streaming_SIMD_Extensions_3_Supplement then
              Put_Line(Localize("Has SSSE3"));
            end if;
            if Specifics.Has_Streaming_SIMD_Extensions_4_1 then
              Put_Line(Localize("Has SSE4.1"));
            end if;
            if Specifics.Has_Streaming_SIMD_Extensions_4_2 then
              Put_Line(Localize("Has SSE4.2"));
            end if;
            if Specifics.Has_Bit_Manipulation_Extensions_1 then
              Put_Line(Localize("Has BMI1"));
            end if;
            if Specifics.Has_Bit_Manipulation_Extensions_2 then
              Put_Line(Localize("Has BMI2"));
            end if;
            if Specifics.Has_Advanced_Vector_Extensions_1 then
              Put(Localize("Has AVX"));
              if not Specifics.Has_Advanced_Vector_Extensions_Enabled then
                Put_Line(Localize(", but it's disabled"));
              else
                New_Line;
              end if;
            end if;
            if Specifics.Has_Advanced_Vector_Extensions_2 then
              Put(Localize("Has AVX2"));
              if not Specifics.Has_Advanced_Vector_Extensions_Enabled then
                if not Specifics.Has_Advanced_Vector_Extensions_1 then
                  Put_Line(Localize(", but it's disabled"));
                else
                  Put_Line(Localize(", but it's also disabled"));
                end if;
              else
                New_Line;
              end if;
            end if;
            if Specifics.Has_Context_ID_Manager then
              Put_Line(Localize("Has INVPCID"));
            end if;
            if Specifics.Has_Population_Count then
              Put_Line(Localize("Has POPCNT"));
            end if;
            if Specifics.Has_Leading_Zero_Count then
              Put_Line(Localize("Has LZCNT"));
            end if;
            if Specifics.Has_Carryless_Multiplication_Of_Two_64_Bit then
              Put_Line(Localize("Has PCLMULQDQ"));
            end if;
            if Specifics.Has_Extended_States_Enabled then
              Put_Line(Localize("Has OSXSAVE"));
            end if;
            if Specifics.Has_Half_Precision_Floating_Point_Convert then
              Put_Line(Localize("Has F16C"));
            end if;
            if Specifics.Has_High_Precision_Convert then
              Put_Line(Localize("Has CVT16"));
            end if;
            if Specifics.Has_Advanced_Encryption_Service then
              Put_Line(Localize("Has AES"));
            end if;
            if Specifics.Has_Advanced_State_Operations then
              Put_Line(Localize("Has FXSR"));
            end if;
            if Specifics.Has_Extended_Operation_Support then
              Put_Line(Localize("Has XOP"));
            end if;
            if Specifics.Has_Hyperthreading then
              Put_Line(Localize("Has HTT"));
            end if;
            if Specifics.Has_Conditional_Move then
              Put_Line(Localize("Has CMOV"));
            end if;
          when others =>
            null;
        end case;
        if Is_Stack_Empty then
          Put_Line(Localize("Stack is empty!"));
        else
          Put_Stack;
          Clear_Stack;
          if Is_Stack_Empty then
            Put_Line(Localize("Stack was cleared successfully"));
          end if;
        end if;
        Put_Stack;
      exception
        when Unsupported_Feature =>
          Put_Debug_Line(Localize("Unsupported feature!"));
      end Test;
  ----------------
  -- Initialize --
  ----------------
    procedure Initialize
      renames Implementation_For_Architecture.Initialize;
  ----------------------
  -- Check_Exceptions --
  ----------------------
    procedure Check_Exceptions
      renames Implementation_For_Architecture.Check_Exceptions;
  -----------------
  -- Clear_Stack --
  -----------------
    procedure Clear_Stack
      renames Implementation_For_Architecture.Clear_Stack;
  --------------------------
  -- Compare_And_Exchange --
  --------------------------
    function Compare_And_Exchange(
      Destination : out Integer_4_Unsigned;
      Comparand   : in  Integer_4_Unsigned;
      Item        : in  Integer_4_Unsigned)
      return Integer_4_Unsigned
      renames Implementation_For_Architecture.Compare_And_Exchange;
  --------------------
  -- Is_Stack_Empty --
  --------------------
    function Is_Stack_Empty
      return Boolean
      renames Implementation_For_Architecture.Is_Stack_Empty;
  ------------------
  -- Set_Rounding --
  ------------------
    procedure Set_Rounding(
      Rounding : in Enumerated_Rounding)
      renames Implementation_For_Architecture.Set_Rounding;
  -------------------
  -- Set_Precision --
  -------------------
    procedure Set_Precision(
      Precision : in Enumerated_Precision)
      renames Implementation_For_Architecture.Set_Precision;
  -------------------
  -- Get_Specifics --
  -------------------
    function Get_Specifics
      return Record_Specifics
      renames Implementation_For_Architecture.Get_Specifics;
  ----------------
  -- Get_Vendor --
  ----------------
    function Get_Vendor
      return Enumerated_Vendor
      renames Implementation_For_Architecture.Get_Vendor;
  ---------------------
  -- Get_Clock_Ticks --
  ---------------------
    function Get_Clock_Ticks
      return Integer_8_Unsigned
      is
      begin
        return Implementation_For_Operating_System.Get_Clock_Ticks;
      exception
        when Unsupported_Feature | Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_CLOCK_TICKS));
          return Implementation_For_Architecture.Get_Clock_Ticks;
      end Get_Clock_Ticks;
  -------------------------
  -- Get_Number_Of_Cores --
  -------------------------
    function Get_Number_Of_Cores
      return Integer_8_Unsigned
      is
      begin
        if not TRUST_COMPILER then
          return Implementation_For_Operating_System.Get_Number_Of_Cores;
        end if;
        return Integer_8_Unsigned(Number_Of_CPUs);
      exception
        when Unsupported_Feature | Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_NUMBER_OF_CORES_OS));
          -------------
          Try_Assembly:
          -------------
            declare
            begin
              return Implementation_For_Architecture.Get_Number_Of_Cores;
            exception
              when Unsupported_Feature =>
                Put_Debug_Line(Localize(FAILED_GET_NUMBER_OF_CORES_ASSEMBLY));
                return Integer_8_Unsigned(Number_Of_CPUs); -- How reliable is this?
            end Try_Assembly;
      end Get_Number_Of_Cores;
  ----------------------------
  -- Get_Speed_In_Megahertz --
  ----------------------------
    function Get_Speed_In_Megahertz
      return Integer_8_Unsigned
      is
      begin
        return Implementation_For_Operating_System.Get_Speed_In_Megahertz;
      exception
        when Unsupported_Feature | Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_SPEED_IN_MEGAHERTZ_OS));
          ---------------
          Time_Processor:
          ---------------
            declare
            Start : Integer_8_Unsigned := 0;
            begin
              Start := Get_Clock_Ticks;
              delay SECONDS_FOR_PROCESSOR_SPEED_TIMING;
              return (Get_Clock_Ticks - Start) * Integer_8_Unsigned(1.0 / SECONDS_FOR_PROCESSOR_SPEED_TIMING);
            end Time_Processor;
      end Get_Speed_In_Megahertz;
  ---------------
  -- Put_Stack --
  ---------------
    procedure Put_Stack
      renames Implementation_For_Architecture.Put_Stack;
  end Neo.Command.System.Processor;

