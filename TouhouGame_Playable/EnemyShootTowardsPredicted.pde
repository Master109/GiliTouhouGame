class EnemyShootBulletStraightTowardsPredicted extends Enemy
{
  EnemyShootBulletStraightTowardsPredicted(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight)
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
    PVector vec = copy(PVector.add(p.nextLoc, PVector.mult(p.vel, PVector.dist(loc, p.nextLoc) / bulletSpeed)));

    if (isTimeToShoot())
      shootBulletStraightTowards(vec, bulletSpeed, 160);

    return super.run();
  }
}

