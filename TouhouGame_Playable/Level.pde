class Level
{
  int tics;
  boolean showBoss;

  public Level()
  {
    showBoss = false;
    tics = 0;
  }

  void createEnemies()
  {
    tics ++;
  }
}

