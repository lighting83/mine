PImage img;
void setup(){
  size(800,800);
  img = loadImage("/pic/slika.jpg");
  img.resize(400,400);
  imageMode(CENTER);
}

void draw(){
  background(#4287f5);
  image(img,40,40);
}
