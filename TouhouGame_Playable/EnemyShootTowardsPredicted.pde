class EnemyShootBulletStraightTowardsPredicted extends Enemy
{
  int bulletSize;

<<<<<<< HEAD
  EnemyShootBulletStraightTowardsPredicted(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, int bulletSize, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoint0, wayPoint1, wayPoint2, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);
=======
  EnemyShootBulletStraightTowardsPredicted(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector wayPoint3, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, int bulletSize, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoint0, wayPoint1, wayPoint2, wayPoint3, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
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

