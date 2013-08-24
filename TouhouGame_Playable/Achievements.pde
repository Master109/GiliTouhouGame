void showAchievementsNotifications()
{
  for (int index = 0; index < NUM_ACHIEVEMENTS; index ++)
  {
    if (grazeAchievementShow[index])
    {
      if (notificationShowTimer > 180)
      {
        grazeAchievementShow[index] = false;
        notificationShowTimer = 0;
        perkPoints += index + 1;
      }

      showText("Achievement unlocked: Graze combo (" + (index + 1) + ")", width / 2, height);
      return;
    }
  }

  if (level1KillsAchievementShow)
  {
    if (notificationShowTimer > 180)
    {
      level1KillsAchievementShow = false;
      notificationShowTimer = 0;
      perkPoints += 4;
    }

    showText("Achievement unlocked: Level 1 kills", width / 2, height);
    return;
  }

  if (level1Score1AchievementShow)
  {
    if (notificationShowTimer > 180)
    {
      level1Score1AchievementShow = false;
      notificationShowTimer = 0;
      perkPoints += 1;
    }

    showText("Achievement unlocked: Level 1 score (1)", width / 2, height);
    return;
  }
}

void showText(String str, int x, int y)
{
  fill(0);
  textAlign(CENTER, BOTTOM);
  text(str, x, y);

  notificationShowTimer++;
}

void showAchievementList()
{
  float fontSize = FONT_SIZE;
  fill(0);
  textAlign(CENTER, TOP);
  text("Survival Mode", width / 2, 0);
  text("Graze Combo (1): Get at least 10 graze within a continuous time period", width / 2, fontSize);
  text("Graze Combo (2): Get at least 20 graze within a continuous time period", width / 2, fontSize * 2);
  text("Graze Combo (3): Get at least 30 graze within a continuous time period", width / 2, fontSize * 3);
  text("Level Mode", width / 2, fontSize * 5);
  text("Level 1 Kills: Get 9 kills on level 1", width / 2, fontSize * 6);
  text("Level 1 Score (1): Get 0 score on level 1", width / 2, fontSize * 7);
}

