PFont font;

Player p;

ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Bullet> splitBullets;
ArrayList<Mist> mists;

int[] enemyAppearDeadlines;
int score;
int bombsRemaining;

float[] enemyAppearTimes;
float timer;

boolean[] keys;
boolean autoFire;
boolean shouldRestart;
boolean paused;
boolean viewingHelpScreen;
boolean showEffects;

final color ENEMY_COLOR = color(255, 0, 0);
final color BULLET_WIGGLE_COLOR = color(0, 0, 255);
final color TERRAIN_COLOR = color(255);
final int NUM_OF_ENEMY_TYPES = 4;
final int FONT_SIZE = 32;

void setup()
{
  size(displayWidth, displayHeight);
  smooth();
  noStroke();
  strokeWeight(5);
  rectMode(CENTER);
  background(255);
  keys = new boolean[5];
  autoFire = true;
  viewingHelpScreen = true;
  showEffects = true;

  reset();
}

void reset()
{
  paused = false;
  shouldRestart = false;
  font = createFont("Arial", FONT_SIZE);
  textFont(font);

  timer = 0;
  score = 0;
  bombsRemaining = 3;
  enemyAppearTimes = new float[NUM_OF_ENEMY_TYPES];
  enemyAppearDeadlines = new int[NUM_OF_ENEMY_TYPES];
  enemyAppearDeadlines[0] = 2000;
  enemyAppearDeadlines[1] = 1250;
  enemyAppearDeadlines[2] = 475;
  enemyAppearDeadlines[3] = 2750;

  p = new Player(new PVector(), new PVector(width / 2, height / 2), new PVector(), 20, 1, 0, 5.0, true);
  bullets = new ArrayList<Bullet>();
  splitBullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  mists = new ArrayList<Mist>();

  //Enemy e = new EnemyMoveTowardsPlayer(new PVector(), new PVector(random(width), random(height)), 25, 10, 0, 100, 7.0, 7.0, true);
  //enemies.add(e);
  //Enemy e = new EnemyShootHeadOn(new PVector(), new PVector(random(width), random(height)), 25, 30, 0, 7, 7.0, 2.0, true);
  //enemies.add(e);
  Enemy e = new EnemyshootBulletStraightTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 25, 15, 0, 60, 2, 7.0, 8.5, true);
  enemies.add(e);
  //Enemy e = new EnemyshootBulletStraightTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 25, 30, 0, 20, 7.0, 7.0, true);
  //enemies.add(e);
  while (e.loc.dist (p.loc) <= 500)
    e.loc.set(random(width), random(height), 0);
  //terrains.add(new Terrain(new PVector(-5, 0), new PVector(width, height), new PVector(100, 500)));
}


void draw()
{
  if (viewingHelpScreen)
  {
    background(127.5);
    fill(0);
    textAlign(CENTER, TOP);
    text("Controls:", width / 2, 0);
    text("W: Move up", width / 2, FONT_SIZE);
    text("A: Move left", width / 2, FONT_SIZE * 2);
    text("S: Move down", width / 2, FONT_SIZE * 3);
    text("D: Move right", width / 2, FONT_SIZE * 4);
    text("Left arrow key: Face left", width / 2, FONT_SIZE * 5);
    text("Right arrow key: Face right", width / 2, FONT_SIZE * 6);
    text("Shift: You move slower while pressing it", width / 2, FONT_SIZE * 7);
    text("Space: Destroy all bullets and enemies on screen for no score", width / 2, FONT_SIZE * 8);
    text("R: Reset", width / 2, FONT_SIZE * 9);
    text("F: Toggle autofire", width / 2, FONT_SIZE * 10);
    text("N: Skip time until next wave", width / 2, FONT_SIZE * 11);
    text("P: Toggle pause and visibility of covered text", width / 2, FONT_SIZE * 12);
    text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
    text("H: PLAY!... or return to this boring screen", width / 2, FONT_SIZE * 14);
  }
  else
  {
    if (paused)
    {
      textAlign(LEFT, TOP);
      fill(0);
      text("Score: " + score, 0, 0);
      textAlign(CENTER, TOP);
      text(timer, width / 2, 0);
      textAlign(RIGHT, TOP);
      text("Bombs: " + bombsRemaining, width, 0);
    }

    if (shouldRestart)
      return;

    if (!paused)
    {
      timer += 1 / frameRate;

      ArrayList<Enemy> survivingEnemies = new ArrayList<Enemy>();

      for (int i = 0; i <= NUM_OF_ENEMY_TYPES - 1; i ++)
        enemyAppearTimes[i] ++;

      p.move();

      fill(127.5, 175);
      rect(width / 2, height / 2, width, height);

      textAlign(LEFT, TOP);
      fill(0);
      text("Score: " + score, 0, 0);
      textAlign(CENTER, TOP);
      text(timer, width / 2, 0);
      textAlign(RIGHT, TOP);
      text("Bombs: " + bombsRemaining, width, 0);


      for (int i = 0; i <= NUM_OF_ENEMY_TYPES - 1; i ++)
      {
        if (enemyAppearTimes[i] >= enemyAppearDeadlines[i])
        {
          if (i == 0)
          {
            Enemy e = new EnemyMoveTowardsPlayer(new PVector(), new PVector(random(width), random(height)), 30, 10, 0, 60, 7, 7.0, 7.0, true);
            enemies.add(e);
            while (e.loc.dist (p.loc) <= 500)
              e.loc.set(random(width), random(height), 0);
          }
          else if (i == 1)
          {
            Enemy e = new EnemyShootHeadOn(new PVector(), new PVector(random(width), random(height)), 25, 30, 0, 10, 5, 7.0, 2.0, true);
            enemies.add(e);
            while (e.loc.dist (p.loc) <= 500)
              e.loc.set(random(width), random(height), 0);
          }
          else if (i == 2)
          {
            Enemy e = new EnemyshootBulletStraightTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 25, 15, 0, 60, 2, 7.0, 8.5, true);
            enemies.add(e);
            while (e.loc.dist (p.loc) <= 500)
              e.loc.set(random(width), random(height), 0);
          }
          else if (i == 3)
          {
            Enemy e = new EnemyShootWigglyBulletSpread(new PVector(), new PVector(random(width), random(height)), 25, 25, -1, 25, 3, .75 * PI, 2.0, 7.5, true);
            enemies.add(e);
            while (e.loc.dist (p.loc) <= 500)
              e.loc.set(random(width), random(height), 0);
          }
          enemyAppearTimes[i] = 0;
          enemyAppearDeadlines[i] *= .95;
        }
      }

      for (Bullet b : bullets)
      {
        if (!b.exists)
        {
          bullets.remove(b);
          break;
        }
      }

      for (Bullet b : splitBullets)
        bullets.add(b);

      splitBullets.clear();

      for (Enemy e : enemies)
      {
        boolean survived = e.run();
        if (survived)
        {
          e.show();
          survivingEnemies.add(e);
        }
      }

      enemies = survivingEnemies;

      for (int i = 0; i <= mists.size(); i ++)
      {
        for (Mist m : mists)
        {
          if (!m.exists)
          {
            mists.remove(m);
            break;
          }
        }
      }

      for (Bullet b : bullets)
      {
        b.run();
        b.show();
      }

      for (Mist m : mists)
      {
        m.run();
        m.show();
      }

      p.run();
      p.show();
    }
  }
}

void keyPressed()
{
  if (key == 'a' || key == 'A')
    keys[0] = true;
  if (key == 'd' || key == 'D')
    keys[1] = true;
  if (key == 'w' || key == 'W')
    keys[2] = true;
  if (key == 's' || key == 'S')
    keys[3] = true;
  if (keyCode == SHIFT)
    keys[4] = true;
  if (key == 'p' || key == 'P')
    paused = !paused;
  if (key == 'r' || key == 'R')
    reset();
  if (key == 'f' || key == 'F')
    autoFire = !autoFire;
  if (key == 'n' || key == 'N')
  {
    float minEnemyAppearTime = 999999999;
    boolean shouldBreak = false;
    for (int i = 0; i <= NUM_OF_ENEMY_TYPES - 1; i ++)
    {
      if (enemyAppearDeadlines[i] - enemyAppearTimes[i] < minEnemyAppearTime)
        minEnemyAppearTime = enemyAppearDeadlines[i] - enemyAppearTimes[i];
    }
    for (int i = 0; i <= NUM_OF_ENEMY_TYPES - 1; i ++)
    {
      if (minEnemyAppearTime == enemyAppearDeadlines[i] - enemyAppearTimes[i])
      {
        for (int i2 = 0; i2 <= NUM_OF_ENEMY_TYPES - 1; i2 ++)
        {
          enemyAppearTimes[i2] += minEnemyAppearTime;
        }
        shouldBreak = true;
      }
      if (shouldBreak)
        break;
    }
  }
  if (key == 'h' || key == 'H')
  {
    viewingHelpScreen = !viewingHelpScreen;
  }
  if (key == 'l' || key == 'L')
  {
    showEffects = !showEffects;
  }
  if (key == ' ' && bombsRemaining > 0 && !paused && !viewingHelpScreen)
  {
    bullets.clear();
    splitBullets.clear();
    enemies.clear();
    bombsRemaining --;
  }
}

void keyReleased()
{
  if (key == 'a' || key == 'A')
    keys[0] = false;
  if (key == 'd' || key == 'D')
    keys[1] = false;
  if (key == 'w' || key == 'W')
    keys[2] = false;
  if (key == 's' || key == 'S')
    keys[3] = false;
  if (keyCode == SHIFT)
    keys[4] = false;
}

