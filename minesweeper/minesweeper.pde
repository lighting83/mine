int nodeSize;
int gridSize = 10;
Matrix Grid;

void setup() {
  size(800, 800);
  nodeSize = width / gridSize;

  Grid = new Matrix(gridSize, gridSize);  
  Grid.fillGrid();
  Grid.spawnMines(50);

}

void draw() {
  background(#8feb34); 
  Grid.showGrid();
  
  //fill(0);
  //PVector pom = Grid.grid2worldPosition(new Node(3,4));
  //rect(pom.x+1,pom.y,30,30);
  //rect(30,30,30,30);
}

void mouseReleased(){
  Node n = Grid.NodeFromWorldPosition(new PVector(mouseX,mouseY));
  //println(n.xGrid,n.yGrid);
  Grid.revealNode(n);
}
