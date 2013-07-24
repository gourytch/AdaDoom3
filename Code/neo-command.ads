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
  is pramga Source_File_Name("neo-command.ads");
  ---------------
  -- Accessors --
  ---------------
    type Not_Null_Access_Procedure_Command
      is not null access procedure(
        Parameters : in Array_String_2_Unbounded);
  -------------
  -- Records --
  -------------
    type Tagged_Record_Specifics
      is tagged record
        Description                     : String_2_Unbounded := NULL_STRING_2_UNBOUNDED;
        Is_Restricted                   : Boolean            := False;
        Is_Sent_From_Servers            : Boolean            := False;
        Is_Synced_From_Server_To_Client : Boolean            := False;
        Is_Console_Only                 : Boolean            := False;
        Is_Catalogged                   : Boolean            := False;
        Is_User_Created                 : Boolean            := False;
        Is_User_Settable                : Boolean            := False;
      end record;
  -----------------
  -- Subprograms --
  -----------------
    procedure Test;
    procedure Handle(
      Input : in String_2);
    procedure Add(
      Name    : in String_2;
      Command : in Not_Null_Access_Procedure_Command;
    procedure Add(
      Name     : in String_2;
      Variable : in Tagged_Record_Specifics);
    function Get(
      Name : in String_2)
      return Tagged_Record_Specifics;
    procedure Set(
      Name  : in String_2;
      Value : in String_2);
  --------------
  -- Packages --
  --------------
    generic
      type Type_To_Vary
        is (<>);
      Inital : Type_To_Vary;
    package Item
      is
        protected type Protected_Type_To_Vary
          is
            function Get
              return Type_To_Vary;
            procedure Set(
              Item : in Type_To_Vary);
          private
            Current : Type_To_Vary := Inital;
          end Protected_Type_To_Vary;
        type Tagged_Protected_Type_To_Vary
          is new Tagged_Record_Specifics
          with record
            Data : Protected_Type_To_Vary;
          end record;
        overriding procedure Set(
          Item  : in Tagged_Protected_Type_To_Vary;
          Value : in String_2);
        overriding function Get(
          Item : in Tagged_Protected_Type_To_Vary)
          return String_2;
      end Item;
    package Item_Boolean
      is new Item(Variable_Boolean, NULL_VARIABLE_BOOLEAN);
    package Item_Integer
      is new Item(Variable_Integer, NULL_VARIABLE_INTEGER);
    package Item_Positive
      is new Item(Variable_Positive, NULL_VARIABLE_POSITIVE);
    package Item_Natural
      is new Item(Variable_Natural, NULL_VARIABLE_NATURAL);
    package Item_Real
      is new Item(Variable_Real, NULL_VARIABLE_REAL);
  -------------
  -- Renames --
  -------------
    subtype Variable_Boolean
      is Item_Boolean.Tagged_Protected_Type_To_Vary;
    subtype Variable_Integer
      is Item_Integer.Tagged_Protected_Type_To_Vary;
    subtype Variable_Real
      is Item_Real.Tagged_Protected_Type_To_Vary;
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
  --------------
  -- Packages --
  --------------
    package Hashed_Access_Procedure_Command
      is new Ada.Containers.Hashed_Maps(
        Key_Type        => String_2_Unbounded,
        Element_Type    => Not_Null_Access_Procedure_Command,
        Hash            => Ada.Strings.Wide_Unbounded.Wide_Hash,
        Equivalent_Keys => "=");
    package Hashed_Tagged_Record_Specifics
      is new Ada.Containers.Hashed_Maps(
        Key_Type        => String_2_Unbounded,
        Element_Type    => Tagged_Record_Specifics,
        Hash            => Ada.Strings.Wide_Unbounded.Wide_Hash,
        Equivalent_Keys => "=");
  ---------------
  -- Variables --
  ---------------
    Table     : Hashed_Access_Procedure_Command.Map;
    Variables : Hashed_Tagged_Record_Specifics.Map;
  end Neo.Command;
