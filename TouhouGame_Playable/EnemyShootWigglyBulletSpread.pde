class EnemyShootWigglyBulletSpread extends Enemy
{
<<<<<<< HEAD
  EnemyShootWigglyBulletSpread(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoint0, wayPoint1, wayPoint2, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);
=======
  float bulletSpreadRange, rotateAmount;
  int bulletWiggleChangeDeadline, bulletWiggleAmount, bulletSize, bulletNum;

  EnemyShootWigglyBulletSpread(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector wayPoint3, PVector vel, PVector loc, int bulletWiggleChangeDeadline, int bulletWiggleAmount, int bulletSize, int bulletNum, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float rotateAmount, float speed, float bulletSpeed, float bulletSpreadRange, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoint0, wayPoint1, wayPoint2, wayPoint3, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);    
    this.bulletSpreadRange = bulletSpreadRange;
    this.rotateAmount = rotateAmount;
    this.bulletWiggleChangeDeadline = bulletWiggleChangeDeadline;
    this.bulletWiggleAmount = bulletWiggleAmount;
    this.bulletSize = bulletSize;
    this.bulletNum = bulletNum;
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
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
<<<<<<< HEAD
      shootBulletWiggleTowards(copy(PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc)), copy(loc), PI, TWO_PI, 7.5, 17, 0, 7, 30, 15);
=======
      shootBulletWiggleTowards(copy(PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc)), copy(loc), rotateAmount, bulletSpreadRange, bulletSpeed, bulletWiggleChangeDeadline, 0, bulletWiggleAmount, bulletSize, bulletNum);
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81

      shootTimeCurrent = 0;
    }
    moveTowardsLoc(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), 999999999);
    return super.run();
  }
}

