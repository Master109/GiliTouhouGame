void saveMenu()
{
  background(127.5);
  for (int i = 0; i <= 3; i ++)
  {
    data[0] = "" + perkPoints;
    saveStrings("Save Data.txt", data);
  }
}

