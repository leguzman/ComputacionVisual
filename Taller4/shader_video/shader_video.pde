PImage label;
PShape can;
float angle;
import processing.video.*;
Movie video;

void setup() {
  size(640, 360, P3D);  
  video = new Movie(this, "video.mp4"); 
  video.speed(1);
  video.loop();
  can = createCan(100, 200, 32, video);
}

void draw() {    
  background(0);
  translate(width/2, height/2);
  rotateY(angle);    
  shape(can);  
  angle += 0.01;
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
