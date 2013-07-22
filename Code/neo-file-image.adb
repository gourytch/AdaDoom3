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
package body Neo.File.Image
  is
  ----------
  -- Test --
  ----------
    procedure Test
      is
      begin
        Put_Title("IMAGE TEST");
        --
      end Test;
  ----------
  -- Save --
  ----------
    procedure Save(
      Path    : in String_2;
      Graphic : in Record_Graphic)
      is
      begin
        Save(Path, (Graphic));
      end Save;
    ---------------
    procedure Save(
    ---------------
      Path     : in String_2;
      Graphics : in Array_Record_Graphic)
      is
      Format : Enumerated_Format := Get_Specifics(Graphics(1)).Specifics.Format;
      begin
        for I in Graphics'range loop
          if Get_Specifics(Graphics(I)).Specifics.Format /= Format then
            raise Attempted_To_Save_Under_Multiple_Formats;
          end if;
        end loop;
        Save(Find(Format)(1), Path, Data);
      end Save;
  ----------
  -- Load --
  ----------
    function Load(
      Path  : in String_2;
      Frame : in Integer_4_Positive := 1)
      return Record_Graphic
      is
      begin
        return Load(Path, Frame)(1);
      end Load;
    --------------
    function Load(
    --------------
      Path        : in String_2;
      Start_Frame : in Integer_4_Positive := 1)
      return Array_Record_Graphic
      is
      function Get_Possible_Image_Formats
        is new Get_Possible_Formats(Enumerated_Format, FORMATS);
      Formats : Array_Format := Get_Possible_Image_Formats;
      begin
        for I in Formats'range loop
          ------------
          Search_Tags:
          ------------
            declare
            Tags : Array_Tag := Find(Formats(I));
            begin
              for J in Tags'range loop
                if I = Formats'last and J = Tags'last then
                  return Load(Tags(J), Path);
                end if;
                --------
                Attempt:
                --------
                  begin
                    return Load(Tags(J), Path);
                  exception
                    when others =>
                      null;
                  end Attempt;
              end loop;
            end Search_Tags;
        end loop;
      end Load;
  ---------------------
  -- Implementations --
  ---------------------
  --
  -- To add an implementation...
  --
  -- 1 Create a new enumerated entry in the Enumerated_Formats type and
  --   fill out information in the private section of the specification
  --
  -- 2 Add a separate package that creates a child of Neo.File.Image.Tag and
  --   overrides Get and optionally Load and/or Save
  --
  -- 3 In Tag's Find function, add a new instance of your separate package's
  --   tagged type (e.g. new GIF.tag)
  --
  -- 4 Create a body for your separate package filling out the subprograms and
  --   names outlinned in neo-file-image-archetype.adb
  --
    package FITS
      is
        type FITS.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in FITS.Tag)
          return Graphics_Interchange_Format;
        overriding function Load(
          Tag         : in FITS.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in FITS.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end FITS;
    package PCX
      is
        type PCX.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in PCX.Tag)
          return Bit_Map_Format;
        overriding function Load(
          Tag         : in PCX.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in PCX.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end PCX;
    package BMP
      is
        type BMP.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in BMP.Tag)
          return Bit_Map_Format;
        overriding function Load(
          Tag         : in BMP.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in BMP.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end BMP;
    package TIFF
      is
        type TIFF.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in TIFF.Tag)
          return Tagged_Image_File_Format;
        overriding function Load(
          Tag         : in TIFF.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in TIFF.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end TIFF;
    package GIF
      is
        type GIF.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in GIF.Tag)
          return Graphics_Interchange_Format;
        overriding function Load(
          Tag         : in GIF.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in GIF.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end GIF;
    package PPM
      is
        type PPM.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in PPM.Tag)
          return Graphics_Interchange_Format;
        overriding function Load(
          Tag         : in PPM.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in PPM.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end PPM;
    package PNG
      is
        type PNG.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in PNG.Tag)
          return Portable_Network_Graphics_Format;
        overriding function Load(
          Tag         : in PNG.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in PNG.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end PNG;
    package TGA
      is
        type TGA.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in TGA.Tag)
          return Truevision_Graphics_Adapter_Format;
        overriding function Load(
          Tag         : in TGA.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in TGA.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end TGA;
    package JPEG
      is
        type JPEG.Tag
          is tagged Neo.File.Image.Tag
          with null record;
        overriding function Get(
          Tag : in JPEG.Tag)
          return Joint_Photographic_Experts_Group_Format;
        overriding function Load(
          Tag         : in JPEG.Tag;
          Path        : in String_2;
          Start_Frame : in Integer_4_Signed := 0)
          return Array_Record_Data;
        overriding procedure Save(
          Tag  : in JPEG.Tag;
          Path : in String_2;
          Data : in Array_Record_Data);
      end JPEG;
    package body FITS
      is separate;
    package body PCX
      is separate;
    package body TIFF
      is separate;
    package body GIF
      is separate;
    package body PPM
      is separate;
    package body BMP
      is separate;
    package body PNG
      is separate;
    package body JPEG
      is separate;
    package body TGA
      is separate;
  ---------
  -- Tag --
  ---------
    function Find(
      Format : in Enumerated_Format)
      return Array_Tag
      is
      type Vector_Enumerated_Format
        is new Ada.Containers.Vector();
      Format  : Enumerated_Format := Get(Path);
      Results : Vector_Enumerated_Format;
      Formats : array(1..7) of Tag :=(
        new GIF.Tag, new PNG.Tag, new JPEG.Tag, new JP2.Tag, new PCX.Tag, -- Add a new implementation instance here
        new TGA.Tag, new BMP.Tag, new TIFF.Tag, new PPM.Tag, new FITS.Tag);
      begin
        for I in Formats'range loop
          if Format = Get(Formats(I)) then
            Results.Add(Get(Formats(I)));
          elsif Size(Results) < 1 and then I = Formats'last then
            raise Unsupported_Format;
          end if;
        end loop;
        return To_Array(Results);
      end Find;
    -------------
    function Get(
    -------------
      Tag : in Tag)
      return Enumerated_Format
      is
      begin
        raise Unimplemented_Feature;
      end Get;
    ---------------
    procedure Save(
    ---------------
      Tag  : in Tag;
      Path : in String_2;
      Data : in Record_Data)
      is
      begin
        raise Unimplemented_Feature;
      end Save;
    --------------
    function Load(
    --------------
      Tag  : in Tag;
      Path : in String_2)
      return Array_Record_Data
      is
      begin
        raise Unimplemented_Feature;
      end Load;
  end Neo.File.Image;
