class Level1 extends Level
{
<<<<<<< HEAD

=======
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
  Level1()
  {
  }

  void createEnemies()
  {
    if (enemies.size() == 0 && tics < 840 && tics > 0)
      tics = 840;

    if (showBoss)
    {
      b1.run();
      b1.show();
    }
    if (tics == 0)
    {
<<<<<<< HEAD
      enemies.add(new EnemyShootHeadOn(new PVector(12.5, 12.5), new PVector(12.5, height - 12.5), new PVector(12.5, 12.5), new PVector(), new PVector(12.5, height + 12.5), 0, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false));
    }
    if (tics == 30)
    {
      enemies.add(new EnemyShootHeadOn(new PVector(width - 12.5, height - 12.5), new PVector(width - 12.5, 12.5), new PVector(width - 12.5, height - 12.5), new PVector(), new PVector(width - 12.5, -12.5), 0, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false));
=======
      enemies.add(new EnemyShootHeadOn(new PVector(12.5, 12.5), new PVector(12.5, height - 12.5), new PVector(12.5, height - 12.5), new PVector(12.5, 12.5), new PVector(), new PVector(12.5, height + 12.5), 3, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false));
    }
    if (tics == 30)
    {
      enemies.add(new EnemyShootHeadOn(new PVector(width - 12.5, height - 12.5), new PVector(width - 12.5, 12.5), new PVector(width - 12.5, 12.5), new PVector(width - 12.5, height - 12.5), new PVector(), new PVector(width - 12.5, -12.5), 0, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false));
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
    }
    if (tics == 840)
    {
      enemies.clear();
<<<<<<< HEAD
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(width / 2, height - 12.5), 0, 25, 60, 0, 999999999, 0, 999999999, 4.0, 5.0, true, false));
=======
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(width / 2, height - 12.5), 0, 25, 60, 0, 999999999, 0, 999999999, 4.0, 5.0, true, false));
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
    }
    if (tics == 1440)
    {
      enemies.clear();
<<<<<<< HEAD
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(720, height + 12.5), new PVector(720, height + 12.5), new PVector(), new PVector(width + 12.5, 100), 1, 25, 10, 0, 120, 0, 0, 1, 5.0, true, true));
    }
    if (tics == 1700)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(-12.5, 760), new PVector(-12.5, 760), new PVector(), new PVector(width + 12.5, 495), 1, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true));
    if (tics == 1775)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(width + 12.5, 185), new PVector(width + 12.5, 185), new PVector(), new PVector(-12.5, 550), 1, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true));
    if (tics == 1825)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(width / 2 - 170, -12.5), 0, 25, 30, 0, 999999999, 0, .3, 5.5, 0.0, true, false));
    if (tics == 1880)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(-12.5, 250), new PVector(-12.5, 250), new PVector(), new PVector(165, -12.5), 1, 25, 10, 0, 120, 0, 0, .33333333333333333, 5.0, true, true));
=======
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(720, height + 12.5), new PVector(720, height + 12.5), NO_WAYPOINT, new PVector(), new PVector(width + 12.5, 100), 1, 25, 10, 0, 120, 0, 0, 1, 5.0, true, true));
    }
    if (tics == 1700)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(-12.5, 760), new PVector(-12.5, 760), NO_WAYPOINT, new PVector(), new PVector(width + 12.5, 495), 1, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true));
    if (tics == 1775)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(width + 12.5, 185), new PVector(width + 12.5, 185), NO_WAYPOINT, new PVector(), new PVector(-12.5, 550), 1, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true));
    if (tics == 1825)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(width / 2 - 170, -12.5), 0, 25, 30, 0, 999999999, 0, .3, 5.5, 0.0, true, false));
    if (tics == 1880)
      enemies.add(new EnemyShootHeadOn(NO_WAYPOINT, new PVector(-12.5, 250), new PVector(-12.5, 250), NO_WAYPOINT, new PVector(), new PVector(165, -12.5), 1, 25, 10, 0, 120, 0, 0, .33333333333333333, 5.0, true, true));
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
    if (tics == 3300)
    {
      enemies.clear();
      showBoss = true;
    }
    super.createEnemies();
  }
}

