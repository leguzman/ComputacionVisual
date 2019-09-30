PImage img1, img2, img3, img4, img5, img6, img7;
//PGraphics pg1, pg2;
PFont f;

PImage img = new PImage();
boolean flag = true;
int state = 0;
int bx = 0;
int by = 0;
int im = 0;
String pos1 = "";
String pos2 = "";
int x1, x2;
int which = 0;

void setup() {
  size(1360, 500); // Tamaño de la ventana principal
  img1 = loadImage("partenon.jpg"); // Carga la imagen base
  //f = createFont("Arial",16,true); // STEP 2 Create Font
  //textFont(f, 12);                  // STEP 3 Specify font to be used
  fill(0);                         // STEP 4 Specify font color
  //noLoop(); // Se ejecuta el programa una sola vez
  img = img1;
}

void draw() {
  g.background(200, 200, 200); // Background gris claro
  image(img1, 20, 20); // Imagen original
  text("Imagen original", 20, 230);

  img2 = grayScaleBasic(img1); // Conversión a escala de grises básico
  image(img2, 240, 20);
  text("Escala de grises", 240, 230);

  img3 = grayScaleLuma(img1); // Conversión a escala de grises Luma
  image(img3, 460, 20);
  text("Luma", 460, 230);

  img4 = convolution(img1, edge); // Uso de efecto edge
  image(img4, 20, 240);
  text("Edge", 20, 450);

  img5 = convolution(img1, emboss); // Uso de efecto emboss
  image(img5, 240, 240);
  text("Emboss", 240, 450);

  img6 = convolution(img1, sharpen); // Uso de efecto sharpen
  image(img6, 460, 240);
  text("Sharpen", 460, 450);
  
  text("SELECT AN IMAGE", 270, 470);
  text("SELECT A RANGE IN A COLOR", 910, 470);
  
  img = select(bx, by);  
  image(img, 770, 25);   //pintar la imagen seleccionada
  histogram(img);
  stroke(0);
  line(680, 10, 680, 490);
  calcLim();
  if(state == 2 || state == 3){
    setIm(x1,x2);
  }   
}

void setIm(int min, int max){  
  int resaltado = color(0, 255, 255);
  int m = min(min, max);
  int n = max(min, max);  
  img7 = img;
  for (int i = 0; i < img1.width; i++) {
    for (int j = 0; j < img1.height; j++) {
      int data = 0;
      switch(im){        
        case 1:
          data = int(red(img.get(i,j)));
          if(data >= m && data <= n)
            img7.set(i, j, resaltado);
        break;
        case 2:
          data = int(green(img.get(i,j)));
          if(data > m && data < n)
            img7.set(i, j, resaltado);
        break;
        case 3:
          data = int(blue(img.get(i,j)));
          if(data > m && data < n)
            img7.set(i, j, resaltado);
        break;
      }      
    }
  }
  image(img7, 1070, 25); 
  noLoop();
}

void calcLim() {  
  switch(state){
    case 0:
      if(mouseX <= 1340 && mouseX >= 700 && mouseY <=440 && mouseY >= 240){    
        if ( mouseX <= 900 && mouseX >= 700 ) {
          im = 1;
          which = int(map(mouseX - 700, 0, 200, 0, 255));
          pos1 = "" + which;          
          text("|", mouseX, 440);
          text(pos1, mouseX-5, 455);        
        }
  
        if( mouseX <= 1120 && mouseX >= 920 ) {
          im = 2;        
          which = int(map(mouseX - 920, 0, 200, 0, 255));
          pos1 = "" + which;
          text("|", mouseX, 440);    
          text(pos1, mouseX-5, 455);
        }
        
        if ( mouseX <= 1340 && mouseX >= 1140 ) {
          im = 3;
          which = int(map(mouseX - 1140, 0, 200, 0, 255));
          pos1 = "" + which;
          text("|", mouseX, 440);    
          text(pos1, mouseX-5, 455);
        }
      }
    break;
    case 1:
      x1 = int(map(bx - 700, 0, 200, 0, 255));
      text("|", bx, 440);    
      text(pos1, bx-5, 455);
      x1 = bx;
      
      if ( mouseX <= 900 && mouseX >= 700 ) {          
        which = int(map(mouseX - 700, 0, 200, 0, 255));
        pos2 = "" + which;                
        text("|", mouseX, 440);
        text(pos2, mouseX-5, 455);        
      }
      
      if( mouseX <= 1120 && mouseX >= 920 ) {
        which = int(map(mouseX - 920, 0, 200, 0, 255));
        pos2 = "" + which;                
        text("|", mouseX, 440);
        text(pos2, mouseX-5, 455);
      }
      
      if( mouseX <= 1340 && mouseX >= 1140 ) {
        which = int(map(mouseX - 1140, 0, 200, 0, 255));
        pos2 = "" + which;                
        text("|", mouseX, 440);
        text(pos2, mouseX-5, 455);
      }
    break;
    case 2:
      text("|", x1, 440);    
      text(pos1, x1-5, 455);
      
      x2 = int(map(bx - 700, 0, 200, 0, 255));
      text("|", bx, 440);    
      text(pos2, bx-5, 455);         
      setIm(x1,x2);
    break;    
    default:
    break;
  }  
}

PImage select(int x1, int y1) {
  if (x1 >= 20 && x1 <= 220 && y1 >= 20 && y1 <= 220) {
    img = img1;
  }

  if (x1 >= 240 && x1 <= 440 && y1 >= 20 && y1 <= 220) {
    img = img2;
  }

  if (x1 >= 460 && x1 <= 660 && y1 >= 20 && y1 <= 220) {
    img = img3;
  }

  if (x1 >= 20 && x1 <= 220 && y1 >= 240 && y1 <= 440) {
    img = img4;
  }

  if (x1 >= 240 && x1 <= 420 && y1 >= 240 && y1 <= 440) {
    img = img5;
  }

  if (x1 >= 460 && x1 <= 660 && y1 >= 240 && y1 <= 440) {
    img = img6;
  }
  return img;
}

void mouseClicked() {
  System.out.println(mouseX + " " + mouseY);
  select(mouseX, mouseY);
  bx = mouseX;
  by = mouseY;
  if(mouseX <= 1340 && mouseX >= 700 && mouseY <=440 && mouseY >= 240){
    state++;
  }   
  if(state > 3) state = 0;
}
