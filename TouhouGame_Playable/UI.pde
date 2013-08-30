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
  if ((key == 'h' || key == 'H') && (currentLevel != -1 || viewingAchievements || inShop))
  {
    viewingHelpScreen = !viewingHelpScreen;
    if (viewingHelpScreen)
    {
      if (currentHelpScreen < 6)
        currentHelpScreen ++;
      else
        currentHelpScreen = 0;
    }
    viewingSaveMenu = false;
    inShop = false;
    viewingAchievements = false;
  }
  else if (key == 'v' || key == 'V')
  {
    viewingAchievements = !viewingAchievements;
    viewingSaveMenu = false;
    inShop = false;
    viewingHelpScreen = false;
  }
  else if (key == 'q' || key == 'Q')
  {
    inShop = !inShop;
    viewingSaveMenu = false;
    viewingHelpScreen = false;
    viewingAchievements = false;
  }
  else if (keyCode == ENTER)
  {
    viewingSaveMenu = !viewingSaveMenu;
    inShop = false;
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
    if (buttons[i].isVisible)
    {
      if (buttons[i].beingPressed && mouseX > buttons[i].loc.x - (buttons[i].buttonSize.x / 2) && mouseX < buttons[i].loc.x + (buttons[i].buttonSize.x / 2) && mouseY > buttons[i].loc.y - (buttons[i].buttonSize.y / 2) && mouseY < buttons[i].loc.y + (buttons[i].buttonSize.y / 2))
        buttons[i].pressed = true;
    }
  }
}

