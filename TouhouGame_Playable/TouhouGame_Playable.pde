PFont font;

Player p;
Level1 l1;
Boss1 b1;

ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets, splitBullets;
ArrayList<Mist> mists;

int[] holdKeyTimers;
int currentHelpScreen;
int bombNum;
int currentLevel;
int graze;
int timesToRun;
int kills;
int grazeAhievement1Counter;
int previousGrazeAhievement1Counter;
int ahievementShowTimer;

float[] enemyAppearDeadlines;
float[] enemyAppearTimes;
float score;
float playTimer;

boolean[] keys;
boolean autoFire;
boolean shouldRestart;
boolean paused;
boolean viewingHelpScreen;
boolean showEffects;
boolean levelComplete;
boolean previousGrazeAhievement1Earned;
boolean grazeAhievement1Earned;
boolean level1KillsAchievementEarned;
boolean level1Score1AchievementEarned;
boolean viewingBlendMode;

final color ENEMY_COLOR = color(255, 0, 0);
final color BULLET_WIGGLE_COLOR = color(0, 0, 255);
final color TERRAIN_COLOR = color(255);
final int NUM_OF_ENEMY_TYPES = 4;
final int FONT_SIZE = 32;
final PVector NO_WAYPOINT = new PVector(-1, -1);

void setup()
{
  size(925, 715, P2D, OPENGL);
  smooth();

  strokeWeight(5);
  noStroke();

  rectMode(CENTER);
  background(255);

  currentHelpScreen = 0;
  ahievementShowTimer = 0;
  keys = new boolean[17];
  autoFire = true;
  viewingHelpScreen = true;
  showEffects = true;
  grazeAhievement1Earned = false;
  level1KillsAchievementEarned = false;
  level1Score1AchievementEarned = false;
  viewingBlendMode = false;
  currentLevel = -1;
  holdKeyTimers = new int[12];
  timesToRun = 1;

  reset();
}

void reset()
{
  paused = false;
  shouldRestart = false;
  levelComplete = false;
  font = createFont("Arial", FONT_SIZE);
  textFont(font);

  playTimer = 0;
  score = 0;
  if (currentLevel == 0)
    bombNum = 3;
  else
    bombNum = 0;
  graze = 0;
  kills = 0;
  previousGrazeAhievement1Counter = 0;
  grazeAhievement1Counter = 0;
  enemyAppearTimes = new float[NUM_OF_ENEMY_TYPES];
  enemyAppearDeadlines = new float[NUM_OF_ENEMY_TYPES];
  enemyAppearDeadlines[0] = 2000 / timesToRun;
  enemyAppearDeadlines[1] = 1250 / timesToRun;
  enemyAppearDeadlines[2] = 475 / timesToRun;
  enemyAppearDeadlines[3] = 2750 / timesToRun;

  p = new Player(new PVector(), new PVector(width / 2, height / 2), new PVector(), 20, 1, 0, 5.0, true);
  bullets = new ArrayList<Bullet>();
  splitBullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  mists = new ArrayList<Mist>();

  if (currentLevel == 0)
  {
    Enemy e = new EnemyShootBulletStraightTowardsPredicted(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(random(width), random(height)), 0, 25, 15, 0, 70, 8, 160, 7.0, 8.5, true, false);
    enemies.add(e);
    while (e.loc.dist (new PVector (p.loc.x - (p.playerSize / 2), p.loc.y)) <= 450)
      e.loc.set(random(width), random(height), 01);
  }

  l1 = new Level1();
  b1 = new Boss1(new PVector(width, height / 2), new PVector(width, height / 2), NO_WAYPOINT, new PVector(), new PVector(width + 100, height / 2), 0, 0, 25, 0, 0, 0, 200, 400, 0, 65, 8, 160, 0, 10, 1.0, 8.5, 0);
}


void draw()
{
  if (viewingBlendMode)
    blendMode(SUBTRACT);
  if (keys[5])
    holdKeyTimers[11] ++;
  else
    holdKeyTimers[11] = 0;
  if (keys[6])
    holdKeyTimers[0] ++;
  else
    holdKeyTimers[0] = 0;
  if (keys[7])
    holdKeyTimers[1] ++;
  else
    holdKeyTimers[1] = 0;

  if (holdKeyTimers[0] >= 60)
  {
    currentLevel = 0;
    viewingHelpScreen = false;
    reset();
  }
  else if (holdKeyTimers[1] >= 60)
  {
    currentLevel = 1;
    viewingHelpScreen = false;
    reset();
  } 
  else if (holdKeyTimers[11] >= 60)
    reset();
  if (viewingHelpScreen)
  {
    background(127.5);
    fill(0);
    textAlign(CENTER, TOP);
    text("Graze bullets and kill enemies to gain score", width / 2, 0);
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
    text("P: Toggle pause", width / 2, FONT_SIZE * 12);
    text("L: Toggle visual-effects (lag)", width / 2, FONT_SIZE * 13);
    text("B: WTF?!", width / 2, FONT_SIZE * 14);
    text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 15);
    text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 16);
    if (currentHelpScreen == 0)
    {
      text("H: Toggle this boring screen (won't work now, and the puzzle)", width / 2, FONT_SIZE * 17);
      text("to make it work is too hard for u. MUHAHAHAHA!)", width / 2, FONT_SIZE * 18);
    }
    else if (currentHelpScreen == 1)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 16);
      text("It's touching that u returned to this exciting screen for", width / 2, FONT_SIZE * 17);
      text("another stupid joke... but too bad", width / 2, FONT_SIZE * 18);
    }
    else if (currentHelpScreen == 2)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 17);
      text("Ah, now I know alot about u. To come back here you are either", width / 2, FONT_SIZE * 18);
      text("thoughtful or careless. Or someone pressed the button for u. Or", width / 2, FONT_SIZE * 19);
      text("some combination of the three.", width / 2, FONT_SIZE * 10);
    }
    else if (currentHelpScreen == 3)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 17);
      text("Oh, u want to know about me, u ask? You can choose my", width / 2, FONT_SIZE * 18);
      text("name, and I am good at everthing: Video-games, writing,", width / 2, FONT_SIZE * 19);
      text("surfing, the opposite sex (u can decide if I am male or", width / 2, FONT_SIZE * 20);
      text("female), talking, self-control, driving vehicles, music, circus", width / 2, FONT_SIZE * 21);
      text("toys and sports. Oh yeah, and life.", width / 2, FONT_SIZE * 22);
    }
    else if (currentHelpScreen == 4)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 17);
      text("I'm especially good at music, though. Wanna hear me rap? I", width / 2, FONT_SIZE * 18);
      text("can rap so fast! {Insert name here takes in a huge breath}", width / 2, FONT_SIZE * 19);
    }
    else if (currentHelpScreen == 5)
      background(0); 
    else if (currentHelpScreen == 6)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 17);
      text("{Insert name here pants heavily} Did you even hear what I said?", width / 2, FONT_SIZE * 18);
      text("I crammed a lot of words together.", width / 2, FONT_SIZE * 19);
    }
  }
  else
  {
    if (grazeAhievement1Counter >= 10)
      grazeAhievement1Earned = true;
    if (grazeAhievement1Earned)
      ahievementShowTimer ++;

    if (currentLevel == 0)
    {
      if (shouldRestart)
        return;

      if (!paused)
      {
        for (int i = 1; i <= timesToRun; i ++)
        {
          playTimer += 1 / frameRate;
          score += 1 / frameRate;
        }

        ArrayList<Enemy> survivingEnemies = new ArrayList<Enemy>();

        for (int i = 0; i <= NUM_OF_ENEMY_TYPES - 1; i ++)
          enemyAppearTimes[i] ++;

        for (int i = 1; i <= timesToRun; i ++)
          p.move();

        fill(127.5, 175);
        rect(width / 2, height / 2, width, height + 2);

        for (int i = 0; i <= NUM_OF_ENEMY_TYPES - 1; i ++)
        {
          if (enemyAppearTimes[i] >= enemyAppearDeadlines[i])
          {
            enemyAppearDeadlines[0] = 2000 / timesToRun;
            enemyAppearDeadlines[1] = 1250 / timesToRun;
            enemyAppearDeadlines[2] = 475 / timesToRun;
            enemyAppearDeadlines[3] = 2750 / timesToRun;
            if (i == 0)
            {
              Enemy e = new EnemyMoveTowardsPlayer(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(random(width), random(height)), 0, 30, 10, 0, 60, 19, 7.0, 7.0, true, false);
              enemies.add(e);
              while (e.loc.dist (p.loc) <= 450)
                e.loc.set(random(width), random(height), 0);
            } 
            else if (i == 1)
            {
              Enemy e = new EnemyShootHeadOn(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(random(width), random(height)), 0, 25, 30, 0, 10, 14, .3, 7.0, 2.0, true, false);
              enemies.add(e);
              while (e.loc.dist (new PVector (p.loc.x - (p.playerSize / 2), p.loc.y)) <= 450)
                e.loc.set(random(width), random(height), 0);
            } 
            else if (i == 2)
            {
              Enemy e = new EnemyShootBulletStraightTowardsPredicted(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(random(width), random(height)), 0, 25, 15, 0, 65, 4, 160, 7.0, 8.5, true, false);
              enemies.add(e);
              while (e.loc.dist (new PVector (p.loc.x - (p.playerSize / 2), p.loc.y)) <= 450)
                e.loc.set(random(width), random(height), 0);
            } 
            else if (i == 3)
            {
              Enemy e = new EnemyShootWigglyBulletSpread(NO_WAYPOINT, NO_WAYPOINT, NO_WAYPOINT, new PVector(), new PVector(random(width), random(height)), 0, 25, 25, 0, 30, 26, 2.0, 7.5, true, false);
              enemies.add(e);
              while (e.loc.dist (new PVector (p.loc.x - (p.playerSize / 2), p.loc.y)) <= 450)
                e.loc.set(random(width), random(height), 0);
            }
            enemyAppearTimes[i] = 0;
            enemyAppearDeadlines[i] *= .95;
          }
        }

        for (int i = 0; i <= 5; i ++)
        {
          for (Bullet b : bullets)
          {
            if (!b.exists)
            {
              bullets.remove(b);
              break;
            }
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
          for (int i = 1; i <= timesToRun; i ++)
            b.run();
          b.show();
        }

        if (previousGrazeAhievement1Counter == grazeAhievement1Counter)
          grazeAhievement1Counter = 0;

        previousGrazeAhievement1Counter = grazeAhievement1Counter;

        for (Mist m : mists)
        {
          for (int i = 1; i <= timesToRun; i ++)
            m.run();
          m.show();
        }

        for (int i = 1; i <= timesToRun; i ++)
          p.run();
        p.show();

        if (grazeAhievement1Counter >= 10)
          grazeAhievement1Earned = true;
      }
    } 
    else if (currentLevel == 1)
    {
      if (shouldRestart)
        return;

      if (!paused)
      {
        for (int i = 1; i <= timesToRun; i ++)
        {
          playTimer += 1 / frameRate;
          score -= 5 / frameRate;
        }

        for (int i = 1; i <= timesToRun; i ++)
          p.move();

        fill(127.5, 175);
        rect(width / 2, height / 2, width, height + 2);

        for (int i = 1; i <= timesToRun; i ++)
          l1.createEnemies();

        for (int i = 0; i <= 5; i ++)
        {
          for (Bullet b : bullets)
          {
            if (!b.exists)
            {
              bullets.remove(b);
              break;
            }
          }
        }
        for (Bullet b : splitBullets)
          bullets.add(b);

        splitBullets.clear();

        ArrayList<Enemy> survivingEnemies = new ArrayList<Enemy>();

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
          for (int i = 1; i <= timesToRun; i ++)
            b.run();
          b.show();
        }

        for (Mist m : mists)
        {
          for (int i = 1; i <= timesToRun; i ++)
            m.run();
          m.show();
        }

        for (int i = 1; i <= timesToRun; i ++)
          p.run();
        p.show();
      }
      if (score >= 50)
        level1Score1AchievementEarned = true;
      if (kills == 1)
        level1KillsAchievementEarned = true;
    }

    textAlign(LEFT, TOP);
    fill(0);
    text("Score: " + score, 0, 0);
    textAlign(CENTER, TOP);
    text("Kills: " + kills, width / 2, 0);
    text("Graze: " + graze, width / 2, FONT_SIZE);
    text("Time:", width / 2, FONT_SIZE * 2);
    text(playTimer, width / 2, FONT_SIZE * 3);
    textAlign(RIGHT, TOP);
    text("Bombs: " + bombNum, width, 0);
    if (grazeAhievement1Earned && ahievementShowTimer <= 300)
    {
      textAlign(CENTER, BOTTOM);
      text("Ahievement unlocked: Graze combo (1)", width / 2, height);
    }
    else if (level1KillsAchievementEarned)
    {
      textAlign(CENTER, BOTTOM);
      text("Ahievement unlocked: Graze combo (1)", width / 2, height);
    }
    else if (level1Score1AchievementEarned && ahievementShowTimer <= 300)
    {
      textAlign(CENTER, BOTTOM);
      text("Ahievement unlocked: Level 1 score (1)", width / 2, height);
    }
    if (levelComplete)
    {
      textAlign(CENTER, CENTER);
      text("Congratz!", width / 2, height / 2);
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
  if (key == 'r' || key == 'R')
  {    
    keys[5] = true;
    if (shouldRestart)
      reset();
  }
  else if (key == 'f' || key == 'F')
    autoFire = !autoFire;
  else if (key == 'n' || key == 'N')
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
  else if (key == 't' || key == 'T')
  {
    if (timesToRun == 1)
      timesToRun = 2;
    else
      timesToRun = 1;
  }
  else if (key == 'h' || key == 'H')
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
  else if (key == 'l' || key == 'L')
    showEffects = !showEffects;
  else if (key == ' ' && bombNum > 0 && !paused && !viewingHelpScreen)
  {
    bullets.clear();
    splitBullets.clear();
    enemies.clear();
    bombNum --;
  }
  else if (key == '0' || key == ')')
    keys[6] = true;
  else if (key == '1' || key == '@')
    keys[7] = true;
  if (key == 'b' || key == 'B')
    viewingBlendMode = !viewingBlendMode;
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
  else if (key == '0' || key == ')')
    keys[6] = false;
  else if (key == '1' || key == '@')
    keys[7] = false;
}

