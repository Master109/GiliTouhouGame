class Level1 extends Level
{
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
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(12.5, height + 12.5), 0, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false);
      e.wayPoints[0] = new PVector(12.5, 12.5);
      e.wayPoints[2] = new PVector(12.5, height - 12.5);
      e.wayPoints[1] = new PVector(12.5, 12.5);
      e.wayPoints[4] = new PVector(12.5, height - 12.5);
      e.wayPoints[3] = new PVector(12.5, 12.5);
      e.wayPoints[6] = new PVector(12.5, height - 12.5);
      e.wayPoints[5] = new PVector(12.5, 12.5);
      e.wayPoints[7] = new PVector(12.5, height - 12.5);
      enemies.add(e);
    }
    if (tics == 30)
    {
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(width - 12.5, -12.5), 0, 25, 10, 0, 60, 0, 50, 4.0, 5.0, true, false);
      e.wayPoints[0] = new PVector(width - 12.5, height - 12.5);
      e.wayPoints[2] = new PVector(width - 12.5, 12.5);
      e.wayPoints[1] = new PVector(width - 12.5, height - 12.5);
      e.wayPoints[4] = new PVector(width - 12.5, 12.5);
      e.wayPoints[3] = new PVector(width - 12.5, height - 12.5);
      e.wayPoints[6] = new PVector(width - 12.5, 12.5);
      e.wayPoints[5] = new PVector(width - 12.5, height - 12.5);
      e.wayPoints[7] = new PVector(width - 12.5, 12.5);
      enemies.add(e);
    }
    if (tics == 840)
    {
      enemies.clear();
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(width / 2, height - 12.5), 0, 25, 60, 0, 999999999, 0, 999999999, 4.0, 5.0, true, false);
      e.wayPoints[0] = NO_WAYPOINT;
      e.wayPoints[2] = NO_WAYPOINT;
      e.wayPoints[1] = NO_WAYPOINT;
      e.wayPoints[4] = NO_WAYPOINT;
      e.wayPoints[3] = NO_WAYPOINT;
      e.wayPoints[6] = NO_WAYPOINT;
      e.wayPoints[5] = NO_WAYPOINT;
      e.wayPoints[7] = NO_WAYPOINT;
      enemies.add(e);
    }
    if (tics == 1440)
    {
      enemies.clear();
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(width + 12.5, 100), 0, 25, 10, 0, 120, 0, 0, 1, 5.0, true, true);
      e.wayPoints[0] = NO_WAYPOINT;
      e.wayPoints[2] = new PVector(720, height + 12.5);
      e.wayPoints[1] = new PVector(720, height + 12.5);
      e.wayPoints[4] = NO_WAYPOINT;
      e.wayPoints[3] = NO_WAYPOINT;
      e.wayPoints[6] = NO_WAYPOINT;
      e.wayPoints[5] = NO_WAYPOINT;
      e.wayPoints[7] = NO_WAYPOINT;
      enemies.add(e);
    }
    if (tics == 1700)
    {
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(width + 12.5, 495), 0, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true);
      e.wayPoints[0] = NO_WAYPOINT;
      e.wayPoints[2] = new PVector(-12.5, 760);
      e.wayPoints[1] = new PVector(-12.5, 760);
      e.wayPoints[4] = NO_WAYPOINT;
      e.wayPoints[3] = NO_WAYPOINT;
      e.wayPoints[6] = NO_WAYPOINT;
      e.wayPoints[5] = NO_WAYPOINT;
      e.wayPoints[7] = NO_WAYPOINT;
      enemies.add(e);
    }
    if (tics == 1775)
    { 
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(-12.5, 550), 0, 25, 10, 0, 120, 0, 0, 1.0, 5.0, true, true);
      e.wayPoints[0] = NO_WAYPOINT;
      e.wayPoints[2] = new PVector(width + 12.5, 185);
      e.wayPoints[1] = new PVector(width + 12.5, 185);
      e.wayPoints[4] = NO_WAYPOINT;
      e.wayPoints[3] = NO_WAYPOINT;
      e.wayPoints[6] = NO_WAYPOINT;
      e.wayPoints[5] = NO_WAYPOINT;
      e.wayPoints[7] = NO_WAYPOINT;
      enemies.add(e);
    }
    if (tics == 1825)
    {
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(width / 2 - 170, -12.5), 0, 25, 30, 0, 999999999, 0, .3, 5.5, 0.0, true, false);
      e.wayPoints[0] = NO_WAYPOINT;
      e.wayPoints[2] = NO_WAYPOINT;
      e.wayPoints[1] = NO_WAYPOINT;
      e.wayPoints[4] = NO_WAYPOINT;
      e.wayPoints[3] = NO_WAYPOINT;
      e.wayPoints[6] = NO_WAYPOINT;
      e.wayPoints[5] = NO_WAYPOINT;
      e.wayPoints[7] = NO_WAYPOINT;
      enemies.add(e);
    }
    if (tics == 1880)
    {
      Enemy e = new EnemyShootHeadOn(new PVector[8], new PVector(), new PVector(165, -12.5), 0, 25, 10, 0, 120, 0, 0, .33333333333333333, 5.0, true, true);
      e.wayPoints[0] = NO_WAYPOINT;
      e.wayPoints[2] = new PVector(-12.5, 250);
      e.wayPoints[1] = new PVector(-12.5, 250);
      e.wayPoints[4] = NO_WAYPOINT;
      e.wayPoints[3] = NO_WAYPOINT;
      e.wayPoints[6] = NO_WAYPOINT;
      e.wayPoints[5] = NO_WAYPOINT;
      e.wayPoints[7] = NO_WAYPOINT;
      enemies.add(e);
    }
    if (tics == 3300)
    {
      enemies.clear();
      showBoss = true;
    }
    super.createEnemies();
  }
}

