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
  Ada.Unchecked_Deallocation;
package Neo.Command.System.Text.Console
  is pragma pragma Source_File_Name("neo-text-console.ads");
  ---------------
  -- Constants --
  ---------------
    DEFAULT_TITLE : constant String_2 := " Console";
  ----------------
  -- Exceptions --
  ----------------
    Empty_Is_Okay_Message : Exception;
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Icon
      is(
      No_Icon,
      Warning_Icon,
      Information_Icon,
      Error_Icon);
    type Enumerated_Buttons
      is(
      Yes_No_Buttons,
      Okay_Button,
      Okay_Cancel_Buttons,
      Retry_Cancel_Buttons);
  -----------------
  -- Subprograms --
  -----------------
    procedure Test;
    procedure Spawn(
      Title : in String_2 := NAME & Localize(DEFAULT_TITLE));
    procedure Set_Alert(
      Status : in Boolean);
    function Is_Alerting
      return Boolean;
    function Is_Open
      return Boolean;
    function Is_Okay(
      Title   : in String_2;
      Message : in String_2;
      Buttons : in Enumerated_Buttons := Okay_Button;
      Icon    : in Enumerated_Icon    := No_Icon)
      return Boolean;
-------
private
-------
  -----------
  -- Tasks --
  -----------
    task type Task_Execution
      is
        entry Initialize(
          Icon_Path : in String_2;
          Title     : in String_2);
      end Task_Console;
  ---------------
  -- Accessors --
  ---------------
    type Access_Task_Execution
      is access all Task_Execution;
  -------------
  -- Records --
  -------------
    type Record_Button
      is record
        Message : String_2(1..4)   := (others => NULL_CHARACTER_2);
        Action  : Access_Procedure := null;
      end record;
  -----------------
  -- Subprograms --
  -----------------
    procedure Finalize
      is new Ada.Unchecked_Deallocation(Task_Execution, Access_Task_Execution);
    procedure Send_Catalog;
    procedure Save_Catalog;
    procedure Copy_Catalog;
  ---------------
  -- Constants --
  ---------------
    PREFERRED_CATALOG_HEIGHT_IN_LINES : constant Integer_4_Unsigned_C         := 120;
    PREFERRED_FONT_HEIGHT_IN_INCHES   : constant Float_4_Positive             := 0.08;
    COLOR_BACKGROUND                  : constant Record_Color                 := COLOR_NAVY_BLUE;
    COLOR_TEXT                        : constant Record_Color                 := COLOR_YELLOW;
    LABEL_CATALOG                     : constant String_2                     := "Catalog";
    LABEL_ERROR                       : constant String_2                     := "Error";
    LABEL_INPUT_ENTRY                 : constant String_2                     := "Input";
    FAILED_IS_OKAY                    : constant String_2                     := "Failed is okay!";
    FAILED_SET_ALERT                  : constant String_2                     := "Alert! Failed to start system alert!";
    FAILED_SPAWN_CONSOLE              : constant String_2                     := "Failed to spawn console!";
    FAILED_CONSOLE_ALREADY_SPAWNED    : constant String_2                     := "Failed to spawn console because it is already open!";
    CONSOLE_BUTTONS                   : constant array(1..3) of Record_Button :=(
      ("Copy", Copy_Catalog'access),
      ("Save", Save_Catalog'access),
      ("Send", Send_Catalog'access),
      ("Quit", null)); -- A null Access_Procedure should create an exit button
  ---------------
  -- Variables --
  ---------------
    Console      : Access_Task_Console;
    Alert_Status : Protected_Status;
  --------------------
  -- Implementation --
  --------------------
    package Implementation
      is
        procedure Run_Console(
          Icon_Path : in String_2;
          Title     : in String_2);
        procedure Set_Alert(
          Status : in Boolean);
        function Is_Okay(
          Title   : in String_2;
          Message : in String_2;
          Buttons : in Enumerated_Buttons;
          Icon    : in Enumerated_Icon)
          return Boolean;
      end Implementation;
  end Neo.Command.System.Text.Console;
