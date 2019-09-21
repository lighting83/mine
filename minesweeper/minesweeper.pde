int seed;   // = int(random(0,5000));
boolean useSeed = false;
color bgColor = #8feb34;
float time  = 0;
float lastTime = 0;

int nodeSize;
int gridSize = 20;
int mineNumber = 10;
int minesMarked = mineNumber;
Matrix Grid;

PFont font;
boolean gameOver = false;
boolean congrats = false;


PImage cover;
PImage kebab;
PImage bigKebab;
PImage clock;
PImage remover;

Button[] difficulties = new Button[3];
int difficulty;
color bColor = color(#736665);
boolean startingScene = true;
boolean doSetup = true;

Button restartBtn;

void setup() {
  //seed = 2497;
  if (useSeed) {
    println("seed: "+seed);
    randomSeed(seed);
  }
  size(800, 900);

  remover = loadImage("/assets/remover.jpg");
  //remover = loadImage("/assets/clocks.png");

  difficulties[0] = new Button(int(width*0.2), int(height*0.82), 100, 30, bColor, "easy"); difficulties[0].startingButton = true;
  difficulties[1] = new Button(int(width*0.45), int(height*0.82), 100, 30, bColor, "medium"); difficulties[1].startingButton = true;
  difficulties[2] = new Button(int(width*0.7), int(height*0.82), 100, 30, bColor, "hard");  difficulties[2].startingButton = true;
  restartBtn  = new Button(int(width*0.43), int(height*0.82), 150, 50, bColor, "Try again");
}

void draw() {
  if (startingScene) {
    drawStartingScene();
    return;
  }
  if (doSetup) {
    if (difficulty == 0) {
      gridSize = 9;
      mineNumber = 10;
    } else if (difficulty == 1) {
      gridSize = 16;
      mineNumber = 40;
    } else if (difficulty == 2) {
      gridSize = 21;
      mineNumber =99;
    }
    nodeSize = width / gridSize;
    setupFont();
    setupUI();

    Grid = new Matrix(gridSize, gridSize);  
    Grid.fillGrid();
    Grid.spawnMines(mineNumber);
    Grid.assignMinesAroundForGrid();

    doSetup = false;
    lastTime = millis()/1000;
  }


  background(bgColor); 
  Grid.showGrid();
  Grid.showRevealed();
  drawUI();

  if (gameOver) {
    gameOver();
    return;
  }

  if (congrats) {    
    congrats();
    return;
  }
}

void mouseReleased() {
  if (startingScene) {
    for (int i = 0; i < difficulties.length; i++) {
      if (difficulties[i].isHovered) {
        difficulty = i;
        startingScene = false;
        return;
      }
    }
    return;
  }

 

  if (gameOver || congrats) {
    if(restartBtn.isHovered)
      restart();
      return;
  }
  Node n = Grid.NodeFromWorldPosition(new PVector(mouseX, mouseY));
  if (mouseButton == LEFT) {
    if (n == null || n.revealed || n.hasKebab)
      return;
    if (n.hasMine) {
      println("GAME OVER");
      gameOver = true;
      return;
    } else {
      //Grid.revealed.add(n);
      //Grid.revealNode(n);
      Grid.discoverArea(n);

      if (Grid.revealed.size() >= gridSize*gridSize - mineNumber) {  
        //WIN
        congrats = true;
        return;
      }
    }
  } else {
    if (!Grid.grid[n.xGrid][n.yGrid].hasKebab && !Grid.grid[n.xGrid][n.yGrid].revealed) {
      Grid.kebabsPlaced.add(n);
      Grid.grid[n.xGrid][n.yGrid].hasKebab = true;
      minesMarked--;
    } else if (Grid.grid[n.xGrid][n.yGrid].hasKebab) {
      Grid.kebabsPlaced.remove(n);
      Grid.grid[n.xGrid][n.yGrid].hasKebab = false;
      minesMarked++;
    }
  }
}

void setupFont() {
  font = createFont("DokChampa", int(nodeSize*0.8), true);
  textFont(font);
  textAlign(CENTER, CENTER);
}

void setupUI() {
  imageMode(CENTER);
  cover = loadImage("/assets/cover.jpg");
  cover.resize(int(height*0.2), int(abs(width-height)*0.8));

  bigKebab = loadImage("/assets/kebabs.png");
  kebab = loadImage("assets/kebabs.png");
  kebab.resize(round(nodeSize*0.9), round(nodeSize*0.9));
  bigKebab.resize(int(height*0.1), int(height*0.1));

  clock = loadImage("/assets/clocks.png");
  clock.resize(int(height*0.1), int(height*0.1));
}


void drawUI() {
  image(bigKebab, width*0.1, height * 0.95);
  image(cover, width*0.3, height * 0.95);

  push();
  textFont(font, width*0.09);
  text(str(minesMarked), width*0.3, height * 0.95);
  pop();

  image(clock, width*0.62, height * 0.95);
  image(cover, width*0.82, height * 0.95);

  push();
  textFont(font, width*0.09);
  if (!gameOver && !congrats)
    time = millis()/1000-lastTime;

  text(floor(time), width*0.82, height * 0.95);
  pop();

  drawKebabs();
}

void drawKebabs() {
  kebab.resize(round(nodeSize*0.9), round(nodeSize*0.9));  
  for (Node n : Grid.kebabsPlaced) {
    PVector pos = Grid.grid2worldPosition(n);
    image(kebab, pos.x+nodeSize/2, pos.y+nodeSize/2);
  }
}

void drawStartingScene() {
  remover.resize(width, height);
  background(remover);
  push();
  fill(255);
  textSize(30);
  text("Welcome to", int(width*0.4), int(height*0.15));
  textSize(50);
  text("KEBABSWEEPER", int(width*0.3), int(height*0.2));
  pop();

  push();
  textSize(21);
  for (Button b : difficulties)
    b.update();

  textSize(32);
  fill(255);
  text("SELECT", int(width*0.44), int(height*0.9));
  pop();
}

void gameOver() {
  push();
  
  Grid.explode();
  fill(#a82020);
  textSize(120);
  text("GAME OVER", width/2, height/2);
  textSize(20);
  restartBtn.update();
  pop();
}

void congrats() {
  push();
  rect(0,width*0.45,width,250);
  fill(#0c4076);
  textSize(60);
  text("YOU HAVE SUCCESSFULLY", width/2, height/2);
  text("SAVED SERBIA!!!", width/2, height/2+50);
  textSize(20);
  restartBtn.update();
  pop();
}

void restart() {
  difficulties[0].startingButton = false;
  difficulties[1].startingButton = false;
  difficulties[2].startingButton = false;
  lastTime = time;
  startingScene = true;
  doSetup = true;
  gameOver = false;
  congrats = false;
}
