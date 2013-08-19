class EnemyMoveTowardsPredicted extends Enemy
{
  EnemyMoveTowardsPredicted(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight)
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
      PVector direction;
      if (facingRight)
        direction = new PVector(999999999, 0);
      else
        direction = new PVector(-99999999, 0);
      shootBulletStraightTowards(copy(direction), bulletSpeed, 20);
    }

    final int EXPECTED_PLAYER_SPEED = 20;
    moveTowardsYLoc(PVector.add(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), PVector.mult(p.vel, EXPECTED_PLAYER_SPEED)));

    return super.run();
  }
}

