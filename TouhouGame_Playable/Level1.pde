class Level1 extends Level
{
  boolean runPart1, runPart2;

  Level1()
  {
    this.runPart1 = false;
    this.runPart2 = false;
  }

  void createEnemies()
  {
    if (showBoss)
    {
      b1.run();
      b1.show();
    }
    if (tics == 0 && ticking)
    {
      enemies.add(new EnemyShootHeadOn(new PVector(12.5, 12.5), new PVector(12.5, height - 12.5), new PVector(12.5, 12.5), new PVector(), new PVector(12.5, height + 12.5), 0, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false));
    }
    if (tics == 30 && ticking)
    {
      ticking = false;
      enemies.add(new EnemyShootHeadOn(new PVector(width - 12.5, height - 12.5), new PVector(width - 12.5, 12.5), new PVector(width - 12.5, height - 12.5), new PVector(), new PVector(width - 12.5, -12.5), 0, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false));
    }
    if (enemies.size() == 0 && tics == 30)
      ticking = true;
    if (tics == 140 && ticking)
    {
      ticking = false;
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(width / 2, height - 12.5), 0, 25, 60, 0, 999999999, 0, 999999999, 4.0, 5.0, true, false));
    }
    if (enemies.size() == 0 && tics == 140)
      ticking = true;
    if (tics == 200 && ticking)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(720, height + 12.5), new PVector(720, height + 12.5), new PVector(), new PVector(width + 12.5, 100), 1, 25, 10, 0, 120, 0, 0, 1, 5.0, true, true));
    if (tics == 300 && ticking)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(-12.5, 760), new PVector(-12.5, 760), new PVector(), new PVector(width + 12.5, 495), 1, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true));
    if (tics == 375 && ticking)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(width + 12.5, 185), new PVector(width + 12.5, 185), new PVector(), new PVector(-12.5, 550), 1, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true));
    if (tics == 425 && ticking)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(width / 2 - 170, -12.5), 0, 25, 30, 0, 999999999, 0, .3, 5.5, 0.0, true, false));
    if (tics == 480 && ticking)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(-12.5, 250), new PVector(-12.5, 250), new PVector(), new PVector(165, -12.5), 1, 25, 10, 0, 120, 0, 0, .33333333333333333, 5.0, true, true));
    if (tics == 1900 && ticking)
    {
      showBoss = true;
      enemies.clear();
    }
    super.createEnemies();
  }
}

