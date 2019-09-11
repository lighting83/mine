class Matrix {
  Node[][] grid;
  Matrix(int xSize, int ySize) {
    this.grid = new Node[xSize][ySize];
  }

  void fillGrid() {
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[0].length; y++) {
        this.grid[x][y].xGrid = x;
        this.grid[x][y].xGrid = y;
        print(x,y);
      }
    }
  }

  void showGrid() {
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[0].length; y++) {
        rect(x*nodeSize,y*nodeSize,nodeSize,nodeSize);
      }
    }
  }
}
