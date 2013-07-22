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
procedure Neo.Doom3.Main
  is
  --------------------
  procedure Initialize
  --------------------
    is
    begin
      null;
    end Initialize;
  -------------
  procedure Run
  -------------
    is
    begin
      Put_Line("Tick!");
    end Run;
  ------------------
  procedure Finalize
  ------------------
    is
    begin
      null;
    end Finalize;
  --------------
  procedure Test
  --------------
    is
    begin
      Put_Title("DOOM3 TEST");
      Put_Line("???");
    end Test;
  package Doom3
    is new Neo.Engine(NAME, ICONS, Initialize, Run, Finalize, Test);
  -----
  begin
  -----
    Doom3.Run;
  end Neo.Doom3.Main;
