class Button
{
  PVector loc, buttonSize;
  float fontSize;
  boolean beingPressed, pressed, show;
  color buttonColor;
  String text;

  Button(PVector loc, float fontSize, String text, boolean show)
  {
    this.loc = loc;
    this.fontSize = fontSize;
    this.text = text;
    buttonSize = new PVector(textWidth(text) + 50, fontSize + 50);
    buttonColor = color(100);
    beingPressed = false;
    pressed = false;
    this.show = show;
  }

  void show()
  {
    fill(buttonColor);
    rect(loc.x, loc.y, buttonSize.x, buttonSize.y);
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, loc.x, loc.y);
  }

  void run()
  {
    if (mousePressed && mouseX > loc.x - (buttonSize.x / 2) && mouseX < loc.x + (buttonSize.x / 2) && mouseY > loc.y - (buttonSize.y / 2) && mouseY < loc.y + (buttonSize.y / 2))
    {
      beingPressed = true;
      buttonColor = color(175);
    }
    else
      buttonColor = color(100);
  }
}

