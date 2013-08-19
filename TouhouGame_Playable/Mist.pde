class Mist
{
  PVector loc;
  int a;
  boolean exists;

  Mist(PVector loc, int a)
  {
    this.loc = loc;
    this.a = a;
    this.exists = true;
  }

  void show()
  {
    stroke(255, 0, 0, a);
    point(loc);
    noStroke();
  }

  void run()
  {
    a -= int(random(5 * gameSpeedMultiplier, 10 * gameSpeedMultiplier));
    if (a <= 0)
      exists = false;
    PVector locNew = PVector.random2D();
    locNew.setMag(3 * gameSpeedMultiplier);
    loc.add(locNew);
  }
}

