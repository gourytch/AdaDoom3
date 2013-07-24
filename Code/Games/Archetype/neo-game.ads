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
package Neo.Game
  is
  ---------------
  -- Constants --
  ---------------
    VERSION : constant String_2    := "Archetype v0.1";
    NAME    : constant String_2    := "Archetype";
    ICONS   : constant Record_Icon :=(
      Machintosh => new String_2("iconarchetype.icns"),
      Windows    => new String_2("iconarchetype.ico"),
      Linux      =>
        new Array_String_2(
          new String_2("iconarchetype016.bmp"),
          new String_2("iconarchetype032.bmp"),
          new String_2("iconarchetype048.bmp"),
          new String_2("iconarchetype064.bmp"),
          new String_2("iconarchetype072.bmp"),
          new String_2("iconarchetype096.bmp"),
          new String_2("iconarchetype128.bmp"),
          new String_2("iconarchetype256.bmp"),
          new String_2("iconarchetype512.bmp"));
  -----------------
  -- Subprograms --
  -----------------
    procedure Initialize;
    procedure Run;
    procedure Finalize;
  end Neo.Game;