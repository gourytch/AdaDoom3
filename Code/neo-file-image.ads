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
package Neo.File.Image
  is
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Format
      is(
      Flexible_Image_Transport_System_Format,
      --
      -- 1981
      --
      --
      Truevision_Graphics_Adapter_Format,
      --
      -- 1984 Truevision
      --      http://web.archive.org/web/20130206052029/http://www.dca.fee.unicamp.br/~martino/disciplinas/ea978/tgaffs.pdf
      --
      Personal_Computer_Exchange_Format,
      --
      -- 1985 ZSoft
      --      http://web.archive.org/web/20100206055706/http://www.qzx.com/pc-gpe/pcx.txt
      --
      Graphics_Interchange_Format,
      --
      -- 1985 CompuServe Information Service, now a subsidiary of America Online
      --      http://web.archive.org/web/20130426053329/http://www.w3.org/Graphics/GIF/spec-gif89a.txt
      --
      Tagged_Image_File_Format,
      --
      -- 1986 Aldus, now Adobe Systems
      --      http://web.archive.org/web/20130430213645/http://partners.adobe.com/public/developer/en/tiff/TIFF6.pdf
      --
      Portable_Pixmap_Format,
      --
      -- 1988 Jef Poskanzer
      --      http://web.archive.org/web/20130517063911/http://netpbm.sourceforge.net/doc/pbm.html
      --
      X_Pixmap_Format,
      --
      -- 1989 Daniel Dardailler and Colas Nahaboo
      --
      --
      Bit_Map_Format,
      --
      -- 1990 Microsoft
      --      http://web.archive.org/web/20130424130243/http://en.wikipedia.org/wiki/BMP_file_format
      --
      Joint_Photographic_Experts_Group_Format,
      --
      -- 1992 Joint Photographic Experts Group and Joint Bi-level Image Experts Group
      --      http://web.archive.org/web/20111226041637/http://white.stanford.edu/~brian/psy221/reader/Wallace.JPEG.pdf
      --
      Portable_Network_Graphics_Format,
      --
      -- 1996 Internet Engineering Steering Group
      --      http://web.archive.org/web/20130116130737/http://libpng.org/pub/png/spec/iso/
      --
      Joint_Photographic_Experts_Group_2000_Format);
      --
      -- 2000 Joint Photographic Experts Group and Joint Bi-level Image Experts Group
      --      http://web.archive.org/web/20130314150613/http://jpeg.org/public/fcd15444-1.pdf
      --      http://web.archive.org/web/20120117162132/http://www.mast.queensu.ca/~web/Papers/lui-project01.pdf
      --
    type Enumerated_Colors
      is(
      Monochrome_Colors,
      Eight_Colors,
      Sixteen_Colors,
      Two_Hundred_Fifty_Six_Per_Colors,
      Two_Hundred_Fifty_Six_With_Alpha_Per_Colors);
    for Enumerated_Colors -- Its value is the bits per pixel in each color scheme
      use(
      Monochrome_Colors                           => 1,
      Eight_Colors                                => Byte'size / 2,
      Sixteen_Colors                              => Byte'size,
      Thirty_Two_Per__Colors                       => Byte'size * 2 - 1,
      Thirty_Two_Per_Colors                       => Byte'size * 2,
      Two_Hundred_Fifty_Six_Per_Colors            => Byte'size * 3,
      Alpha_With_Two_Hundred_Fifty_Six_Per_Colors => Byte'size * 4);
  -----------
  -- Types --
  -----------
    type Array_Record_Pixel;
  -------------
  -- Records --
  -------------
    type Record_Pixel
      is record
        Color : Record_Color       := (others => <>);
        Alpha : Integer_1_Unsigned := Byte'last;
      end record;
    type Record_Graphic(
      Format : Enumerated_Format := Graphics_Interchange_Format
      Width  : Integer_4_Positive;
      Height : Integer_4_Positive)
      is record
        Pixels : Array_Record_Pixel(1..Width, 1..Height) := (others => <>);
        Colors : Enumerated_Colors                       := Alpha_With_Two_Hundred_Fifty_Six_Per_Colors;
        case Format is
          when Truevision_Graphics_Adapter_Format =>
            Run_Length_Encode    : Boolean := False;
          when Graphics_Interchange_Format =>
            Duration_Until_Next  : Day_Duration := 0.0;
          when Joint_Photographic_Experts_Group_Format =>
            Brightness           : Boolean := False;
            Hue                  : Boolean := False;
            Saturation           : Boolean := False;
            Inphase              : Boolean := False;
            Quadrature_Amplitude : Boolean := False;
          when others =>
            null;
        end case;
      end record;
  ------------
  -- Arrays --
  ------------
    type Array_Record_Pixel
      is array(Positive range <>, Positive range <>)
      of Record_Pixel;
    type Array_Record_Graphic
      is array(Positive range <>);
  -----------------
  -- Subprograms --
  -----------------
    procedure Test;
    function Load(
      Path : in String_2)
      return Record_Graphic;
    function Load(
      Path : in String_2)
      return Array_Record_Graphic;
    procedure Save(
      Path    : in String_2
      Graphic : in Record_Graphic);
    procedure Save(
      Path    : in String_2;
      Graphic : in Array_Record_Graphic);
-------
private
-------
  ---------------------
  -- Implementations --
  ---------------------
  --
  -- To add an implementation...
  --
  -- 1 Create a new enumerated entry in the Enumerated_Formats type above and add a new entry in the FORMATS constant below
  --
  -- 2 Add a separate package in the Packages section below that has a Load and Save subprogram matching the definition
  --   specified in Neo.File
  --
  -- 3 Add an entry in the Implementation instantiation for the new Enumerated_Format
  --
  ---------------
  -- Constants --
  ---------------
    FORMATS : Array_Record_Format(Enumerated_Format'range) :=(
      Truevision_Graphics_Adapter_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("TGA"),
            new String_2("TPIC"),
            new String_2("TARGA")),
        Signatures => null),
      Personal_Computer_Exchange_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("PCX")),
        Signatures => null),
      Graphics_Interchange_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("GIF"),
            new String_2("GIFF")),
        Signatures =>
          new Array_String_2(
            new String_2("GIF87a"),
            new String_2("GIF89a"))),
      Tagged_Image_File_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("TIF"),
            new String_2("TIFF")),
        Signatures =>
          new Array_String_2(
            new String_2("II"),
            new String_2("MM"))),
      Portable_Pixmap_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("PPM"),
            new String_2("PGM"),
            new String_2("PBM"),
            new String_2("PNM")),
        Signatures =>
          new Array_String_2(
            new String_2("P1")),
            new String_2("P2")),
            new String_2("P3")),
            new String_2("P4")),
            new String_2("P5")),
            new String_2("P6"))),
      Bit_Map_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("BMP"),
            new String_2("DIB")),
        Signatures =>
          new Array_String_2(
            new String_2("DIB"),
            new String_2("BM"))),
      Joint_Photographic_Experts_Group_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("JPG"),
            new String_2("JPEG"),
            new String_2("JPE"),
            new String_2("JIF"),
            new String_2("JFIF"),
            new String_2("JFI"),
            new String_2("JIFF")),
        Signatures =>
          new Array_String_2(
            new String_2( -- ÿØ
              Character_1'val(16#FF#) & Character_1'val(16#D8#)))),
      Portable_Network_Graphics_Format =>(
        Comments   => null,
        Extensions =>
          new Array_String_2(
            new String_2("PNG")),
        Signatures =>
          new Array_String_2(
            new String_2( -- ‰PNG
              Character_1'val(16#89#) & "PNG" & ASCII.CR & ASCII.LF & ASCII.SUB & ASCII.LF))),
      Joint_Photographic_Experts_Group_2000_Format =>(
        Extensions =>
          new Array_String_2(
            new String_2("JP2"),
            new String_2("J2K"),
            new String_2("JPF"),
            new String_2("JPX"),
            new String_2("JPM"),
            new String_2("MJ2")),
        Signatures =>
          new Array_String_2(
            new String_2( -- jP
              ASCII.NUL & ASCII.NUL & ASCII.NUL & Character_1'val(16#FF#) & "jP"))));
  --------------
  -- Packages --
  --------------
    package FITS
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end FITS;
    package PCX
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end PCX;
    package BMP
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end BMP;
    package TIFF
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end TIFF;
    package GIF
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end GIF;
    package PPM
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end PPM;
    package PNG
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end PNG;
    package TGA
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end TGA;
    package JPEG
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end JPEG;
    package JP2
      is
        function Load(
          Path : in String_2)
          return Array_Record_Graphic;
        procedure Save(
          Path    : in String_2;
          Graphic : in Array_Record_Graphic);
      end JP2;
    package body FITS
      is separate;
    package body TGA
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
    package body JP2
      is separate;
  --------------------
  -- Implementation --
  --------------------
    package Instantiation
      is new Implementation(
        Type_To_Handle => Neo.File.Image.Record_Graphic,
        Format         => Neo.File.Image.Enumerated_Format,
        Formats        => Neo.File.Image.FORMATS
        Operations     =>(
          Flexible_Image_Transfer_System_Format        => (FITS.Load'access, FITS.Save'access),
          Truevision_Graphics_Adapter_Format           => ( TGA.Load'access,  TGA.Save'access),
          Personal_Computer_Exchange_Format            => ( PCX.Load'access,  PCX.Save'access),
          Graphics_Interchange_Format                  => (TIFF.Load'access, TIFF.Save'access),
          Tagged_Image_File_Format                     => ( GIF.Load'access,  GIF.Save'access),
          Portable_Pixmap_Format                       => ( PPM.Load'access,  PPM.Save'access),
          Bit_Map_Format                               => ( BMP.Load'access,  BMP.Save'access),
          Joint_Photographic_Experts_Group_Format      => ( PNG.Load'access,  PNG.Save'access),
          Portable_Network_Graphics_Format             => (JPEG.Load'access, JPEG.Save'access)
          Joint_Photographic_Experts_Group_2000_Format => ( JP2.Load'access,  JP2.Save'access));
  end Neo.File.Image;
