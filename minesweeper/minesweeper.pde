int nodeSize = 20;
int gridSize;
Matrix Grid;

void setup() {
  size(800, 800);
  int gridSize = width / nodeSize;

  Grid = new Matrix(40, 40);
}

void draw() {
  background(#8feb34);
  Grid.fillGrid();
  Grid.showGrid();
  
}
