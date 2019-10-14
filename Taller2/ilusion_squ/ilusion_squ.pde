PGraphics pg, rot;

float angle;

void setup() {
  size(750, 750);
  noStroke();
  fill(255);  
  rot = createGraphics(750, 750);  
  pg = createGraphics(750, 750);
  setSq();
}

void draw() {
  background(51);  
  angle += 0.04;
  rot.beginDraw();
  rot.rectMode(CENTER);
  rot.background(51);
  rot.translate(rot.width/2, rot.height/2);
  rot.rotate(angle);
  rot.rect(0, 0, 350, 350);
  image(rot, 0, 0);
  rot.endDraw();  
  image(pg, 0, 0);  
  
}

void setSq(){
  pg.beginDraw();
  pg.stroke(200, 100, 0);
  pg.fill(200, 100, 0);
  pg.square(0, 0, 350);
  pg.square(400, 0, 350);
  pg.square(0, 400, 350);
  pg.square(400, 400, 350);
  pg.endDraw();
}

void mouseReleased(){
  setSq();
}

void mousePressed(){
  pg.beginDraw();
  pg.clear();
  pg.endDraw();
}
