--
--
--
--
--
--
--
-- All symbols unless surrounded by quotes (double or single) are considered illigal unless they are part
-- of the file format
--
--
--
--
--
--
--
package Neo.File.Sheet
  is
  ---------------
  -- Constants --
  ---------------
    ILLEGAL_SYMBOLS               : constant String_2       := "/,.<>;:[]{}\|_)(*&^%$#@!~`-+=";
    DELINEATING_SYMBOLS           : constant String_2       := """'`";
    SINGLE_LINE_COMMENT_PREFIXES  : constant Array_String_2 :=
      new Array_String_2(
        new String_2("//"),
        new String_2("#"),
        new String_2(";"));
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Format
      is(
      Comma_Separated_Values_Format,
      --
      -- 1967 International Business Machines
      --      http://web.archive.org/web/20120818015507/http://tools.ietf.org/html/rfc4180
      --
      Initialization_Format,
      --
      -- 1981 Microsoft
      --      http://web.archive.org/web/20130522030131/http://docs.services.mozilla.com/server-devguide/confspec.html
      --
      Configuration_Format);
      --
      -- 2003 Id Software
      --      Examples:
      --        Command Key "Value" //Comment
      --        Command "Value1" "Value2" //Comment
      --
  -------------
  -- Records --
  -------------
    type Record_Data(
      Format : Enumerated_Format := Comma_Separated_Values_Format)
      is record
        Entries : Vector_Vector_String_2;
        case Format is
          when Initialization_Format =>
            Heading : String_2_Unbounded := NULL_STRING_2_UNBOUNDED;
          when others =>
            null;
        end case;
      end record;
  ------------
  -- Arrays --
  ------------
    type Array_Record_Data
      is array(Positive range <>)
      of Record_Data;
  -----------------
  -- Subprograms --
  -----------------
    function Load(
      Path : in String_2)
      return Array_Record_Data;
    procedure Save(
      Path   : in String_2;
      Format : in Array_Record_Data);
-------
private
-------
  ---------------
  -- Constants --
  ---------------
    FORMATS : Array_Record_Format(Enumerated_Format'range) :=(
      Comma_Separated_Values_Format =>(
        Signatures => null,
        Extensions =>
          new Array_String_2(
            new String_2("CSV")),
      Initialization_Format =>(
        Signatures => null,
        Extensions =>
          new Array_String_2(
            new String_2("INI"),
            new String_2("CONF"),
            new String_2("CFG")),
      Configuration_Format =>(
        Signatures => null,
        Extensions =>
          new Array_String_2(
            new String_2("RC"),
            new String_2("CONF"),
            new String_2("CFG")));
  --------------
  -- Packages --
  --------------
    package CSV
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end CSV;
    package INI
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end INI;
    package CFG
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end CFG;
    package body CSV
      is separate;
    package body INI
      is separate;
    package body CFG
      is separate;
  --------------------
  -- Implementation --
  --------------------
    package Instantiation
      is new Implementation(
        Type_To_Handle => Neo.File.Sheet.Record_Data,
        Format         => Neo.File.Sheet.Enumerated_Format,
        Formats        => Neo.File.Sheet.FORMATS
        Operations     =>(
          Flexible_Image_Transfer_System_Format        => (CSV.Load'access, CSV.Save'access),
          Portable_Network_Graphics_Format             => (INI.Load'access, INI.Save'access),
          Joint_Photographic_Experts_Group_2000_Format => (CFG.Load'access, CFG.Save'access));
  end Neo.File.Sheet;
