abstract class Enemy
{
  PVector[] wayPoints;
  PVector vel, loc;
  int currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue;
  float speed, bulletSpeed;
  boolean facingRight, destroyAfterDestination;

  Enemy(PVector[] wayPoints, PVector vel, PVector loc, int currentWayPoint, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight, boolean destroyAfterDestination)
  {
    this.wayPoints = wayPoints;
    this.vel = vel;
    this.loc = loc;
    this.currentWayPoint = currentWayPoint;
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
    if (loc.dist(wayPoints[7]) <= speed && destroyAfterDestination)
      return false;
    for (int i = 0; i <= 7; i ++)
    {
      if (loc.dist(wayPoints[7]) <= speed && !wayPoints[0].equals(NO_WAYPOINT))
      {
        currentWayPoint = 0;
        break;
      }
      else if (loc.dist(wayPoints[i]) <= speed && !wayPoints[i + 1].equals(NO_WAYPOINT))
      {
        currentWayPoint = i + 1;
        break;
      }
    }

    for (int i = 0; i < 3; i ++)
    {
      if (currentWayPoint == 7 && !wayPoints[0].equals(NO_WAYPOINT))
      {
        vel.set(PVector.sub(wayPoints[0], loc));
        break;
      }
      else if (currentWayPoint == i && !wayPoints[i + 1].equals(NO_WAYPOINT))
      {
        vel.set(PVector.sub(wayPoints[i + 1], loc));
        break;
      }
    }

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

