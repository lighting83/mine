class Matrix {
  Node[][] grid;
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
        }
        else{
          if(this.grid[x][y].hasMine){
            push();
            fill(255,0,0);
            PVector worldPos = grid2worldPosition(this.grid[x][y]);
            rect(worldPos.x, worldPos.y, nodeSize, nodeSize);
            pop();
          }
          else{
            push();
            fill(0,255,0);
            PVector worldPos = grid2worldPosition(this.grid[x][y]);
            rect(worldPos.x, worldPos.y, nodeSize, nodeSize);
            pop();
          }
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
    return this.grid[x][y];
  }


  void revealNode(Node n) { 
    this.grid[n.xGrid][n.yGrid].revealed = true;
    if (this.grid[n.xGrid][n.yGrid].hasMine)
      fill(255, 0, 0);   //red if there is mine
    else
      fill(0, 255, 0);   //green if doesn't have mine

    rect(n.xGrid*nodeSize+1, n.yGrid*nodeSize, nodeSize, nodeSize);
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
}
