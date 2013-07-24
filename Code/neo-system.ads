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
  System,
  Ada.Strings,
  Ada.Strings.Wide_Fixed
use
  System,
  Ada.Strings,
  Ada.Strings.Wide_Fixed;
package Neo.Command.System
  is pragma Source_File_Name("neo-system.ads");
  ----------------
  -- Exceptions --
  ----------------
    Call_Failure         : Exception;
    Library_Load_Failure : Exception;
    Unsupported_Feature  : Exception;
    Unsupported_API      : Exception;
  ---------------
  -- Constants --
  ---------------
    DEFAULT_USERNAME : constant String_2 := "Unnamed";
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_System
      is(
      Unknown_System,
      Linux_System,
      Linux_2_System, -- x86-64
      Linux_2_1_System,
      Linux_2_2_System,
      Linux_2_3_System,
      Linux_2_4_System,
      Linux_2_5_System,
      Linux_2_6_System,
      Linux_3_System, -- AVX
      Linux_3_1_System,
      Linux_3_2_System,
      Linux_3_3_System,
      Linux_3_4_System,
      Linux_3_5_System,
      Linux_3_6_System,
      Linux_3_7_System,
      Linux_3_8_System,
      Linux_3_9_System,
      Windows_System,
      Windows_1_System,
      Windows_1_4_System,
      Windows_1_4_A_System, -- x86-64
      Windows_1_4_B_System,
      Windows_1_4_10_A_System,
      Windows_1_4_10_B_System,
      Windows_1_4_90_System,
      Windows_2_System,
      Windows_2_5_System,
      Windows_2_5_1_System,
      Windows_2_6_System, -- Aero™
      Windows_2_6_1_System, -- AVX
      Windows_2_6_2_System,
      Macintosh_System,
      Macintosh_8_System,
      Macintosh_8_5_System, -- PowerPC
      Macintosh_8_6_System,
      Macintosh_9_System,
      Macintosh_9_1_System,
      Macintosh_9_2_System,
      Macintosh_10_System,
      Macintosh_10_1_System,
      Macintosh_10_2_System,
      Macintosh_10_3_System,
      Macintosh_10_4_System,
      Macintosh_10_5_System, -- x86-64
      Macintosh_10_6_System,
      Macintosh_10_7_System, -- AVX
      Macintosh_10_8_System);
    subtype Enumerated_Linux_System
      is Enumerated_System
      range Linux_System..Linux_3_9_System;
    subtype Enumerated_Windows_System
      is Enumerated_System
      range Windows_System..Windows_2_6_2_System;
    subtype Enumerated_Macintosh_System
      is Enumerated_System
      range Macintosh_System..Macintosh_10_8_System;
  -------------
  -- Records --
  -------------
    type Record_Feature_Requirements
      is record
        Minimum_Linux     : Enumerated_Linux_System     := Linux_System;
        Minimum_Windows   : Enumerated_Windows_System   := Windows_System;
        Minimum_Macintosh : Enumerated_Macintosh_System := Macintosh_System;
      end record;
  ----------------
  -- Suprograms --
  ----------------
    procedure Finalize;
    procedure Test;
    function Get_Version
      return Enumerated_System;
    function Get_Username
      return String_2;
    function Get_Bit_Size
      return Integer_4_Positive;
    procedure Put_Last_Error_Number;
    function Is_Feature_Supported(
      Feature_Requirements : in Record_Feature_Requirements)
      return Boolean;
    procedure Open_Webpage(
      Path : in String_2);
    procedure Execute_Application(
      Executable_Path : in String_2;
      Do_Fullscreen   : in Boolean := False);
-------
private
-------
  ---------------
  -- Constants --
  ---------------
    FAILED_EXECUTE_APPLICATION : constant String_2 := "Failed to execute: ";
    FAILED_OPEN_WEBPAGE        : constant String_2 := "Failed to open: ";
    FAILED_GET_USERNAME        : constant String_2 := "Failed to get username!";
    FAILED_GET_VERSION         : constant String_2 := "Failed to get version!";
    FAILED_GET_BIT_SIZE        : constant String_2 := "Failed to get verified bit size!";
  --------------------
  -- Implementation --
  --------------------
    package Implementation
      is
        function Get_Last_Error_Number
          return Integer_4_Unsigned;
        function Get_Bit_Size
          return Integer_4_Positive;
        function Get_Version
          return Enumerated_System;
        function Get_Username
          return String_2;
        procedure Open_Webpage(
          Path : in String_2);
        procedure Execute_Application(
          Executable_Path : in String_2;
          Do_Fullscreen   : in Boolean);
      end Implementation;
  end Neo.Command.System;

