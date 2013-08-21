class BulletStraight extends Bullet
{
  PVector wiggleVel;
  int wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline;
  float rotateAmount;
  boolean hasWiggled;

  BulletStraight(PVector vel, PVector loc, int bulletSize, int wiggleAmount, int wiggleChangeTimer, int wiggleChangeDeadline, int splitTimeDeadline, int splitNum, float speed, float rotateAmount, boolean madeByPlayer)
  {
    super(vel, loc, bulletSize, speed, madeByPlayer);
  }

  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(255, 127.5, 0);

    super.show();
  }

  void run()
  {
    super.run();
  }
}

