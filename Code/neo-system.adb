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
package body Neo.Command.System
  is pragma Source_File_Name("neo-system.ads");
  --------------------
  -- Implementation --
  --------------------
    package body Implementation
      is separate;
  ----------
  -- Test --
  ----------
    procedure Test
      is
      begin
        Put_Title(Localize("SYSTEM TEST"));
        Put_Line(Localize("Version: ")  & Enumerated_System'Wide_Image(Get_Version));
        Put_Line(Localize("Username: ") & """" & Get_Username & """");
        Put_Line(Localize("Application bit size: ") & Integer_4_Signed'Wide_Image(WORD_SIZE));
        Put_Line(Localize("System bit size: ") & Integer_4_Positive'Wide_Image(Get_Bit_Size));
        Put_Line(Localize("Supports AVX feature: ") & Boolean'Wide_Image(Is_Feature_Supported(REQUIREMENTS_FOR_AVX)));
        if Get_Version in Enumerated_Windows_System'range then
          Put_Line(Localize("Launching task manager..."));
          Execute_Application("taskmgr");
        elsif Get_Version in Enumerated_Linux_System'range then
          Put_Line(Localize("Launching ???..."));
          --Execute_Application("???");
        elsif Get_Version in Enumerated_Macintosh_System'range then
          Put_Line(Localize("Launching ???..."));
          --Execute_Application("???");
        end if;
        Put_Line(Localize("Opening ") & "google.com...");
        Open_Webpage("http://www.google.com");
      end Test;
  --------------------------
  -- Is_Feature_Supported --
  --------------------------
    function Is_Feature_Supported(
      Feature_Requirements : in Record_Feature_Requirements)
      return Boolean
      is
      Current_System : Enumerated_System := Get_Version;
      begin
        if Current_System in Enumerated_Linux_System'range then
          return Current_System >= Feature_Requirements.Minimum_Linux;
        elsif Current_System in Enumerated_Windows_System'range then
          return Current_System >= Feature_Requirements.Minimum_Windows;
        elsif Current_System in Enumerated_Macintosh_System'range then
          return Current_System >= Feature_Requirements.Minimum_Macintosh;
        end if;
        return False;
      end Is_Feature_Supported;
  ------------------
  -- Get_Bit_Size --
  ------------------
    function Get_Bit_Size
      return Integer_4_Positive
      is
      begin
        return Implementation.Get_Bit_Size;
      exception
        when Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_BIT_SIZE));
          return WORD_SIZE;
      end Get_Bit_Size;
  -----------------
  -- Get_Version --
  -----------------
    function Get_Version
      return Enumerated_System
      is
      begin
        return Implementation.Get_Version;
      exception
        when Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_VERSION));
          return Unknown_System;
      end Get_Version;
  ------------------
  -- Get_Username --
  ------------------
    function Get_Username
      return String_2
      is
      begin
        return Implementation.Get_Username;
      exception
        when Call_Failure =>
          Put_Debug_Line(Localize(FAILED_GET_USERNAME));
          return DEFAULT_USERNAME;
      end Get_Username;
  ---------------------------
  -- Put_Last_Error_Number --
  ---------------------------
    procedure Put_Last_Error_Number
      is
      begin
        Put_Debug_Line(Localize("System error number: ") & Trim(Integer_4_Unsigned'wide_image(Implementation.Get_Last_Error_Number), Both));
      end Put_Last_Error_Number;
  ------------------
  -- Open_Webpage --
  ------------------
    procedure Open_Webpage(
      Path : in String_2)
      is
      begin
        Implementation.Open_Webpage(Path);
      exception
        when others =>
          Put_Debug_Line(Localize(FAILED_OPEN_WEBPAGE) & Path);
      end Open_Webpage;
  -------------------------
  -- Execute_Application --
  -------------------------
    procedure Execute_Application(
      Executable_Path : in String_2;
      Do_Fullscreen   : in Boolean := False)
      is
      begin
        Implementation.Execute_Application(Executable_Path, Do_Fullscreen);
      exception
        when others =>
          Put_Debug_Line(Localize(FAILED_EXECUTE_APPLICATION) & Executable_Path);
      end Execute_Application;
  end Neo.Command.System;

