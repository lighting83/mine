class Matrix {
  Node[][] grid;
  ArrayList<Node> revealed = new ArrayList<Node>();
  Matrix(int xSize, int ySize) {
    this.grid = new Node[xSize][ySize];
  }




  void fillGrid() {
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[0].length; y++) {
        this.grid[x][y] = new Node(x, y);   //creating nodes    
        /*
        if (random(1)>0.5)
         this.grid[x][y].hasMine = true; //putting mines at random
         */
      }
    }
  }

  void showGrid() {
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[0].length; y++) {
        if (!this.grid[x][y].revealed) {
          push();
          fill(100);
          PVector worldPos = grid2worldPosition(this.grid[x][y]);
          rect(worldPos.x, worldPos.y, nodeSize, nodeSize);
          pop();
        } else {
          if (this.grid[x][y].hasMine) {
            push();
            fill(255, 0, 0);
            PVector worldPos = grid2worldPosition(this.grid[x][y]);
            rect(worldPos.x, worldPos.y, nodeSize, nodeSize);
            pop();
          } else {
            push();
            fill(0, 255, 0);
            PVector worldPos = grid2worldPosition(this.grid[x][y]);
            rect(worldPos.x, worldPos.y, nodeSize, nodeSize);
            pop();
          }
        }
      }
    }
  }

  void showRevealed() {
    for (int i = 0; i<revealed.size(); i++) {
      if (revealed.get(i).minesAround != 0) {
        fill(0);
        text(str(revealed.get(i).minesAround), grid2worldPosition(revealed.get(i)).x + nodeSize/2, grid2worldPosition(revealed.get(i)).y+nodeSize/2); //display number of mines around the node
      } else {
        //ce vidimo
      }
    }
  }

  void explode() {
    for (int x = 0; x < gridSize; x++) {
      for (int y = 0; y < gridSize; y++) {
        if (this.grid[x][y].hasMine) {
          push();
            fill(0);
            PVector drawPos = grid2worldPosition(this.grid[x][y]);
            rectMode(CENTER);
            rect(drawPos.x+nodeSize/2, drawPos.y+nodeSize/2, nodeSize*0.5, nodeSize*0.5);
          pop();
        }
      }
    }
  }


  PVector grid2worldPosition(Node n) {    
    PVector position = new PVector();
    position.x = n.xGrid*nodeSize;
    position.y = n.yGrid*nodeSize;
    return position;
  }

  Node NodeFromWorldPosition(PVector pos) {
    int x = int(pos.x / nodeSize);
    int y = int(pos.y / nodeSize);
    //x = constrain(x,0,gridSize-1);
    //y = constrain(y,0,gridSize-1);
    if(x != constrain(x,0,gridSize-1) || y != constrain(y,0,gridSize-1)) //if pointer is inside bounds
      return null;
    
    return this.grid[x][y];
  }

  void assignMinesAround(Node n) {
    int count = 0;
    for (int x = -1; x<=1; x++) {
      for (int y = -1; y<=1; y++) {
        if (x == 0 && y == 0)
          continue;
        if (checkIndexValidity(n.xGrid+x, n.yGrid+y))
        {
          if (this.grid[n.xGrid+x][n.yGrid+y].hasMine) {
            count++;
          }
        }
      }
    }
    this.grid[n.xGrid][n.yGrid].minesAround = count;
  }

  void assignMinesAroundForGrid() {
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[0].length; y++) {
        assignMinesAround(this.grid[x][y]);
      }
    }
  }


  void revealNode(Node n) { 
    this.grid[n.xGrid][n.yGrid].revealed = true;
    if (!this.grid[n.xGrid][n.yGrid].hasMine) {
      fill(0, 255, 0);   //green if doesn't have mine
      rect(n.xGrid*nodeSize+1, n.yGrid*nodeSize, nodeSize, nodeSize);
    } else {
      //ce vidimo
    }
  }




  //No look here!!!
  void spawnMines(int mineNumber) {
    int minesSet = 0;
    while (minesSet < mineNumber) {
      int xIndex = int(random(grid.length));
      int yIndex = int(random(grid[0].length));
      if (!this.grid[xIndex][yIndex].hasMine) {
        this.grid[xIndex][yIndex].hasMine = true;
        minesSet++;
      }
    }
  }

  boolean checkIndexValidity(int x, int y) {
    boolean valid = true;

    if (x >=gridSize)
      valid = false;
    if (y >=gridSize)
      valid = false;  
    if (x <0)
      valid = false;
    if (y <0)
      valid = false;

    return valid;
  }
}
