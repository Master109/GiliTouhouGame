void showAchievements()
{
  for (int index = 0; index < NUM_ACHIEVEMENTS; index ++)
  {
    if (grazeAchievementShow[index])
    {
      if (notificationShowTimer > 180)
      {
        grazeAchievementShow[index] = false;
        notificationShowTimer = 0;
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
    }

    showText("Achievement unlocked: Level 1 kills (1)", width / 2, height);
    return;
  }

  if (level1Score1AchievementShow)
  {
    if (notificationShowTimer > 180)
    {
      level1Score1AchievementShow = false;
      notificationShowTimer = 0;
    }

    showText("Achievement unlocked: Level 1 score (1)", width / 2, height);
    return;
  }
}

void showText(String str, int x, int y)
{
  textAlign(CENTER, BOTTOM);
  text(str, x, y);

  notificationShowTimer++;
}

