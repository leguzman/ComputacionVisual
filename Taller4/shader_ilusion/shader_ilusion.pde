PImage label;
PShape can;
float angle;
PImage img = new PImage();
PGraphics pg, parl;
int dimX;
int dimY;
import processing.video.*;
Movie video;

void setup() {
  size(640, 360, P3D);  
  video = new Movie(this, "video.mp4"); 
  video.speed(1);
  video.loop();
  ///
    img = loadImage("dino.jpg");
  dimX = img.width;
  dimY = img.height;  
  pg = createGraphics(dimX, dimY);
  parl = createGraphics(dimX, dimY);
  setParls();
  ///


  
  label = loadImage("senko.png");
  can = createCan(100, 200, 32, img);
  
  
  
}

void draw() {    
  background(0);
  translate(width/2, height/2);
  rotateY(angle);    
  shape(can);  
  angle += 0.01;
  
  img.loadPixels();
  pg.beginDraw();
  pg.image(img, 0, 0);
  pg.endDraw();
  image(pg, 700, 0);
  parl.beginDraw();
  image(parl, mouseX, 0);
}
void movieEvent(Movie m) {
  if (video.available()) m.read();
}

PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
    sh.texture(tex);
  }
  sh.endShape(); 
  return sh;
}
void setParls(){  
  parl.beginDraw();
  parl.strokeWeight(8);
  for(int i = 0; i < 1400; i+= 12){
    parl.line(i, 0, i, dimY); 
  }
  parl.endDraw();
}
