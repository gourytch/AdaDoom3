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
  Ada.Containers.Hashed_Maps,
  Ada.Strings.Wide_Unbounded.Wide_Hash,
package Neo.Command
  is
  ---------------
  -- Constants --
  ---------------
    VALUES_NOT_SETTABLE : constant String_2 := "NOT SETTABLE";
    VALUES_BOOLEAN      : constant String_2 := "TRUE, FALSE";
    NO_DESCRIPTION      : constant String_2 := "No description...";
  ---------------
  -- Accessors --
  ---------------
    type Not_Null_Access_Procedure_Command
      is not null access procedure(
        Parameters : in Array_String_2_Unbounded);
  -------------
  -- Records --
  -------------
    type Record_Command(
      Name        : String_2_Unbounded;
      Command     : Not_Null_Access_Procedure_Command;
      Description : String_2_Unbounded := To_String_2_Unbounded(NO_DESCRIPTION))
      is new Ada.Finaliztion.Controlled
      with null record;
    type Record_Specifics(
      Name        : String_2_Unbounded;
      Description : String_2_Unbounded := To_String_2_Unbounded(NO_DESCRIPTION))
      is new Ada.Finalization.Controlled
      with record
        Value                           : String_2_Unbounded := NULL_STRING_2_UNBOUNDED;
        Is_User_Created                 : Boolean            := False;
        Is_User_Settable                : Boolean            := True;
        Is_Catalogged                   : Boolean            := True;
        Is_Restricted                   : Boolean            := False;
        Is_Sent_From_Servers            : Boolean            := False;
        Is_Synced_From_Server_To_Client : Boolean            := False;
        Is_Console_Only                 : Boolean            := False;
      end record;
  -----------------
  -- Subprograms --
  -----------------
    procedure Test;
    procedure Initalize;
    procedure Finalize;
    procedure Handle(
      Input : in String_2);
  --------------
  -- Packages --
  --------------
    generic
      type Type_To_Vary
        is (<>);
    package Discrete_Item
      is
        type Record_Specific_Variable(
          Initial : Type_To_Vary := Initial'first)
          is new Tagged_Record_Specifics
          with private;
        procedure Set(
          Item  : in out Record_Specific_Variable;
          Value : in     Type_To_Vary);
        function Get(
          Item : in Record_Specifics_Variable)
          return Type_To_Vary;
      private
        protected type Protected_Type_To_Vary(
          Initial : Type_To_Vary)
          is
            function Get
              return Type_To_Vary;
            procedure Set(
              Item : in Type_To_Vary);
          private
            Current : Type_To_Vary := Inital;
          end Protected_Type_To_Vary;
        type Record_Specific_Variable(
          Initial : Type_To_Vary := Initial'first)
          is new Tagged_Record_Specifics
          with record
            Data : Protected_Type_To_Vary(Initial);
          end record;
        overriding procedure Adjust(
          Item : in out Record_Specific_Variable);
      end Discrete_Item;
    package Item_Boolean
      is new Discrete_Item(Boolean);
    package Item_Real
      is new Discrete_Item(Float_8_Real);
    package Item_Integer
      is new Discrete_Item(Integer_4_Signed);
    package Item_Positive
      is new Discrete_Item(Integer_4_Positive);
    package Item_Natural
      is new Discrete_Item(Integer_4_Natural);
--------
private:
--------
  ---------------
  -- Constants --
  ---------------
    NO_SUCH_VARIABLE_OR_COMMAND : constant String_2 := "No such variable or command matches input!";
    FAILED_TO_SET_VARIABLE      : constant String_2 := "Failed to set ";
    TOO_MANY_STATEMENTS         : constant String_2 := " too many statements!";
    TOO_FEW_STATEMENTS          : constant String_2 := " too few statements!";
  ---------------
  -- Accessors --
  ---------------
    type Not_Null_Access_Record_Command
      is not null access all Record_Command;
    type Not_Null_Access_Record_Specifics
      is not null access all Record_Specifics;
  --------------
  -- Packages --
  --------------
    package Hashed_Record_Command
      is new Ada.Containers.Hashed_Maps(
        Key_Type        => String_2_Unbounded,
        Element_Type    => Not_Null_Access_Record_Command,
        Hash            => Ada.Strings.Wide_Unbounded.Wide_Hash,
        Equivalent_Keys => "=");
      use Hashed_Record_Command;
    package Hashed_Record_Specifics
      is new Ada.Containers.Hashed_Maps(
        Key_Type        => String_2_Unbounded,
        Element_Type    => Not_Null_Access_Record_Specifics,
        Hash            => Ada.Strings.Wide_Unbounded.Wide_Hash,
        Equivalent_Keys => "=");
      use Hashed_Record_Specifics;
  ---------------
  -- Variables --
  ---------------
    Input     : Array_Record_Data;
    Table     : Hashed_Record_Command.Map;
    Variables : Hashed_Record_Specifics.Map;
  -----------------
  -- Subprograms --
  -----------------
    overriding procedure Initialize(
      Item : in out Record_Command);
    overriding procedure Initialize(
      Item : in out Record_Specifics);
    overriding procedure Finalize(
      Item : in out Record_Command);
    overriding procedure Finalize(
      Item : in out Record_Specifics);
  end Neo.Command;
