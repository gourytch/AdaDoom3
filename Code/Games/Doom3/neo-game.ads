--
--
--
--
--
--
--
-- These constants and subprograms are required for main.adb to function and should not be renamed or deleted
--
--
--
--
--
--
--
--
package Neo.Game
  is
  ---------------
  -- Constants --
  ---------------
    VERSION : constant String_2    := "AdaDoom3";
    NAME    : constant String_2    := "DOOM 3: BFG Edition";
    ICONS   : constant Record_Icon :=(
      Machintosh => new String_2("icondoom.icns"),
      Windows    => new String_2("icondoom.ico"),
      Linux      =>
        new Array_String_2(
          new String_2("icondoom016.bmp"),
          new String_2("icondoom032.bmp"),
          new String_2("icondoom048.bmp"),
          new String_2("icondoom064.bmp"),
          new String_2("icondoom072.bmp"),
          new String_2("icondoom096.bmp"),
          new String_2("icondoom128.bmp"),
          new String_2("icondoom256.bmp"),
          new String_2("icondoom512.bmp"));
  -----------------
  -- Subprograms --
  -----------------
    procedure Initialize;
    procedure Run;
    procedure Finalize;
  end Neo.Game;
