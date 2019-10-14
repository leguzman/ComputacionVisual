PImage img = new PImage();
PGraphics pg, parl;
int dimX;
int dimY;

void setup(){
  size(1400, 464);
  background(0);
  img = loadImage("dino.jpg");
  dimX = img.width;
  dimY = img.height;  
  pg = createGraphics(dimX, dimY);
  parl = createGraphics(dimX, dimY);
  setParls();
}

void draw(){
  img.loadPixels();
  pg.beginDraw();
  pg.image(img, 0, 0);
  pg.endDraw();
  image(pg, 700, 0);
  parl.beginDraw();
  image(parl, mouseX, 0);
}

void setParls(){  
  parl.beginDraw();
  parl.strokeWeight(8);
  for(int i = 0; i < 1400; i+= 12){
    parl.line(i, 0, i, dimY); 
  }
  parl.endDraw();
}
