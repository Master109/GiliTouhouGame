abstract class Enemy
{
  PVector vel, loc;
  int enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue;
  float speed, bulletSpeed;
  boolean facingRight;

  Enemy(PVector vel, PVector loc, int enemySize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, float speed, float bulletSpeed, boolean facingRight)
  {
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
  }

  void show()
  {
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
    vel.setMag(speed);
    loc.add(vel);

    if (p.loc.x > loc.x)
      facingRight = true;
    else
      facingRight = false;

    shootTimeCurrent ++;

    if (hp <= 0)
    {
      score += xpValue;
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
    bullets.add(new BulletWiggle(copy(targetLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    PVector spreadLoc = copy(targetLoc);
    float m = spreadLoc.mag();
    float a = spreadLoc.heading2D();
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    a += TWO_PI / 15;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
    shootTimeCurrent = 0;
  }

  void moveTowardsYLoc(PVector targetLoc)
  {
    final float OCCILATION_MODIFIER = .05;
    vel.y += OCCILATION_MODIFIER * (targetLoc.y - loc.y);
  }

  void moveTowardsLoc(PVector targetLoc, float curvatureSetMag)
  {
    PVector velChange = PVector.sub(p.loc, loc);
    velChange.setMag(curvatureSetMag);
    vel.add(velChange);
  }

  boolean isTimeToShoot()
  {
    return shootTimeCurrent >= shootTimeDeadline;
  }
}

