class Boss
{
  PVector vel, loc, wayPoint0, wayPoint1, wayPoint2;
  int timer2, shootTimeCurrent2, shootTimeDeadline2, state, state2, bossSize, currentWayPoint, enemySize, hp, shootTimeCurrent, shootTimeDeadline, xpValue, currentSection, timer;
  float speed, bulletSpeed, shootAngleModifier;
  boolean facingRight;

  Boss(PVector wayPoint0, PVector wayPoint1, PVector wayPoint2, PVector vel, PVector loc, int timer2, int shootTimeCurrent2, int shootTimeDeadline2, int state, int state2, int currentWayPoint, int bossSize, int hp, int shootTimeCurrent, int shootTimeDeadline, int xpValue, int currentSection, int timer, float rotateAmount, float speed, float bulletSpeed, float shootAngleModifier)
  {
    this.wayPoint0 = wayPoint0;
    this.wayPoint1 = wayPoint1;
    this.wayPoint2 = wayPoint2;
    this.vel = vel;
    this.loc = loc;
    this.timer2 = timer2;
    this.shootTimeCurrent2 = shootTimeCurrent2;
    this.shootTimeDeadline2 = shootTimeDeadline2;
    this.state = state;
    this.state2 = state2;
    this.bossSize = bossSize;
    this.hp = hp;
    this.shootTimeCurrent = shootTimeCurrent;
    this.shootTimeDeadline = shootTimeDeadline;
    this.xpValue = xpValue;
    this.currentSection = currentSection;
    this.timer = timer;
    this.speed = speed;
    this.bulletSpeed = bulletSpeed;
    this.facingRight = facingRight;
    this.shootAngleModifier = shootAngleModifier;
  }

  void show()
  {
    fill(127.5);
    stroke(ENEMY_COLOR);
    ellipse(loc, bossSize);
  }

  void run()
  {
  }

  void shootBulletStraightTowards(PVector targetLoc, PVector shootLoc, float rotateAmount, float spreadRange, float bulletSpeed, int wiggleChangeDeadline, int wiggleChangeTimer, int wiggleAmount, int bulletSize, int bulletNum)
  {
    PVector spreadLoc = copy(targetLoc);
    float m = spreadLoc.mag();
    float a = spreadLoc.heading2D();
    a += shootAngleModifier;
    spreadLoc.x = m * cos(a);
    spreadLoc.y = m * sin(a);
    if (spreadRange != -1)
    {
      for (float a2 = spreadLoc.heading2D(); a2 <= spreadLoc.heading2D() + spreadRange * 2; a2 += spreadRange / bulletNum)
      {
        bullets.add(new BulletStraight(copy(spreadLoc), copy(shootLoc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
        spreadLoc.x = m * cos(a2);
        spreadLoc.y = m * sin(a2);
      }
    }
    else
      bullets.add(new BulletStraight(copy(targetLoc), copy(shootLoc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
  }

  void shootBulletWiggleTowards(PVector targetLoc, PVector wiggleVel, float rotateAmount, float spreadRange, float bulletSpeed, int wiggleChangeDeadline, int wiggleChangeTimer, int wiggleAmount, int bulletSize, int bulletNum)
  {
    PVector spreadLoc = copy(targetLoc);
    float m = spreadLoc.mag();
    for (float a = spreadLoc.heading2D(); a <= spreadLoc.heading2D() + spreadRange * 2; a += spreadRange / bulletNum)
    {
      bullets.add(new BulletWiggle(copy(spreadLoc), copy(loc), bulletSize, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline, -1, -1, bulletSpeed, rotateAmount, false));
      spreadLoc.x = m * cos(a);
      spreadLoc.y = m * sin(a);
    }
  }
}

