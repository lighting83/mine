class Button {

  final static int alphaModifier = 20;
  int x;
  int y;
  int xSize;
  int ySize;
  color clr = color(0, 0, 0, 0);
  color startingClr;
  String says ="";
  boolean isHovered = false;
  boolean startingButton = false;

  Button(int x, int y, int xSize, int ySize, color clr, String says) {
    this.x = x;
    this.y = y;
    this.xSize = xSize;
    this.ySize = ySize;
    this.clr = clr;
    this.startingClr = clr;
    this.says = says;
  }

  void update() {
    if (mouseX > this.x && mouseX < this.x+this.xSize && mouseY > this.y && mouseY < this.y+this.ySize) {
      hover();
      this.isHovered = true;
    } else {
      this.clr = this.startingClr;
      this.isHovered = false;    
    }

    fill(this.clr);
    rect(this.x, this.y, this.xSize, this.ySize);
    fill(0, 0, 0);
    if(startingButton)
      text(this.says, this.x+this.xSize*0.14, this.y+this.ySize*0.7);
    else
      text(this.says, this.x+this.xSize*0.5, this.y+this.ySize*0.5);    
  }

  void hover() {
    clr = color(red(clr)+alphaModifier, green(clr), blue(clr), alpha(clr)+alphaModifier);
  }
}
