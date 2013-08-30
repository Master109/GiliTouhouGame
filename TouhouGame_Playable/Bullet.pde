class Bullet
{
  PVector vel, loc;
  int bulletSize;
  float speed;
  boolean madeByPlayer, exists;

  Bullet(PVector vel, PVector loc, int bulletSize, float speed, boolean madeByPlayer)
  {
    this.vel = vel;
    this.loc = loc;
    this.bulletSize = bulletSize;
    this.speed = speed;
    this.exists = true;
    this.madeByPlayer = madeByPlayer;
  }

  void show()
  {
    noStroke();
    ellipse(loc, bulletSize);
    fill(255, 70);
    ellipse(loc, bulletSize + 50);
  }

  void run()
  {
    for (Enemy e : enemies)
    {
      if (madeByPlayer && loc.dist(e.loc) <= bulletSize / 2 + (e.enemySize / 2))
      {
        exists = false;
        e.hp --;
      }
    }

    if (madeByPlayer && loc.dist(b1.loc) <= bulletSize / 2 + (b1.bossSize / 2))
    {
      exists = false;
      b1.hp --;
    }

    if (b1.hp <= 0)
    {
      l1.showBoss = false;
      levelComplete = true;
      kills ++;
      paused = true;
    }

    if (!madeByPlayer && loc.dist(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y)) <= bulletSize / 2)
      shouldRestart = true;

    vel.setMag(speed);
    loc.add(vel);

    if (loc.dist(new PVector(width / 2, height / 2)) >= width * 2 + (bulletSize / 2))
      exists = false;

    if (!madeByPlayer && loc.dist(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y)) <= bulletSize / 2 + 22.5)
    {
      float grazeIntoScoreModifier2 = 0;
      if (perkEquiped[4] == 1)
        grazeIntoScoreModifier2 = grazeIntoScoreModifier;
<<<<<<< HEAD
      score += .5 + grazeIntoScoreModifier2;
=======
      score += .2 + grazeIntoScoreModifier2;
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
      graze ++;
      if (currentLevel == 0)
        grazeAchievementCounter ++;
    }
  }
}

