
float angle;
float jitter;
PGraphics pg,pg2;

void setup() {
  size(640, 360);
  
  pg = createGraphics(640,360);
  pg2 = createGraphics(640,360);
  noStroke();
  pg2.rectMode(CENTER);
  
  pg.rectMode(CENTER);
}

void draw() {
  pg2.beginDraw();
  pg2.background(150);
  //pg2.clear();
 
  angle = angle + 0.01;
  pg2.translate(width/2, height/2);
  pg2.rotate(angle);
  pg2.stroke(0);
  pg2.fill(255);
  //rect(0, 0, 180, 180); 
  
  
    //line(-90+24,-90+ 1, -90+24,-90+ 24);//vertical
    //line(-90+12,-90+ 12, -90+36,-90+ 12);//horizontal
  for (int k=-90;k<=70;k+=26){
    for (int i=-102;i<=70;i+=26){
    pg2.line(i+24,k+ 1, i+24,k+ 24);//vertical
    pg2.line(i+12,k+12, i+36,k+ 12);//horizontal
    }
  }
  
  pg2.endDraw();
  image(pg2,0, 0); 
  //////////////////
  pg.beginDraw();
  
    pg.background(255);
    pg.clear();
    pg.translate(width/2, height/2);
    pg.fill(255,0,255);
    pg.ellipse(0,62,5,5);
    pg.ellipse(52,-37,5,5);
    pg.ellipse(-52,-37,5,5);
    
    
    pg.fill(124,252,0);
    pg.ellipse(0,0,10,10);
  pg.endDraw();
  image(pg, 0, 0); 
}
