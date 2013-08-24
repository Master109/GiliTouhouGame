abstract class Enemy
{
  PVector vel, loc, wayPoint0, wayPoint1, wayPoint2, wayPoint3;
  int currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue;
  float speed, bulletSpeed;
  boolean facingRight, destroyAfterDestination;

  Enemy(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector wayPoint3, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    this.wayPoint0 = wayPoint0;
    this.wayPoint1 = wayPoint1;
    this.wayPoint2 = wayPoint2;
    this.wayPoint3 = wayPoint3;
    this.vel = vel;
    this.loc = loc;
    this.enemySize = enemySize;
    this.hp = hp;
    this.shootTimeCurrent = shootTimeCurrent;
    this.shootTimeDeadline = shootTimeDeadline;
    this.xpValue = xpValue;
    this.speed = speed;
    this.bulletSpeed = bulletSpeed;
    this.facingRight = facingRight;
    this.destroyAfterDestination = destroyAfterDestination;
  }

  void show()
  {
    fill(255, 0, 0);
    ellipse(loc, enemySize);
    if (showEffects)
    {
      for (int i = 0; i <= 20; i ++)
      {
        int r = int(random(1, 10));
        if (r == 1)
        {
          PVector offset = PVector.random2D();
          offset.setMag(random(enemySize / 2, enemySize / 2 + 10));
          mists.add(new Mist(PVector.add(loc, offset), int(random(127, 255))));
        }
      }
    }
  }

  //Returns true when the enemy survives
  boolean run()
  {
    if (loc.dist(wayPoint3) <= speed && destroyAfterDestination)
      return false;
    if (currentWayPoint == -1 && !wayPoint1.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint1, loc));
    if (currentWayPoint == -2 && !wayPoint2.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint2, loc));
    if (currentWayPoint == -3 && !wayPoint3.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint3, loc));
    if (currentWayPoint == -4 && !wayPoint0.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint0, loc));
    if (loc.dist(wayPoint0) <= speed && !wayPoint1.equals(NO_WAYPOINT))
      currentWayPoint = 1;
    if (loc.dist(wayPoint1) <= speed && !wayPoint2.equals(NO_WAYPOINT))
      currentWayPoint = 2;
    if (loc.dist(wayPoint2) <= speed && !wayPoint3.equals(NO_WAYPOINT))
      currentWayPoint = 3;
    if (loc.dist(wayPoint3) <= speed && !wayPoint0.equals(NO_WAYPOINT))
      currentWayPoint = 0;

    if (currentWayPoint == 0 && !wayPoint1.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint1, loc));
    if (currentWayPoint == 1 && !wayPoint2.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint2, loc));
    if (currentWayPoint == 2 && !wayPoint3.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint3, loc));
    if (currentWayPoint == 3 && !wayPoint0.equals(NO_WAYPOINT))
      vel.set(PVector.sub(wayPoint0, loc));

    vel.setMag(speed);
    loc.add(vel);

    if (p.loc.x - (p.playerSize / 2) > loc.x)
      facingRight = true;
    else
      facingRight = false;

    shootTimeCurrent ++;

    if (hp <= 0)
    {
      float killsIntoScoreModifier2 = 0;
      if (perkEquiped[6] == 1)
        killsIntoScoreModifier2 = killsIntoScoreModifier;
      score += xpValue + killsIntoScoreModifier2;
      kills ++;
      return false;
    }
    else
      return true;
  }

  void shootBulletStraightTowards(PVector targetLoc, float bulletSpeed, int bulletSize)
  {
    bullets.add(new BulletStraight(copy(PVector.sub(targetLoc, loc)), copy(loc), bulletSize, -1, -1, -1, -1, -1, bulletSpeed, 0.0, false));

    shootTimeCurrent = 0;
  }

  void shootBulletWiggleTowards(PVector targetLoc, PVector wiggleVel, float rotateAmount, float spreadRange, float bulletSpeed, int wiggleChangeDeadline, int wiggleChangeTimer, int wiggleAmount, int bulletSize, int bulletNum)
  {
    PVector spreadLoc = copy(targetLoc);
    float m = spreadLoc.mag();
    bullets.add(new BulletWiggle(targetLoc, copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    for (float a = spreadLoc.heading2D() + (spreadRange / bulletNum / 2); a <= targetLoc.heading2D() + (spreadRange / 2); a += spreadRange / bulletNum / 2)
    {
      spreadLoc.x = m * cos(a);
      spreadLoc.y = m * sin(a);
      bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    }
    spreadLoc = copy(targetLoc);
    for (float a = spreadLoc.heading2D() - (spreadRange / bulletNum / 2); a >= targetLoc.heading2D() - (spreadRange / 2); a -= spreadRange / bulletNum / 2)
    {
      spreadLoc.x = m * cos(a);
      spreadLoc.y = m * sin(a);
      bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    }
  }
  void shootBulletWiggleTowards2(PVector targetLoc, PVector wiggleVel, float rotateAmount, float spreadRange, float bulletSpeed, int wiggleChangeDeadline, int wiggleChangeTimer, int wiggleAmount, int bulletSize, int bulletNum)
  {
    PVector spreadLoc = copy(targetLoc);
    float m = spreadLoc.mag();
    for (float a = spreadLoc.heading2D(); a <= targetLoc.heading2D() + spreadRange; a += spreadRange / bulletNum)
    {
      bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
      spreadLoc.x = m * cos(a);
      spreadLoc.y = m * sin(a);
    }
  }

  void moveTowardsYLoc(PVector targetLoc)
  {
    final float OCCILATION_MODIFIER = .05;
    vel.y += OCCILATION_MODIFIER * (targetLoc.y - loc.y);
  }

  void moveTowardsLoc(PVector targetLoc, float curvatureSetMag)
  {
    PVector velChange = PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc);
    velChange.setMag(curvatureSetMag);
    vel.add(velChange);
  }

  boolean isTimeToShoot()
  {
    return shootTimeCurrent >= shootTimeDeadline;
  }
}

