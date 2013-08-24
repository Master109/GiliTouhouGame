class EnemyShootBulletStraightTowardsPredicted extends Enemy
{
  int bulletSize;

  EnemyShootBulletStraightTowardsPredicted(PVector[] wayPoints, PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector wayPoint3, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, int bulletSize, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoints, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);
    this.bulletSize = bulletSize;
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
      shootBulletStraightTowards(vec, bulletSpeed, bulletSize);

    return super.run();
  }
}

