void setup(){
  size(500, 500);
}

void draw(){
  background(0);
  ellipseMode(CENTER);
  int cir=1000;

  while(cir>0){
   noStroke();
   float distance = abs(499-cir);
   fill(distance);
   ellipse(width/2,height/2,cir,cir);
   cir-=10;
  }
}