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
package body Neo.Command
  is pramga Source_File_Name("neo-command.adb");
  -----------
  -- Split --
  -----------
    function Split(
      Item : in String_2_Unbounded)
      return Array_String_2_Unbounded
      is
      begin
      end Split;
  ------------------------
  -- Replace_Occurances --
  ------------------------
    function Replace_Occurances(
      Item        : in String_2;
      Occurance   : in String_2;
      Replacement : in String_2)
      return String_2
      is
      begin
      end Replace_Occurances;
  ----------
  -- Item --
  ----------
    generic
      type Type_To_Vary
        is private;
      Inital : Type_To_Vary;
    package Item
      is
        -------------------------------------
        protected body Protected_Type_To_Vary
        -------------------------------------
          is
            ------------
            function Get
            ------------
              return Type_To_Vary
              is
              begin
                return Current;
              end Get;
            --------------
            procedure Set(
            --------------
              Item : in Type_To_Vary)
              is
              begin
                Current := Item;
              end Set;
          -------
          private
          -------
            Current : Type_To_Vary := Inital;
          end Protected_Type_To_Vary;
        -------------------------
        overriding procedure Set(
        -------------------------
          Item  : in Tagged_Protected_Type_To_Vary;
          Value : in String_2)
          is
          begin
            -----------------
            Try_Number_Parse:
            -----------------
              begin
                Item.Data.Set(Type_To_Vary(Float_8_Real'value(Value)));
              exception
                when Constraint_Error => -- Invalid character in 'value string, it has to be failed input or an enumeration
                  for I in Type_To_Vary'range loop
                    if To_Upper_Case(Value) = To_Upper_Case(Type_To_Vary'wide_image(I)) then
                      Item.Data.Set(I);
                      exit;
                    elsif I = Type_To_Vary'last then
                      raise No_Such_Enumerated_Variable;
                    end if;
                  end loop;
              end Try_Number_Parse;
          exception
            when others =>
              Put_Debug_Line(Localize(FAILED_TO_SET_VARIABLE));
          end Set;
        ------------------------
        overriding function Get(
        ------------------------
          Item : in Tagged_Protected_Type_To_Vary)
          return String_2
          is
          begin
            return Type_To_Vary'wide_image(Item.Data.Get);
          end Get;
      end Item;
  ------------
  -- Handle --
  ------------
    procedure Handle(
      Input : in String_2)
      is
      Statements : Array_String_2_Unbounded := Split(Trim(To_String_2_Unbounded(Input), Both));
      begin
        if Has_Element(Table, Statements(Statemenst'first)) then
          Table(Element(Statements(Statemenst'first))).all(Statments(Statements'first + 1..Statements'last));
        elsif Has_Element(Variables, Statements(Statemenst'first) then
          if Statements'size < 2 then
            Put_Debug_Line(Localize(FAILED_TO_SET_VARIABLE & Statements(Statemenst'first) & TOO_FEW_STATEMENTS));
          elsif Statements'size > 2 then
            Put_Debug_Line(Localize(FAILED_TO_SET_VARIABLE & Statements(Statemenst'first) & TOO_MANY_STATEMENTS));
          else
            Statements(Statemenst'first).Set(Statements(Statemenst'last));
          end if;
        else
          Put_Debug_Line(Localize(NO_SUCH_VARIABLE_OR_COMMAND));
        end if;
      end Handle;
  ---------
  -- Add --
  ---------
    procedure Add(
      Name     : in String_2;
      Variable : in Tagged_Record_Specifics)
      is
      begin
        Variables.Insert(Name, Variable);
      end Add;
    --------------
    procedure Add(
    --------------
      Name    : in String_2;
      Command : in Not_Null_Access_Procedure_Command)
      is
      begin
        Table.Insert(Name, Command);
      end Add;
  ---------
  -- Get --
  ---------
    function Get(
      Name : in String_2)
      return Tagged_Record_Specifics
      is
      begin
        return Variables.Element(Name);
      end Get;
  ---------
  -- Set --
  ---------
    procedure Set(
      Name  : in String_2;
      Value : in String_2)
      is
      begin
        Variables.Element(Name).Set(Value);
      end Set;
  end Neo.Command;
