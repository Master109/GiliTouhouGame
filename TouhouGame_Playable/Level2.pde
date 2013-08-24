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
      Enemy e = new EnemyShootWigglyBulletSpread(new PVector[8], new PVector(), new PVector(width / 2 + 250, - 12.5), 20, 7, 30, 1, 0, 25, 25, 0, 30, 26, PI, 2.0, 7.5, HALF_PI, true, true);
      e.wayPoints[0] = NO_WAYPOINT;
      e.wayPoints[1] = new PVector(width / 2 - 150, height + 12.5);
      e.wayPoints[2] = new PVector(width / 2 - 150, height + 12.5);
      e.wayPoints[3] = NO_WAYPOINT;
      e.wayPoints[4] = NO_WAYPOINT;
      e.wayPoints[5] = NO_WAYPOINT;
      e.wayPoints[6] = NO_WAYPOINT;
      e.wayPoints[7] = NO_WAYPOINT;
      //enemies.add(e);
    }
    if (tics == 0)
    {
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(width + 12.5, height - 12.5), 0, 25, 10, 0, 70, 0, 0, 27.5, 6.25, true, false);
      e.wayPoints[0] = new PVector(12.5, height - 12.5);
      e.wayPoints[1] = new PVector(12.5, height - 12.5);
      e.wayPoints[2] = new PVector(12.5, 12.5);
      e.wayPoints[3] = new PVector(12.5, 12.5);
      e.wayPoints[4] = new PVector(width - 12.5, 12.5);
      e.wayPoints[5] = new PVector(width - 12.5, 12.5);
      e.wayPoints[6] = new PVector(width - 12.5, height - 12.5);
      e.wayPoints[7] = new PVector(width - 12.5, height - 12.5);
      enemies.add(e);
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

