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
package body Neo.File
  is
  --------------------------
  -- Get_Possible_Formats --
  --------------------------
    procedure Get_Possible_Formats(
      Path    : in String_2;
      Formats : in Array_Record_Format)
      return Array_Integer_4_Signed
      is
      type Vector_Enumerated_Format
        is new Ada.Containers.Vector;
      Header    : String_1(1..8) := (others => NULL_CHARACTER_1);
      Extension : String_2       := Get_Extension(Path);
      Matching_Formats   : Vector_Enumerated_Format;
      begin
        for I in FORMATS'range loop
          if FORMATS(I).Extensions /= null then
            for J in FORMATS(I).Extensions'range loop
              exit when To_String_2_Unbounded(FORMATS(I).Extensions(J)) = To_String_2_Unbounded(Extension);
            end loop;
          end if;
          if I = FORMATS'last then
            Put_Debug_Line(Localize(WARN_ITEM_EXTENSION_NOT_KNOWN));
          end if;
        end loop;
        if
        String_1'read(image.stream, Signature);
        for I in FORMATS'range loop
          if FORMATS(I).Signatures = null then
            Matching_Formats.Add_Back(I);
          else
            for J in FORMATS(I).Signatures'range loop
              if To_String_2_Unbounded(FORMATS(I).Signatures(J)) = To_String_2_Unbounded(Signature) then
                Matching_Formats.Add_Front(I);
                exit;
              end if;
            end loop;
          end if;
        end loop;
        if Size(Matching_Formats) = 0 then
          raise Unknown_Format;
        end if;
      end Get_Possible_Formats;
  end Neo.File;
