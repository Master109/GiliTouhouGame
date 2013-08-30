void saveMenu()
{
  data[0] = "" + perkPoints;
  data[1] = "" + reloadSpeedCost;
  data[2] = "" + timeIntoScoreCost;
  data[3] = "" + timeIntoScoreModifier;
  data[4] = "" + grazeIntoScoreCost;
  data[5] = "" + grazeIntoScoreModifier;
  data[6] = "" + killsIntoScoreCost;
  data[7] = "" + killsIntoScoreModifier;
  data[8] = "" + bombNumCost;
  data[9] = "" + level1KillsAchievementEarned;
  data[10] = "" + level1Score1AchievementEarned;
  for (int i = 0; i < NUM_ACHIEVEMENTS; i ++)
    data[11 + i] = "" + grazeAchievementEarned[i];
  data[14] = "" + perkEquiped[0];
  data[15] = "" + perkEquiped[2];
  data[16] = "" + perkEquiped[4];
  data[17] = "" + perkEquiped[6];
  data[18] = "" + perkEquiped[8];
  data[19] = "" + highScores.get(highScores.size() - 1);
  data[20] = "" + highScores.get(highScores.size() - 1);
  saveStrings("Save Data.txt", data);
}

