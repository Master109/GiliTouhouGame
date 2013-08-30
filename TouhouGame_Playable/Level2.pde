class Level2 extends Level
{
  Level2()
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
      enemies.add(new EnemyShootWigglyBulletSpread(NO_WAYPOINT, new PVector(width / 2 - 250, height + 12.5), new PVector(width / 2 - 250, height + 12.5), NO_WAYPOINT, new PVector(), new PVector(width / 2 + 250, - 12.5), 17, 7, 30, 1, 0, 25, 25, 0, 30, 26, PI, 2.0, 7.5, HALF_PI, true, true));
    }
    if (tics == 0)
    {
      enemies.add(new EnemyShootHeadOn(new PVector(12.5, height - 12.5), new PVector(12.5, 12.5), new PVector(width - 12.5, 12.5), new PVector(width - 12.5, height - 12.5), new PVector(), new PVector(width + 12.5, height - 12.5), 3, 25, 10, 0, 10, 0, 0, 26, 6.5, true, false));
    }
    if (tics == 340)
    {
    }
    if (tics == 3440)
    {
    }
    if (tics == 1700)
    {
    }
    if (tics == 1775)
    {
    }
    if (tics == 1825)
    {
    }
    if (tics == 1880)
    {
    }
    if (tics == 3300)
    {
      showBoss = true;
    }
    super.createEnemies();
  }
}

