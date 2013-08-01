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
  Interfaces,
  Interfaces.C,
  Ada.Command_Line;
use
  System,
  Interfaces,
  Interfaces.C,
  Ada.Command_Line;
generic
  with
    procedure Handle_Graphics;
package Neo.Command.System.Window
  is pragma Source_File_Name("neo-window.ads");
  ---------------
  -- Constants --
  ---------------
    VARIABLE_PREFIX : constant String_2 := "win_";
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Window_State
      is(
      Multi_Monitor_State,
      Fullscreen_State,
      Windowed_State);
  --------------
  -- Packages --
  --------------
    package Item_State
      is new Discrete_Item(Enumerated_State);
  ---------------
  -- Variables --
  ---------------
    State : Item_State.Variable(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "state"),
      Description => To_String_2_Unbounded("Change window state: MULTI_MONITOR_STATE, FULLSCREEN_STATE, WINDOWED_STATE"),
      Initial     => Fullscreen_State);
    Gamma_Red : Item_Natural.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "red"),
      Description => To_String_2_Unbounded("Gamma red correction"));
    Gamma_Blue : Item_Natural.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "blue"),
      Description => To_String_2_Unbounded("Gamma blue correction"));
    Gamma_Green : Item_Natural.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "green"),
      Description => To_String_2_Unbounded("Gamma green correction"));
    Refreashes_Per_Second : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "hz"),
      Description => To_String_2_Unbounded("Screen refreshes per second"),
      Initial     => 15);
    Multi_Samples : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "multi"),
      Description => To_String_2_Unbounded("Multi-samples"),
      Initial     => 1);
    Aspect_Wide_Horizontal : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "widehorz"),
      Description => To_String_2_Unbounded("Windowed mode minimum narrow aspect ratio horizontal"),
      Initial     => 9);
    Aspect_Wide_Vertical : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "widevert"),
      Description => To_String_2_Unbounded("Windowed mode minimum wide aspect ratio vertical),
      Initial     => 17);
    Aspect_Narrow_Horizontal : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "narrowhorz"),
      Description => To_String_2_Unbounded("Windowed mode minimum narrow aspect ratio horizontal"),
      Initial     => 1);
    Aspect_Narrow_Vertical : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "narrowvert"),
      Description => To_String_2_Unbounded("Windowed mode minimum narrow aspect ratio vertical"),
      Initial     => 1);
    Height : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "height"),
      Description => To_String_2_Unbounded("Windowed mode height"),
      Initial     => 480);
    Width : Item_Positive.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "width"),
      Description => To_String_2_Unbounded("Windowed mode width"),
      Initial     => 640);
    X : Item_Integer.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "x"),
      Description => To_String_2_Unbounded("Windowed mode X coordinate"));
    Y : Item_Integer.Variable :=(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "y"),
      Description => To_String_2_Unbounded("Windowed mode Y coordinate"));
    Is_Iconized : Item_Boolean.Variable(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "minimize"),
      Description => To_String_2_Unbounded("Make window minimized: " & VALUES_BOOLEAN),
      Initial     => False) :=(
        Is_Catalogged => False,
        others        => <>);
    Is_In_Menu_Mode : Item_Boolean.Variable(
      Name        => To_String_2_Unbounded(VARIABLE_PREFIX & "menumode"),
      Description => To_String_2_Unbounded("Poll if the window has taken control of the mouse: " & VALUES_NOT_SETTABLE),
      Initial     => True) :=(
        Is_Catalogged    => False,
        Is_User_Settable => False,
        others           => <>);
  -----------------
  -- Subprograms --
  -----------------
    procedure Test;
    procedure Finalize;
    procedure Take_Control;
    procedure Run(
      Title                       : in String_2;
      Icon_Path                   : in String_2;
      Cursor_Path                 : in String_2;
      Do_Allow_Multiple_Instances : in Boolean := False);
-------
private
-------
  ---------------
  -- Constants --
  ---------------
    MINIMUM_DIMENSION_X : constant Integer_4_Signed := 256;
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Window_Change
      is(
      Fullscreen_Change,
      Windowed_Change,
      Iconic_Change);
    type Enumerated_Resize
      is(
      Left_Resize,
      Right_Resize,
      Top_Resize,
      Bottom_Resize,
      Top_Left_Resize,
      Top_Right_Resize,
      Bottom_Right_Resize,
      Bottom_Left_Resize);
  -------------
  -- Records --
  -------------
    type Record_Window_Border
      is record
        Left   : Integer_4_Signed := 0;
        Top    : Integer_4_Signed := 0;
        Right  : Integer_4_Signed := 0;
        Bottom : Integer_4_Signed := 0;
      end record;
    type Record_Monitor
      is Record
        Work_Area : Record_Window_Border := <>;
        Desktop   : Record_Window_Border := <>;
      end record;
  ------------
  -- Arrays --
  ------------
    type Array_Record_Auxiliary_Graphics_Card
      is array (Integer_4_Positive range <>)
      of Record_Monitor;
  ---------------
  -- Accessors --
  ---------------
    type Access_Array_Record_Monitor
      is access all Array_Record_Monitor;
  ---------------
  -- Variables --
  ---------------
    Data   : Protected_Data;
    Center : array(1..2) of Integer_4_Signed := (others => 0);
  -----------
  -- Tasks --
  -----------
    task type Task_Multi_Monitor_Window
      is
        entry Initialize(
          I : in Integer_4_Positive);
        entry Finalize;
      end Task_Multi_Monitor_Window;
  -----------------
  -- Subprograms --
  -----------------
    procedure Handle_Finalization;
    procedure Handle_Activation(
      Do_Activate     : in Boolean;
      Do_Detect_Click : in Boolean;
      X               : in Integer_4_Signed;
      Y               : in Integer_4_Signed);
    procedure Handle_State_Change(
      Change : in Enumerated_Window_Change);
    procedure Handle_Window_Move(
      Window_X : in Integer_4_Signed;
      Window_Y : in Integer_4_Signed;
      Screen_X : in Integer_4_Signed;
      Screen_Y : in Integer_4_Signed);
    function Handle_Resize(
      Resize_Location : in Enumerated_Resize;
      Current_Screen  : in Record_Window_Border)
      return Record_Window_Border;
  --------------------
  -- Implementation --
  --------------------
    generic
      with
        procedure Handle_Finalization;
      with
        procedure Handle_Activation(
          Do_Activate     : in Boolean;
          Do_Detect_Click : in Boolean;
          X               : in Integer_4_Signed;
          Y               : in Integer_4_Signed);
      with
        procedure Handle_State_Change(
          Change : in Enumerated_Window_Change);
      with
        procedure Handle_Window_Move(
          Window_X : in Integer_4_Signed;
          Window_Y : in Integer_4_Signed;
          Screen_X : in Integer_4_Signed;
          Screen_Y : in Integer_4_Signed);
      with
        function Handle_Resize(
          Resize_Location : in Enumerated_Resize;
          Current_Screen  : in Record_Window_Border)
          return Record_Window_Border;
    package Implementation
      is
        procedure Initialize(
          Class_Name  : in String_2;
          Icon_Path   : in String_2;
          Cursor_Path : in String_2);
        procedure Finalize;
        procedure Initialize_Multi_Monitor(
          Monitors : in Array_Record_Monitor);
        procedure Finalize_Multi_Monitor;
        procedure Adjust(
          X             : in Integer_4_Signed;
          Y             : in Integer_4_Signed;
          Title         : in String_2;
          Width         : in Integer_4_Positive;
          Height        : in Integer_4_Positive;
          Do_Fullscreen : in Boolean);
        function Handle_Events(
          Index : in Integer_4_Natural := 0)
          return Boolean;
        procedure Get_Screen_Information(
          Bits_Per_Pixel : in out Integer_4_Positive;
          Native_Width   : in out Integer_4_Positive;
          Native_Height  : in out Integer_4_Positive);
        function Get_Window_Border
          return Record_Window_Border;
        function Get_Screen_Border
          return Record_Window_Border;
        function Get_Monitors
          return Array_Record_Monitor;
        function Is_Only_Instance(
          Name : in String_2)
          return Boolean;
        procedure Iconize;
        procedure Set_Mouse_Position(
          X : in Integer_4_Signed;
          Y : in Integer_4_Signed);
        procedure Hide_Mouse(
          Do_Hide            : in Boolean;
          Do_Ignore_Titlebar : in Boolean := False);
        procedure Set_Custom_Mouse(
          Do_Restore_System_Mouse : in Boolean := False);
        procedure Move_Topmost_Windows_Out_Of_The_Way;
      end Implementation;
    package Instantiation
      is new Implementation(
        Handle_Finalization => Handle_Finalization,
        Handle_Activation   => Handle_Activation,
        Handle_State_Change => Handle_State_Change,
        Handle_Window_Move  => Handle_Window_Move,
        Handle_Resize       => Handle_Resize);
  end Neo.Command.System.Window;
