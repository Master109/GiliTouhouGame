class EnemyShootHeadOn extends Enemy
{
  EnemyShootHeadOn(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight)
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
      shootBulletStraightTowards(copy(p.loc), bulletSpeed, 20);

    moveTowardsLoc(p.loc, .3);
    return super.run();
  }
}

