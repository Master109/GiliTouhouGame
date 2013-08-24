class EnemyShootHeadOn extends Enemy
{
  float curvatureLimit;
  boolean destroyAfterDestination;

  EnemyShootHeadOn(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector wayPoint3, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float curvatureLimit, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoint0, wayPoint1, wayPoint2, wayPoint3, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);
    this.curvatureLimit = curvatureLimit;
  }

  void show()
  {
    fill(ENEMY_COLOR);
    super.show();
  }

  boolean run()
  {
    if (isTimeToShoot())
      shootBulletStraightTowards(copy(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y)), bulletSpeed, 20);

    moveTowardsLoc(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), curvatureLimit);
    return super.run();
  }
}

