class EnemyMoveTowardsPlayer extends Enemy
{
  EnemyMoveTowardsPlayer(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector wayPoint3, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    super(wayPoint0, wayPoint1, wayPoint2, wayPoint3, vel, loc, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, speed, bulletSpeed, facingRight, destroyAfterDestination);
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
      Bullet b = new BulletSplit(PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc), copy(loc), 20, -1, -1, -1, 60, 20, 7.0, -1.0, false);
      bullets.add(b);

      shootTimeCurrent = 0;
    }

    moveTowardsYLoc(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y));
    return super.run();
  }
}

