class Boss1 extends Boss
{
  Boss1(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector vel, PVector loc, int timer2, int shootTimeCurrent2, int shootTimeDeadline2, int state, int state2, int currentWayPoint, int bossSize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, int currentSection, int timer, float rotateAmount, float speed, float bulletSpeed, float shootAngleModifier)
  {
    super(wayPoint0, wayPoint1, wayPoint2, vel, loc, timer2, shootTimeCurrent2, shootTimeDeadline2, state, state2, currentWayPoint, bossSize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, currentSection, timer, rotateAmount, speed, bulletSpeed, shootAngleModifier);
  }

  void show()
  {
    super.show();
  }

  void run()
  {
    if (l1.tics == 4100)
      wayPoint2 = new PVector(width + 100, height / 2 - 100);      
    timer2 ++;
    if (hp < 200 || l1.tics == 3000)
      currentSection = 2;
    else if ((loc.dist(wayPoint0) <= speed && wayPoint1.equals(NO_WAYPOINT)) || (loc.dist(wayPoint1) <= speed && wayPoint2.equals(NO_WAYPOINT)) || (loc.dist(wayPoint2) <= speed && wayPoint0.equals(NO_WAYPOINT)))
      currentSection = 1;
    if (loc.dist(wayPoint2) <= speed)
      hp = 0;

    if (currentSection == 1)
    {
      shootAngleModifier += 1;
      shootTimeDeadline = 13;
      shootTimeCurrent ++;
      if (shootTimeCurrent >= shootTimeDeadline)
      {
        shootBulletStraightTowards(new PVector(width / 2, height / 2), copy(loc), PI, TWO_PI, 7.5, 17, 0, 0, 30, 10);
        shootTimeCurrent = 0;
      }
    }
    else if (currentSection == 2)
    {
      int timerDeadline;
      if (timer == 0)
      {
        shootAngleModifier = 0;
        for (int x = 10; x <= width; x += 100)
        {
          enemies.add(new EnemyShootBulletStraightTowardsPredicted(new PVector[8], NO_WAYPOINT, new PVector(x, 200), new PVector(x, 200), NO_WAYPOINT, new PVector(), new PVector(x, -50), 0, 100, 999999999, 0, 999999999, 8, 160, 2.0, 8.5, true, true));
          enemies.add(new EnemyShootBulletStraightTowardsPredicted(new PVector[8], NO_WAYPOINT, new PVector(x, 515), new PVector(x, 515), NO_WAYPOINT, new PVector(), new PVector(x, height + 50), 0, 100, 999999999, 0, 999999999, 8, 160, 2.0, 8.5, true, true));
        }
      }
      timer ++;
      if (state2 == -1)
        timerDeadline = 61;
      else
        timerDeadline = 91;
      if (timer >= timerDeadline)
      {
        timer = 1;
        if (state >= 0)
        {
          state = -1;
        }
        else
        {
          state = 1;
          if (state2 == 1)
            state2 = -1;
          else
            state2 = 1;
        }
        if (state2 == -1 && state == 1)
          state2 = 1;
      }
      if (state == 1)
        shootAngleModifier += .007;
      else if (state == -1)
        shootAngleModifier -= .007;
      shootTimeDeadline = 3;
      shootTimeCurrent ++;
      shootTimeCurrent2 ++;
      if (timer2 >= 60)
      {
        if (shootTimeCurrent >= shootTimeDeadline)
        {
          PVector bulletVel = new PVector(-1, 0);
          float m = bulletVel.mag();
          float a = bulletVel.heading2D();
          a += shootAngleModifier;
          bulletVel.x = m * cos(a);
          bulletVel.y = m * sin(a);
          shootBulletStraightTowards(copy(bulletVel), copy(new PVector(loc.x, loc.y - (bossSize / 2))), 0, -1, 7.5, 17, 0, 0, 30, 1);
          shootBulletStraightTowards(copy(bulletVel), copy(new PVector(loc.x, loc.y + (bossSize / 2))), 0, -1, 7.5, 17, 0, 0, 30, 1);
          shootTimeCurrent = 0;
        }
        if (shootTimeCurrent2 >= shootTimeDeadline2)
        {
          shootBulletStraightTowards(PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc), copy(loc), 0, -1, 5.0, 17, 0, 0, 30, 1);
          shootTimeCurrent2 = 0;
        }
      }
    }
    if (currentWayPoint == 0 && !wayPoint1.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint1, loc));
    if (currentWayPoint == 1 && !wayPoint2.equals(NO_WAYPOINT))
      vel.set(PVector.sub(loc, wayPoint2));
    if (currentWayPoint == 2 && !wayPoint0.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint0, loc));
    vel.setMag(speed);
    loc.add(vel);
    if (loc.dist(wayPoint0) <= speed)
      currentWayPoint = 1;
    if (loc.dist(wayPoint1) <= speed)
      currentWayPoint = 2;
    if (loc.dist(wayPoint2) <= speed)
      currentWayPoint = 0;
  }
}

