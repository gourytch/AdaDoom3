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
package Neo.File
  is
  ----------------
  -- Exceptions --
  ----------------
    Unknown_Format        : Exception;
    Unsupported_Subformat : Exception;
    Unsupported_Format    : Exception;
    Currupt               : Exception;
  ------------------
  -- Enumerations --
  ------------------

  -------------
  -- Records --
  -------------
    type Record_Format
      is record
        Extensions : Access_Array_String_2;
        Signatures : Access_Array_String_2;
        Comments   : Access_Array_String_2;
      end record;
  -----------------
  -- Subprograms --
  -----------------
    generic
      type Type_To_Index
        is <>;
      type Array_Type_To_Index
        is array(Positive range <>)
        of Type_To_Index;
      type Array_Record_Format
        is array(Type_To_Index range <>)
        of Record_Format;
    procedure Get_Possible_Formats(
      Path    : in String_2;
      Formats : in Array_Record_Format)
      return Array_Type_To_Index;
  end Neo.File;
