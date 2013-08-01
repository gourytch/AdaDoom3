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
  is
  -------------------
  -- Discrete_Item --
  -------------------
    generic
      type Type_To_Vary
        is private;
    package Discrete_Item
      is
        --------------
        procedure Set(
        --------------
          Item  : in out Record_Specific_Variable;
          Value : in     Type_To_Vary)
          is
          begin
            Item.Data.Set(Value);
            Item.Value := Type_To_Vary'wide_image(Item.Data.Get);
          end Set;
        -------------
        function Get(
        -------------
          Item : in Record_Specifics_Variable)
          return Type_To_Vary
          is
          begin
            return Item.Data.Get;
          end Get;
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
        ----------------------------
        overriding procedure Adjust(
        ----------------------------
          Item : in out Record_Specific_Variable)
          is
          begin
            -----------------
            Try_Number_Parse:
            -----------------
              begin
                Item.Data.Set(Type_To_Vary(Float_8_Real'value(Item.Value)));
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
          end Adjust;
      end Discrete_Item;
  ----------
  -- Test --
  ----------
    procedure Test
      is
      begin
        Put_Title(Localize("COMMAND TEST"));
      end Test;
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
  ----------------
  -- Initialize --
  ----------------
    procedure Initalize
      is
      begin
      end Initialize;
    --------------------------------
    overriding procedure Initialize(
    --------------------------------
      Item : in out Record_Specifics)
      is
      begin
        Insert(Variables, Item'access, Item.Name);
      end Initialize;
    --------------------------------
    overriding procedure Initialize(
    --------------------------------
      Item : in out Record_Command)
      is
      begin
        Insert(Table, Item'access, Item.Name);
      end Initialize;
  --------------
  -- Finalize --
  --------------
    procedure Finalize
      is
      begin
      end Finalize;
    ------------------------------
    overriding procedure Finalize(
    ------------------------------
      Item : in out Record_Specifics)
      is
      begin
        Remove(Variables, Item.Name);
      end Finalize;
    ------------------------------
    overriding procedure Finalize(
    ------------------------------
      Item : in out Record_Command)
      is
      begin
        Remove(Table, Item.Name);
      end Finalize;
  end Neo.Command;
