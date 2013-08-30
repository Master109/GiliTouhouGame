class BackgroundSquare
{
  PVector loc;
  int backgroundSquareSize;
  int[] adjacentSqaures;

  BackgroundSquare(PVector loc, int backgroundSquareSize, int[] adjacentSqaures)
  {
    this. loc = loc;
    this.backgroundSquareSize = backgroundSquareSize;
    this.adjacentSqaures = adjacentSqaures;
  }

  void show()
  {
    fill(0, 0);
    stroke(0, 255);
    rect(loc, backgroundSquareSize, backgroundSquareSize);
    noStroke();
  }

  void run()
  {
  }
}

