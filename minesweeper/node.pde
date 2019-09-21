class Node {
  //PVector position = new PVector();
  int xGrid = 0;
  int yGrid = 0;
  boolean hasMine = false;
  boolean hasKebab = false;
  boolean revealed = false;
  
  int minesAround;

  Node() {  }
  Node(int x, int y) {
    this.xGrid = x;
    this.yGrid = y;
  }
  
  
}
