class BulletWiggle extends Bullet
{
  PVector wiggleVel;
  int wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline;
  float rotateAmount;
  boolean hasWiggled;

  BulletWiggle(PVector vel, PVector loc, int bulletSize, int wiggleAmount, int wiggleChangeTimer, int wiggleChangeDeadline, int splitTimeDeadline, int splitNum, float speed, float rotateAmount, boolean madeByPlayer)
  {
    super(vel, loc, bulletSize, speed, madeByPlayer);
    this.wiggleVel = new PVector();
    this.wiggleAmount = wiggleAmount;
    this.wiggleChangeTimer = 0;
    this.wiggleChangeDeadline = wiggleChangeDeadline;
    this.rotateAmount = rotateAmount;
    this.hasWiggled = false;
  }

  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(BULLET_WIGGLE_COLOR);

    super.show();
  }

  void run()
  {
    vel.limit(speed);
    if (wiggleChangeTimer >= wiggleChangeDeadline)
    {
      float m = wiggleAmount;
      if (!hasWiggled)
      {
        wiggleVel.set(vel);
        float a = wiggleVel.heading2D();
        hasWiggled = true;
        a -= rotateAmount / 2;
        wiggleVel.x = m * cos(a);
        wiggleVel.y = m * sin(a);
      }
      else
      {
        float a = wiggleVel.heading2D();
        if (a == vel.heading2D() + (rotateAmount / 2))
          a -= rotateAmount;
        else
          a += rotateAmount;
        wiggleVel.x = m * cos(a);
        wiggleVel.y = m * sin(a);
      }
      wiggleChangeTimer = 0;
    }
    wiggleChangeTimer ++;
    
    loc.add(wiggleVel);
    loc.add(vel);
  }
}

