class Level
{
  int tics;
  boolean ticking, showBoss;

  public Level()
  {
    ticking = true;
    showBoss = false;
    tics = 1900;
  }

  void createEnemies()
  {
    if (ticking)
      tics ++;
  }
}

