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
package Neo.Doom3
  is
  -----------------
  -- Subprograms --
  -----------------
    procedure Test;
    procedure Initialize;
    procedure Run;
    procedure Finalize;
  --------------
  -- Packages --
  --------------
    package Game
      is new Engine(
        Version    => "AdaDoom3",
        Name       => "DOOM 3: BFG Edition",
        Test       => Test'access,
        Initialize => Initialize'access,
        Run        => Run'access,
        Finalize   => Finalize'access,
        Icons   =>(
          Machintosh => new String_2("icon.icns"),
          Windows    => new String_2("icon.ico"),
          Linux      =>
            new Array_String_2(
            new String_2("icon016.bmp"),
            new String_2("icon032.bmp"),
            new String_2("icon048.bmp"),
            new String_2("icon064.bmp"),
            new String_2("icon072.bmp"),
            new String_2("icon096.bmp"),
            new String_2("icon128.bmp"),
            new String_2("icon256.bmp"),
            new String_2("icon512.bmp"));
  end Neo.Doom3;
