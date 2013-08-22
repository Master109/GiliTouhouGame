PFont font;

Player p;
Level1 l1;
Boss1 b1;

ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets, splitBullets;
ArrayList<Mist> mists;
ArrayList<Float> highScores;

Button[] buttons;

int[] perkEquiped;
int[] holdKeyTimers;
int currentHelpScreen;
int bombNum;
int currentLevel;
int graze;
int timesToRun;
int kills;
int grazeAchievementCounter;
int previousGrazeAchievementCounter;
int notificationShowTimer;
int reloadSpeedCost;
int timeIntoScoreCost;
int perkPoints;

float[] enemyAppearDeadlines;
float[] enemyAppearTimes;
float score;
float timeIntoScoreModifier;
float playTimer;

final int NUM_ACHIEVEMENTS = 3;

boolean[] keys;
boolean autoFire;
boolean shouldRestart;
boolean paused;
boolean viewingHelpScreen;
boolean showEffects;
boolean levelComplete;

boolean level1KillsAchievementShow;
boolean level1Score1AchievementShow;

boolean[] grazeAchievementQueued, grazeAchievementEarned, grazeAchievementShow;

boolean level1KillsAchievementQueued;
boolean level1Score1AchievementQueued;

boolean level1KillsAchievementEarned;
boolean level1Score1AchievementEarned;
boolean viewingBlendMode;
boolean inShop;
boolean viewingAchievements;

final color ENEMY_COLOR = color(255, 0, 0);
final color BULLET_WIGGLE_COLOR = color(0, 0, 255);
final color TERRAIN_COLOR = color(255);
final int NUM_OF_ENEMY_TYPES = 4;
final int BUTTON_NUM = 4;
final float FONT_SIZE = 28.5;
final PVector NO_WAYPOINT = new PVector(-1, -1);

void setup()
{
  size(925, 715, P2D, OPENGL);
  smooth();

  strokeWeight(5);
  noStroke();

  rectMode(CENTER);
  background(255);

  perkEquiped = new int[BUTTON_NUM];
  perkEquiped[0] = 0;
  perkEquiped[1] = 0;
  perkEquiped[2] = 0;
  perkEquiped[3] = 0;
  currentHelpScreen = 0;
  notificationShowTimer = 0;
  keys = new boolean[17];
  autoFire = true;
  viewingHelpScreen = true;
  showEffects = true;

  grazeAchievementShow = new boolean[NUM_ACHIEVEMENTS];
  grazeAchievementQueued = new boolean[NUM_ACHIEVEMENTS];
  grazeAchievementEarned = new boolean[NUM_ACHIEVEMENTS];

  level1KillsAchievementShow = false;
  level1Score1AchievementShow = false;
  level1KillsAchievementQueued = false;
  level1Score1AchievementQueued = false;

  level1KillsAchievementEarned = false;
  level1Score1AchievementEarned = false;
  viewingBlendMode = false;
  viewingAchievements = false;
  inShop = false;
  currentLevel = -1;
  holdKeyTimers = new int[12];
  timesToRun = 1;
  reloadSpeedCost = 1;
  timeIntoScoreCost = 1;
  timeIntoScoreModifier = 0;
  perkPoints = 6;
  font = createFont("Arial", FONT_SIZE);
  textFont(font);
  highScores = new ArrayList<Float>();
  highScores.add(0.0);
  highScores.add(10.0);
  buttons = new Button[BUTTON_NUM];
  buttons[0] = new Button(new PVector(250, 100), 28.5, "Reload Speed - $" + reloadSpeedCost, true);
  buttons[1] = new Button(new PVector(250, 200), 28.5, "Unequip", false);
  buttons[2] = new Button(new PVector(650, 100), 28.5, "Time Into Score - $" + timeIntoScoreCost, true);  
  buttons[3] = new Button(new PVector(650, 200), 28.5, "Unequip", false);

  reset();
}

void reset()
{
  paused = false;
  shouldRestart = false;
  levelComplete = false;

  if (currentLevel == 0)
    bombNum = 3;
  else
    bombNum = 0;
  playTimer = 0;
  score = 0;
  graze = 0;
  kills = 0;
  previousGrazeAchievementCounter = 0;
  grazeAchievementCounter = 0;
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
    viewingAchievements = false;
    inShop = false;
    reset();
  }
  else if (holdKeyTimers[1] >= 60)
  {
    currentLevel = 1;
    viewingHelpScreen = false;
    viewingAchievements = false;
    inShop = false;
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
    text("F: Toggle autofire", width / 2, FONT_SIZE * 9);
    text("N: Skip time until next enemy arrives", width / 2, FONT_SIZE * 10);
    text("T: Toggle faster game speed", width / 2, FONT_SIZE * 11);
    text("P: Toggle pause", width / 2, FONT_SIZE * 12);
    text("L: Toggle visual effects (lag)", width / 2, FONT_SIZE * 13);
    text("B: WTF?!", width / 2, FONT_SIZE * 14);
    text("Q: Visit shop", width / 2, FONT_SIZE * 15);
    text("V: View achievements", width / 2, FONT_SIZE * 16);
    text("Hold 0: Play survival mode!", width / 2, FONT_SIZE * 17);
    text("Hold 1-9: Play corresponding level in level mode!", width / 2, FONT_SIZE * 18);
    if (currentHelpScreen == 0)
    {
      text("H: Toggle this boring screen (won't work now, and the puzzle)", width / 2, FONT_SIZE * 19);
      text("to make it work is too hard for u. MUHAHAHAHA!)", width / 2, FONT_SIZE * 20);
    }
    else if (currentHelpScreen == 1)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 19);
      text("It's touching that u returned to this exciting screen for", width / 2, FONT_SIZE * 20);
      text("another stupid joke... but too bad", width / 2, FONT_SIZE * 21);
    }
    else if (currentHelpScreen == 2)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 19);
      text("Ah, now I know alot about u. To come back here you are either", width / 2, FONT_SIZE * 20);
      text("thoughtful or careless. Or someone pressed the button for u. Or", width / 2, FONT_SIZE * 21);
      text("some combination of the three.", width / 2, FONT_SIZE * 22);
    }
    else if (currentHelpScreen == 3)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 19);
      text("Oh, u want to know about me, u ask? You can choose my", width / 2, FONT_SIZE * 20);
      text("name, and I am good at everthing: Video-games, writing,", width / 2, FONT_SIZE * 21);
      text("surfing, the opposite sex (u can decide if I am male or", width / 2, FONT_SIZE * 22);
      text("female), talking, self-control, driving vehicles, music, circus", width / 2, FONT_SIZE * 23);
      text("toys and sports. Oh yeah, and life.", width / 2, FONT_SIZE * 24);
    }
    else if (currentHelpScreen == 4)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 19);
      text("I'm especially good at music, though. Wanna hear me rap? I", width / 2, FONT_SIZE * 20);
      text("can rap so fast! {Insert name here takes in a huge breath}", width / 2, FONT_SIZE * 21);
    }
    else if (currentHelpScreen == 5)
      background(0); 
    else if (currentHelpScreen == 6)
    {
      text("H: Toggle this screen", width / 2, FONT_SIZE * 19);
      text("{Insert name here pants heavily} Did you even hear what I said?", width / 2, FONT_SIZE * 20);
      text("I crammed a lot of words together.", width / 2, FONT_SIZE * 21);
    }
  }
  else if (inShop)
  {
    background(127.5);
    textAlign(CENTER, TOP);
    text("Perk points: " + perkPoints, width / 2, 0);
    text("Improve your score in survival mode by " + int((highScores.get(highScores.size() - 1) - highScores.get(highScores.size() - 2))) + " to earn perk points", width / 2, FONT_SIZE);
    for (int i = 0; i < BUTTON_NUM; i ++)
    {
      if (buttons[i].show)
      {
        if (buttons[i].pressed)
        {
          if (i == 0 && perkPoints >= reloadSpeedCost)
          {
            if (perkEquiped[0] == 0)
              perkEquiped[0] = 1;
            perkPoints -= reloadSpeedCost;
            reloadSpeedCost ++;
            buttons[0].text = "Reload Speed - $" + reloadSpeedCost;
            buttons[1].show = true;
          }
          else if (i == 2 && perkPoints >= timeIntoScoreCost)
          {
            if (perkEquiped[2] == 0)
              perkEquiped[2] = 1;
            perkPoints -= timeIntoScoreCost;
            timeIntoScoreCost ++;
            timeIntoScoreModifier += .05;
            buttons[2].text = "Time Into Score - $" + timeIntoScoreCost;
            buttons[3].show = true;
          }
          if (i == 1)
          {
            if (perkEquiped[0] == 1)
            {
              perkEquiped[0] = -1;
              buttons[1].text = "Equip";
            }
            else if (perkEquiped[0] == -1)
            {
              perkEquiped[0] = 1;
              buttons[1].text = "Unequip";
            }
          }
          else if (i == 3)
          {
            if (perkEquiped[2] == 1)
            {
              perkEquiped[2] = -1;
              buttons[3].text = "Equip";
            }
            else if (perkEquiped[2] == -1)
            {
              perkEquiped[2] = 1;
              buttons[3].text = "Unequip";
            }
          }
        }
        buttons[i].run();
        buttons[i].show();
        buttons[i].pressed = false;
      }
    }
  }
  if (!viewingHelpScreen && !viewingAchievements && !inShop)
  {
    if (currentLevel == -1)
      return;

    if (currentLevel == 0)
    {
      if (shouldRestart)
        return;

      if (!paused)
      {
        if (score > highScores.get(highScores.size() - 1))
        {
          highScores.add(highScores.get(highScores.size() - 1) + 10);
          perkPoints ++;
        }

        for (int i = 1; i <= timesToRun; i ++)
        {
          playTimer += 1 / frameRate;
          float timeIntScoreModifier2 = 0;
          if (perkEquiped[2] == 1)
            timeIntScoreModifier2 = timeIntoScoreModifier;
          score += (1 + timeIntScoreModifier2) / frameRate;
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

        if (previousGrazeAchievementCounter == grazeAchievementCounter)
          grazeAchievementCounter = 0;

        previousGrazeAchievementCounter = grazeAchievementCounter;

        for (Mist m : mists)
        {
          for (int i = 1; i <= timesToRun; i ++)
            m.run();
          m.show();
        }

        for (int i = 1; i <= timesToRun; i ++)
          p.run();
        p.show();

        for (int index = 0; index < NUM_ACHIEVEMENTS; index++)
        {
          if (grazeAchievementCounter >= index + 1)
            grazeAchievementQueued[index] = true;

          if (!grazeAchievementEarned[index] && grazeAchievementQueued[index])
          {
            grazeAchievementEarned[index] = true;
            grazeAchievementShow[index] = true;
            print("TRUINGGGGGGGGGGGG");
          }

          if (grazeAchievementShow[index])
            notificationShowTimer ++;
        }
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

      if (score >= 0)
        level1Score1AchievementQueued = true;
      if (!level1Score1AchievementEarned && level1Score1AchievementQueued && notificationShowTimer == 0)
      {
        level1Score1AchievementEarned = true;
        level1Score1AchievementShow = true;
      }
      if (level1Score1AchievementShow)
        notificationShowTimer ++;
      if (kills == 9)
        level1KillsAchievementQueued = true;
      if (!level1KillsAchievementEarned && level1KillsAchievementQueued && notificationShowTimer == 0)
      {
        level1KillsAchievementEarned = true;
        level1KillsAchievementShow = true;
      }
      if (level1KillsAchievementShow)
        notificationShowTimer ++;
    }

    textAlign(LEFT, TOP);
    fill(0);
    text("Score: " + score, 0, 0);
    textAlign(CENTER, TOP);
    text("Kills: " + kills, width / 2, 0);
    text("Graze: " + graze, width / 2, FONT_SIZE);
    text("Time: ", width / 2, FONT_SIZE * 2);
    text(playTimer, width / 2, FONT_SIZE * 3);
    textAlign(RIGHT, TOP);
    text("Bombs: " + bombNum, width, 0);

    showAchievements();

    println(notificationShowTimer);
    for (int index = 0; index < NUM_ACHIEVEMENTS; index++)
      print(grazeAchievementShow[index]);
    print('\t');
    for (int index = 0; index < NUM_ACHIEVEMENTS; index++)
      print(grazeAchievementEarned[index]);

    if (levelComplete)
    {
      textAlign(CENTER, CENTER);
      text("Congratz!", width / 2, height / 2);
    }
  }
}

void keyPressed()
{
  if (!viewingHelpScreen && !inShop && !viewingAchievements)
  {
    if (key == 'a' || key == 'A')
      keys[0] = true;
    else if (key == 'd' || key == 'D')
      keys[1] = true;
    else if (key == 'w' || key == 'W')
      keys[2] = true;
    else if (key == 's' || key == 'S')
      keys[3] = true;
    else if (keyCode == SHIFT)
      keys[4] = true;
    else if (key == 'p' || key == 'P')
      paused = !paused;
    else if (key == 'r' || key == 'R')
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
    else if (key == 'l' || key == 'L')
      showEffects = !showEffects;
    else if (key == ' ' && bombNum > 0 && !paused && !viewingHelpScreen)
    {
      bullets.clear();
      splitBullets.clear();
      enemies.clear();
      bombNum --;
    }
    else if (key == 'b' || key == 'B')
      viewingBlendMode = !viewingBlendMode;
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
    inShop = false;
    viewingAchievements = false;
  }
  else if (key == 'v' || key == 'V')
  {
    viewingAchievements = !viewingAchievements;
    inShop = false;
    viewingHelpScreen = false;
  }
  else if (key == 'q' || key == 'Q')
  {
    inShop = !inShop;
    viewingHelpScreen = false;
    viewingAchievements = false;
  }
  else if (key == '0' || key == ')')
    keys[6] = true;
  else if (key == '1' || key == '@')
    keys[7] = true;
}

void keyReleased()
{
  if (key == 'a' || key == 'A')
    keys[0] = false;
  else if (key == 'd' || key == 'D')
    keys[1] = false;
  else if (key == 'w' || key == 'W')
    keys[2] = false;
  else if (key == 's' || key == 'S')
    keys[3] = false;
  else if (keyCode == SHIFT)
    keys[4] = false;
  else if (key == 'r' || key == 'R')
    keys[5] = false;
  else if (key == '0' || key == ')')
    keys[6] = false;
  else if (key == '1' || key == '@')
    keys[7] = false;
}

void mouseReleased()
{
  for (int i = 0; i < BUTTON_NUM; i ++)
  {
    if (buttons[i].show)
    {
      if (buttons[i].beingPressed && mouseX > buttons[i].loc.x - (buttons[i].buttonSize.x / 2) && mouseX < buttons[i].loc.x + (buttons[i].buttonSize.x / 2) && mouseY > buttons[i].loc.y - (buttons[i].buttonSize.y / 2) && mouseY < buttons[i].loc.y + (buttons[i].buttonSize.y / 2))
        buttons[i].pressed = true;
    }
  }
}

