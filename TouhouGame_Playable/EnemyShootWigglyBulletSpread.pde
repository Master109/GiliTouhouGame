class EnemyShootWigglyBulletSpread extends Enemy
{
  EnemyShootWigglyBulletSpread(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoint0, wayPoint1, wayPoint2, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);
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
      shootBulletWiggleTowards(copy(PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc)), copy(loc), PI, TWO_PI, 7.5, 17, 0, 7, 30, 15);

      shootTimeCurrent = 0;
    }
    moveTowardsLoc(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), 999999999);
    return super.run();
  }
}

