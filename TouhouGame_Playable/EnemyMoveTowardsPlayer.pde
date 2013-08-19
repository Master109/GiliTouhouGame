class EnemyMoveTowardsPlayer extends Enemy
{
  EnemyMoveTowardsPlayer(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight)
  {
    super(vel, loc, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight);
  }

  void show()
  {
    fill(ENEMY_COLOR);
    super.show();
  }

  boolean run()
  {
    if (isTimeToShoot())
    {
      Bullet b = new BulletSplit(copy(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y)), copy(loc), 20, -1, -1, -1, 90, 20, 7.0, -1.0, false);
      bullets.add(b);

      shootTimeCurrent = 0;
    }

    moveTowardsYLoc(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y));
    return super.run();
  }
}

