float x, y, radians;
int r, R, s;
int delta = 0;
int up = 60;
int fr = 30;

void setup(){
  size(640, 360); // Size of window
}
 
void draw(){
  fill(0, 60);
  rect(0, 0, width, height);
  R = 100; // Radius between center of windows and circles
  r = 50; // Radius of a circle
  s = 10; // Size of cross
  stroke(255, 100); //Stroke with white color
  crossX(s); // Draw a cross on center of window
  loading(R, r); // Chaser spinnnig
  frameRate(fr);
  println("up = " + up);
  println("frameRate = " + fr);
}

void crossX(int s){
  line(width/2-s, height/2, width/2+s, height/2); // Horizontal line
  line(width/2, height/2-s, width/2, height/2+s); // Vertical line
}
 
void loading(int R, int r){
  // Variator of positions using radians
  delta = delta + up;
  radians = (PI/160)*delta;
  
  // Positions of circle
  x = sin(radians)*R + (width/2);
  y = cos(radians)*R + (height/2);
    
  // Circle with white color
  fill(255);
  circle(x, y, r-20);
}

void mouseClicked() {
  if (fr > 40) { fr = 15; } 
  else { fr += 2 ; }
}

void mousePressed() {
  if (mouseButton == RIGHT) { delta++; }
}
