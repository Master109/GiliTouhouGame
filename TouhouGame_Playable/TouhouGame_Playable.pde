PFont font;

Player p;

ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Bullet> splitBullets;
ArrayList<Mist> mists;

float[] enemyAppearDeadlines;
int[] holdKeyTimers;
int currentHelpScreen;
int score;
int bombNum;
int currentLevel;

float[] enemyAppearTimes;
float playTimer;
float gameSpeedMultiplier;
float gameSpeedDivider;

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
  size(900, 725);
  smooth();
  noStroke();
  strokeWeight(5);
  rectMode(CENTER);
  background(255);
  currentHelpScreen = 0;
  keys = new boolean[6];
  autoFire = true;
  viewingHelpScreen = true;
  showEffects = true;
  currentLevel = -1;
  holdKeyTimers = new int[12];
  gameSpeedMultiplier = 1;
  gameSpeedDivider = 1;

  reset();
}

void reset()
{
  paused = false;
  shouldRestart = false;
  font = createFont("Arial", FONT_SIZE);
  textFont(font);

  playTimer = 0;
  score = 0;
  bombNum = 3;
  enemyAppearTimes = new float[NUM_OF_ENEMY_TYPES];
  enemyAppearDeadlines = new float[NUM_OF_ENEMY_TYPES];
  enemyAppearDeadlines[0] = 2000 * gameSpeedMultiplier;
  enemyAppearDeadlines[1] = 1250 * gameSpeedMultiplier;
  enemyAppearDeadlines[2] = 475 * gameSpeedMultiplier;
  enemyAppearDeadlines[3] = 2500 * gameSpeedMultiplier;

  p = new Player(new PVector(), new PVector(width / 2, height / 2), new PVector(), 20, 1, 0, 5.0, true);
  bullets = new ArrayList<Bullet>();
  splitBullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  mists = new ArrayList<Mist>();

  //Enemy e = new EnemyMoveTowardsPlayer(new PVector(), new PVector(random(width), random(height)), 25, 10, 0, 100, 7.0, 7.0, true);
  //enemies.add(e);
  //Enemy e = new EnemyShootHeadOn(new PVector(), new PVector(random(width), random(height)), 25, 30, 0, 7, 7.0, 2.0, true);
  //enemies.add(e);
  Enemy e = new EnemyShootBulletStraightTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 25, 15, 0, 60, 2, 7.0, 8.5, true);
  enemies.add(e);
  //Enemy e = new EnemyshootBulletStraightTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 25, 30, 0, 20, 7.0, 7.0, true);
  //enemies.add(e);
  while (e.loc.dist (p.loc) <= 500)
    e.loc.set(random(width), random(height), 0);
  //terrains.add(new Terrain(new PVector(-5, 0), new PVector(width, height), new PVector(100, 500)));
}


void draw()
{
  if (key == '0' || key == ')')
    holdKeyTimers[0] ++;
  else
    holdKeyTimers[0] = 0;

  if (key == '1' || key == '@')
    holdKeyTimers[1] ++;
  else
    holdKeyTimers[1] = 0;

  if (keys[5])
    holdKeyTimers[11] ++;
  else
    holdKeyTimers[11] = 0;

  if (holdKeyTimers[0] >= 75)
  {
    currentLevel = 0;
    viewingHelpScreen = false;
  }
  else if (holdKeyTimers[1] >= 75)
  {
    currentLevel = 1;
    viewingHelpScreen = false;
  }
  else if (holdKeyTimers[11] >= 75)
    reset();
  if (viewingHelpScreen)
  {
    background(127.5);
    fill(0);
    textAlign(CENTER, TOP);
    if (currentHelpScreen == 0)
    {
      text("Controls:", width / 2, 0);
      text("W: Move up", width / 2, FONT_SIZE);
      text("A: Move left", width / 2, FONT_SIZE * 2);
      text("S: Move down", width / 2, FONT_SIZE * 3);
      text("D: Move right", width / 2, FONT_SIZE * 4);
      text("Left or right arrow key: Face left or right", width / 2, FONT_SIZE * 5);
      text("Shift: You move slower while pressing it", width / 2, FONT_SIZE * 6);
      text("Space: Destroy all bullets and enemies on screen for no score", width / 2, FONT_SIZE * 7);
      text("Hold R: Reset", width / 2, FONT_SIZE * 8);
      text("Hold F: Toggle autofire", width / 2, FONT_SIZE * 9);
      text("N: Skip time until next enemy arrives", width / 2, FONT_SIZE * 10);
      text("T: Toggle faster game speed", width / 2, FONT_SIZE * 11);
      text("P: Toggle pause and visibility of covered text", width / 2, FONT_SIZE * 12);
      text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
      text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 14);
      text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 15);
      text("H: Toggle this boring screen (won't work now, and the puzzle)", width / 2, FONT_SIZE * 16);
      text("to make it work is too hard for u. MUHAHAHAHA!)", width / 2, FONT_SIZE * 17);
    }

    else if (currentHelpScreen == 1)
    {
      text("Controls:", width / 2, 0);
      text("W: Move up", width / 2, FONT_SIZE);
      text("A: Move left", width / 2, FONT_SIZE * 2);
      text("S: Move down", width / 2, FONT_SIZE * 3);
      text("D: Move right", width / 2, FONT_SIZE * 4);
      text("Left or right arrow key: Face left or right", width / 2, FONT_SIZE * 5);
      text("Shift: You move slower while pressing it", width / 2, FONT_SIZE * 6);
      text("Space: Destroy all bullets and enemies on screen for no score", width / 2, FONT_SIZE * 7);
      text("Hold R: Reset", width / 2, FONT_SIZE * 8);
      text("Hold F: Toggle autofire", width / 2, FONT_SIZE * 9);
      text("N: Skip time until next enemy arrives", width / 2, FONT_SIZE * 10);
      text("T: Toggle faster game speed", width / 2, FONT_SIZE * 11);
      text("P: Toggle pause and visibility of covered text", width / 2, FONT_SIZE * 12);
      text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
      text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 14);
      text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 15);
      text("H: Toggle this screen", width / 2, FONT_SIZE * 16);
      text("It's touching that u returned to this exciting screen for", width / 2, FONT_SIZE * 17);
      text("another joke... but too bad", width / 2, FONT_SIZE * 18);
    }

    else if (currentHelpScreen == 2)
    {
      text("Controls:", width / 2, 0);
      text("W: Move up", width / 2, FONT_SIZE);
      text("A: Move left", width / 2, FONT_SIZE * 2);
      text("S: Move down", width / 2, FONT_SIZE * 3);
      text("D: Move right", width / 2, FONT_SIZE * 4);
      text("Left or right arrow key: Face left or right", width / 2, FONT_SIZE * 5);
      text("Shift: You move slower while pressing it", width / 2, FONT_SIZE * 6);
      text("Space: Destroy all bullets and enemies on screen for no score", width / 2, FONT_SIZE * 7);
      text("Hold R: Reset", width / 2, FONT_SIZE * 8);
      text("Hold F: Toggle autofire", width / 2, FONT_SIZE * 9);
      text("N: Skip time until next enemy arrives", width / 2, FONT_SIZE * 10);
      text("T: Toggle faster game speed", width / 2, FONT_SIZE * 11);
      text("P: Toggle pause and visibility of covered text", width / 2, FONT_SIZE * 12);
      text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
      text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 14);
      text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 15);
      text("H: Toggle this screen", width / 2, FONT_SIZE * 16);
      text("Ah, now I know alot about u. To come back here you are either", width / 2, FONT_SIZE * 17);
      text("thoughtful or careless. Or someone pressed the button for u. Or", width / 2, FONT_SIZE * 18);
      text("some combination of the three.", width / 2, FONT_SIZE * 19);
    }

    else if (currentHelpScreen == 3)
    {
      textAlign(CENTER, TOP);
      text("Controls:", width / 2, 0);
      text("W: Move up", width / 2, FONT_SIZE);
      text("A: Move left", width / 2, FONT_SIZE * 2);
      text("S: Move down", width / 2, FONT_SIZE * 3);
      text("D: Move right", width / 2, FONT_SIZE * 4);
      text("Left or right arrow key: Face left or right", width / 2, FONT_SIZE * 5);
      text("Shift: You move slower while pressing it", width / 2, FONT_SIZE * 6);
      text("Space: Destroy all bullets and enemies on screen for no score", width / 2, FONT_SIZE * 7);
      text("Hold R: Reset", width / 2, FONT_SIZE * 8);
      text("Hold F: Toggle autofire", width / 2, FONT_SIZE * 9);
      text("N: Skip time until next enemy arrives", width / 2, FONT_SIZE * 10);
      text("T: Toggle faster game speed", width / 2, FONT_SIZE * 11);
      text("P: Toggle pause and visibility of covered text", width / 2, FONT_SIZE * 12);
      text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
      text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 14);
      text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 15);
      text("H: Toggle this screen", width / 2, FONT_SIZE * 16);
      text("Oh, u want to know about me, u ask? You can choose my", width / 2, FONT_SIZE * 17);
      text("name, and I am good at everthing: Video-games, writing,", width / 2, FONT_SIZE * 18);
      text("surfing, the opposite sex (u can decide if I am male or", width / 2, FONT_SIZE * 19);
      text("female), talking, self-control, driving vehicles, music, circus", width / 2, FONT_SIZE * 20);
      text("toys and sports. Oh yeah, and life.", width / 2, FONT_SIZE * 21);
    }

    else if (currentHelpScreen == 4)
    {
      textAlign(CENTER, TOP);
      text("Controls:", width / 2, 0);
      text("W: Move up", width / 2, FONT_SIZE);
      text("A: Move left", width / 2, FONT_SIZE * 2);
      text("S: Move down", width / 2, FONT_SIZE * 3);
      text("D: Move right", width / 2, FONT_SIZE * 4);
      text("Left or right arrow key: Face left or right", width / 2, FONT_SIZE * 5);
      text("Shift: You move slower while pressing it", width / 2, FONT_SIZE * 6);
      text("Space: Destroy all bullets and enemies on screen for no score", width / 2, FONT_SIZE * 7);
      text("Hold R: Reset", width / 2, FONT_SIZE * 8);
      text("Hold F: Toggle autofire", width / 2, FONT_SIZE * 9);
      text("N: Skip time until next enemy arrives", width / 2, FONT_SIZE * 10);
      text("T: Toggle faster game speed", width / 2, FONT_SIZE * 11);
      text("P: Toggle pause and visibility of covered text", width / 2, FONT_SIZE * 12);
      text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
      text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 14);
      text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 15);
      text("H: Toggle this screen", width / 2, FONT_SIZE * 16);
      text("I'm especially good at music, though. Wanna hear me rap? I", width / 2, FONT_SIZE * 17);
      text("can rap so fast! {Insert name here takes in a huge breath}", width / 2, FONT_SIZE * 18);
    }

    else if (currentHelpScreen == 5)
      background(0);

    else if (currentHelpScreen == 6)
    {
      text("Controls:", width / 2, 0);
      text("W: Move up", width / 2, FONT_SIZE);
      text("A: Move left", width / 2, FONT_SIZE * 2);
      text("S: Move down", width / 2, FONT_SIZE * 3);
      text("D: Move right", width / 2, FONT_SIZE * 4);
      text("Left or right arrow key: Face left or right", width / 2, FONT_SIZE * 5);
      text("Shift: You move slower while pressing it", width / 2, FONT_SIZE * 6);
      text("Space: Destroy all bullets and enemies on screen for no score", width / 2, FONT_SIZE * 7);
      text("Hold R: Reset", width / 2, FONT_SIZE * 8);
      text("Hold F: Toggle autofire", width / 2, FONT_SIZE * 9);
      text("N: Skip time until next enemy arrives", width / 2, FONT_SIZE * 10);
      text("T: Toggle faster game speed", width / 2, FONT_SIZE * 11);
      text("P: Toggle pause and visibility of covered text", width / 2, FONT_SIZE * 12);
      text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
      text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 14);
      text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 15);
      text("H: Toggle this screen", width / 2, FONT_SIZE * 16);
      text("{Insert name here pants heavily} Did you even hear what I said?", width / 2, FONT_SIZE * 17);
      text("I crammed a lot of words together.", width / 2, FONT_SIZE * 18);
    }
  }
  else
  {    
    if (currentLevel == 0)
    {
      if (paused)
      {
        textAlign(LEFT, TOP);
        fill(0);
        text("Score: " + score, 0, 0);
        textAlign(CENTER, TOP);
        text(playTimer, width / 2, 0);
        textAlign(RIGHT, TOP);
        text("Bombs: " + bombNum, width, 0);
      }

      if (shouldRestart)
        return;

      if (!paused)
      {
        playTimer += 1 / frameRate * gameSpeedMultiplier;

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
        text(playTimer, width / 2, 0);
        textAlign(RIGHT, TOP);
        text("Bombs: " + bombNum, width, 0);


        for (int i = 0; i <= NUM_OF_ENEMY_TYPES - 1; i ++)
        {
          if (enemyAppearTimes[i] >= enemyAppearDeadlines[i])
          {
            enemyAppearDeadlines[0] = 2000 * gameSpeedMultiplier;
            enemyAppearDeadlines[1] = 1250 * gameSpeedMultiplier;
            enemyAppearDeadlines[2] = 475 * gameSpeedMultiplier;
            enemyAppearDeadlines[3] = 2500 * gameSpeedMultiplier;
            if (i == 0)
            {
              Enemy e = new EnemyMoveTowardsPlayer(new PVector(), new PVector(random(width), random(height)), 30, 10, 0, 60, 9, 7.0, 7.0, true);
              enemies.add(e);
              while (e.loc.dist (p.loc) <= 500)
                e.loc.set(random(width), random(height), 0);
            }
            else if (i == 1)
            {
              Enemy e = new EnemyShootHeadOn(new PVector(), new PVector(random(width), random(height)), 25, 30, 0, 10, 7, 7.0, 2.0, true);
              enemies.add(e);
              while (e.loc.dist (p.loc) <= 500)
                e.loc.set(random(width), random(height), 0);
            }
            else if (i == 2)
            {
              Enemy e = new EnemyShootBulletStraightTowardsPredicted(new PVector(), new PVector(random(width), random(height)), 25, 15, 0, 60, 2, 7.0, 8.5, true);
              enemies.add(e);
              while (e.loc.dist (p.loc) <= 500)
                e.loc.set(random(width), random(height), 0);
            }
            else if (i == 3)
            {
              Enemy e = new EnemyShootWigglyBulletSpread(new PVector(), new PVector(random(width), random(height)), 25, 25, -1, 25, 15, .75 * PI, 2.0, 7.5, true);
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
    else if (currentLevel == 1)
    {
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
  if ((key == 'p' || key == 'P') && !viewingHelpScreen)
    paused = !paused;
  if ((key == 'r' || key == 'R') && shouldRestart)
    reset();
  if (key == 'r' || key == 'R')
    keys[5] = true;
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
  if (key == 't' || key == 'T')
  {
    if (gameSpeedMultiplier == 1)
    {
      gameSpeedMultiplier = 1.25;
      gameSpeedDivider = gameSpeedMultiplier - 1 / 10;
    }
    else
    {
      gameSpeedMultiplier = 1;
      gameSpeedDivider = 1;
    }
  }
  if (key == 'h' || key == 'H')
  {
    viewingHelpScreen = !viewingHelpScreen;
    if (viewingHelpScreen)
    {
      if (currentHelpScreen < 6)
        currentHelpScreen ++;
      else
        currentHelpScreen = 0;
    }
  }
  if (key == 'l' || key == 'L')
    showEffects = !showEffects;
  if (key == ' ' && bombNum > 0 && !paused && !viewingHelpScreen)
  {
    bullets.clear();
    splitBullets.clear();
    enemies.clear();
    bombNum --;
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
  if (key == 'r' || key == 'R')
    keys[5] = false;
}

