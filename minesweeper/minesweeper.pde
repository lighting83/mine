int nodeSize;
int gridSize = 5;
int mineNumber = 5;
Matrix Grid;
PFont font;
boolean gameOver = false;
boolean congrats = false;

void setup() {
  size(800, 900);
  nodeSize = width / gridSize;
  setupFont();

  Grid = new Matrix(gridSize, gridSize);  
  Grid.fillGrid();
  Grid.spawnMines(mineNumber);
  Grid.assignMinesAroundForGrid();
}

void draw() {

  if (gameOver) {
    gameOver();
    return;
  } else if (congrats) {
    congrats();
    return;
  } else {

    background(#8feb34); 
    Grid.showGrid();
    Grid.showRevealed();
  }
}

void mouseReleased() {
  Node n = Grid.NodeFromWorldPosition(new PVector(mouseX, mouseY));
  if(n == null)
    return;
  if (n.hasMine) {
    println("GAME OVER");
    gameOver = true;
    return;
  } else {
    Grid.revealed.add(n);

    Grid.revealNode(n);
    if (Grid.revealed.size() >= gridSize*gridSize - mineNumber) {
      congrats = true;
      return;
    }
  }
  println(n.minesAround);
}

void setupFont() {
  font = createFont("DokChampa", int(nodeSize*0.8), true);
  textFont(font);
  textAlign(CENTER, CENTER);
}

void gameOver() {
  push();
  Grid.explode();
  fill(#a82020);
  textSize(width*0.16);
  text("GAME OVER", width/2, height/2);
  pop();
}

void congrats() {
  push();
  fill(#ffffff);
  textSize(width*0.2);
  text("IQ 200", width/2, height/2);
  pop();
}
