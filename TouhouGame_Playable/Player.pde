class Player
{
  PVector vel, loc, nextLoc;
  int playerSize, hp, shootTime, shootState;
  float speed, shootAngle;
  boolean facingRight;

  Player(PVector vel, PVector loc, PVector nextLoc, int playerSize, int hp, int shootTime, float speed, boolean facingRight)
  {
    this.vel = vel;
    this.loc = loc;
    this.nextLoc = nextLoc;
    this.playerSize = playerSize;
    this.hp = hp;
    this.shootTime = shootTime;
    this.speed = speed;
    this.facingRight = facingRight;
    shootState = 1;
  }

  void show()
  {
    fill(127.5);
    stroke(0, 255, 0);

    pushMatrix();
    if (!facingRight)
    {
      translate(new PVector(loc.x - (playerSize / 2), loc.y));
      triangle(-playerSize, 0, playerSize, playerSize, playerSize, -playerSize);
    }
    else
    {
      translate(new PVector(loc.x - (playerSize / 2), loc.y));
      rotate(PI);
      triangle(-playerSize, 0, playerSize, playerSize, playerSize, -playerSize);
    }
    popMatrix();

    stroke(255, 0, 0);
    strokeWeight(10);
    point(new PVector(loc.x - (playerSize / 2), loc.y));
    noStroke();
    strokeWeight(5);
  }

  void run()
  {
    int reloadSpeed = 1;
    if (perkEquiped[0] == 1)
      reloadSpeed = reloadSpeedCost - 1;
    if (shootTime >= 6 - (reloadSpeed - 1) && (mousePressed || autoFire))
    {
      final int BULLET_SPEED = 999999999;
      PVector direction;
      if (facingRight)
        direction = new PVector(BULLET_SPEED, 0);
      else
        direction = new PVector(-BULLET_SPEED, 0);

      if (perkEquiped[12] == 1)
        bulletSprayRange = PI / 10;
      else if (perkEquiped[12] == -1)
        bulletSprayRange = 0;

      float m = direction.mag();
      float a = direction.heading2D();
      if (perkEquiped[12] == 1)
      {
        if (shootAngle > bulletSprayRange)
          shootState = 1;
        else if (shootAngle < -bulletSprayRange)
          shootState = -1;
        if (shootState == -1)
          shootAngle += bulletSprayRange / 7.5;
        if (shootState == 1)
          shootAngle -= bulletSprayRange / 7.5;
      }
      a += shootAngle;
      direction.x = m * cos(a);
      direction.y = m * sin(a);

      bullets.add(new BulletStraight(copy(direction), new PVector(loc.x - (playerSize / 2), loc.y), 5, -1, -1, -1, -1, 10, 8.0, 0.0, true));

      shootTime = 0;
    }
    shootTime ++;

    if (keyCode == LEFT)
      facingRight = false; 
    else if (keyCode == RIGHT)
      facingRight = true;

<<<<<<< HEAD
    if (get(int(loc.x - (playerSize / 2)), int(loc.y)) == ENEMY_COLOR)
=======
    if (get(int(loc.x - (playerSize / 2)), int(loc.y)) == ENEMY_COLOR || get(int(loc.x - (playerSize / 2)), int(loc.y)) == color(0, 0, 255))
>>>>>>> 665ba591d88ec9f154f064759fa2dea03e21ab81
      shouldRestart = true;
  }

  void move()
  {
    vel.set(0, 0, 0);

    if (keys[4])
      speed = 2;
    else
      speed = 5.0;

    if (keys[0] || keys[1] || keys[2] || keys[3])
    {
      if (keys[0])
        vel.x = -speed;
      if (keys[1])
        vel.x = speed;
      if (keys[2])
        vel.y = -speed;
      if (keys[3])
        vel.y = speed;
      vel.setMag(speed);
    }
    nextLoc.set(PVector.add(loc, vel));

    boolean onMap = nextLoc.x - (playerSize / 2) > 0 && nextLoc.x - (playerSize / 2) < width && nextLoc.y > 0 && nextLoc.y < height;
    if (onMap)
      loc.set(nextLoc);
  }
}

