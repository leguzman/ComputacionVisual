import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 9;

color[] c = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};

float nfloat =4;
void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(node);
  triangleRaster();
  popStyle();
  popMatrix();
}
void antialiasing(float px,float py, color c) {
    int sum=0;
    for(int i = 0; i < nfloat; i++)
    {
      for(int j = 0; j< nfloat; j++)
      {
        float x = px-0.5 + 1/(nfloat) * i;
        float y = py-0.5 + 1/(nfloat) * j;
    
        float v1v2 = orient2D(node.location(v1).x(),node.location(v1).y(),node.location(v2).x(),node.location(v2).y(),x,y);
        float v2v3 = orient2D(node.location(v2).x(),node.location(v2).y(),node.location(v3).x(),node.location(v3).y(),x,y);
        float v3v1 = orient2D(node.location(v3).x(),node.location(v3).y(),node.location(v1).x(),node.location(v1).y(),x,y);
        if(v1v2 >= 0 && v2v3 >= 0 && v3v1 >=0 )
        {
          sum++;
        }
       }
      }
    float r,g,b, total;
    total = nfloat*nfloat;
    r=red(c)*sum/total;
    g=green(c)*sum/total;
    b=blue(c)*sum/total;
    noStroke();
    fill(r, g, b,200); 
    rect(px, py,1,1);
      
}
// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea  
  if (debug) {
    
    pushStyle();
    setColor(color(c[1], 150));
    rect(floor(node.location(v1).x()), floor(node.location(v1).y()),1,1);
    setColor(color(c[2], 150));
    rect(round(node.location(v2).x()), round(node.location(v2).y()),1,1);
    setColor(color(c[0], 150));
    rect(round(node.location(v3).x()), round(node.location(v3).y()),1,1);
    popStyle();
  }
  
  pushStyle();
  
  for(float py = (pow(2, n)/2)+0.5; py >= -pow(2, n)/2; py--){
    for(float px = (-pow(2, n)/2)+0.5; px<=pow(2, n)/2; px++){
      
      float v1v2 = orient2D(node.location(v1).x(),node.location(v1).y(),node.location(v2).x(),node.location(v2).y(),px,py);
      float v2v3 = orient2D(node.location(v2).x(),node.location(v2).y(),node.location(v3).x(),node.location(v3).y(),px,py);
      float v3v1 = orient2D(node.location(v3).x(),node.location(v3).y(),node.location(v1).x(),node.location(v1).y(),px,py);
         
      //calcular color del pixel
      if(v1v2 >= 0 && v2v3 >= 0 && v3v1 >=0 )
      {
    
        float w = v1v2 + v2v3 + v3v1;
        float r = 255 * v1v2/w;
        float g = 255 * v2v3/w;
        float b = 255 * v3v1/w; 
        color c = color(r,g,b);
        antialiasing(px,py, c);
      }
    }  
  }
  popStyle();  
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
 // orientar contra las manecillas del reloj
  if(orient2D(v1.x(),v1.y(),v2.x(),v2.y(),v3.x(),v3.y())<0){
    Vector temp = v1;
    v1=v2;
    v2=temp;
  }
}

float orient2D(float ax, float ay, float  bx, float  by, float  cx, float cy){
  return (bx-ax)*(cy-ay)-(by-ay)*(cx-ax);
}

void setColor(color c) {
  stroke(c);
  fill(c);
  noStroke();
}


void drawTriangleHint() {
  push();

  if(shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }
  beginShape(TRIANGLES);
  if(shadeHint)
    fill(255, 0, 0);
  else
    stroke(255, 0, 0);
  vertex(v1.x(), v1.y());
  if(shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());
  if(shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());

  pop();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
    println(n);
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
    println(n);
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
}
