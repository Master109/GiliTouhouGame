class BulletSplit extends Bullet
{
  PVector wiggleVel;
  int wiggleAmount, splitTimeCurrent, splitTimeDeadline, splitNum, wiggleChangeTimer, wiggleChangeDeadline;
  float rotateAmount;
  boolean hasWiggled;

  BulletSplit(PVector vel, PVector loc, int bulletSize, int wiggleAmount, int wiggleChangeTimer, int wiggleChangeDeadline, int splitTimeDeadline, int splitNum, float speed, float rotateAmount, boolean madeByPlayer)
  {
    super(vel, loc, bulletSize, speed, madeByPlayer);
    this.vel = vel;
    this.loc = loc;
    this.bulletSize = bulletSize;
    this.speed = speed;
    this.exists = true;
    this.madeByPlayer = madeByPlayer;
    this.splitTimeCurrent = 0;
    this.splitTimeCurrent = splitTimeCurrent;
    this.splitTimeDeadline = splitTimeDeadline;
    this.splitNum = splitNum;
  }

  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(255, 0, 255);

    super.show();
  }

  void run()
  {
    super.run();

    if (splitTimeCurrent >= splitTimeDeadline)
    {
      PVector rotateAmount = PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc);
      exists = false;
      float m = rotateAmount.mag();

      for (float a = rotateAmount.heading2D(); a <= PVector.sub(new PVector(p.loc.x - (p.playerSize / 2), p.loc.y), loc).heading2D() + TWO_PI; a += TWO_PI / splitNum)
      {
        rotateAmount.x = m * cos(a);
        rotateAmount.y = m * sin(a);
        splitBullets.add(new BulletStraight(copy(rotateAmount), copy(loc), bulletSize, -1, -1, -1, -1, -1, 8.0, 0.0, false));
      }
      splitTimeCurrent = 0;
    }
    splitTimeCurrent ++;
  }
}

