class EnemyShootWigglyBulletSpread extends Enemy
{
  EnemyShootWigglyBulletSpread(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float spreadRange, float speed, float bulletSpeed, boolean facingRight)
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
      shootBulletWiggleTowards(copy(PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc)), copy(loc), PI, PI, 7.5, 0, -1, 10, 30, 7);

    moveTowardsLoc(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), 999999999);
    return super.run();
  }
}

