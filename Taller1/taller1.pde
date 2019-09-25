PImage pi, pi2, pi3;
PGraphics pg, pg2;

float v = 1.0 / 10.0;
float[][] kernel = {{ v, v, v }, 
                    { v, v, v }, 
                    { v, v, v }};

void setup() {
  size(680, 600); // Tamaño de la ventana principal
  pi = loadImage("partenon.jpg"); // Carga la imagen
  pg = createGraphics(200, 200); // Define el tamaño del pg
  pg2 = createGraphics(200, 200); // Define el tamaño del pg
  //noLoop();
}

void draw(){
  g.background(255, 0, 0); // Background rojo

  image(pi, 20, 20); // Posición de la imagen original, pi
  
  // GRAY SCALE AVERAGE
  pi2 = createImage(200, 200, RGB);
  pi2.loadPixels();
  int r=0, g=0 ,b=0, prom=0;
  color c, p;
  for (int i=0; i<pi.pixels.length; i++) {
    c = pi.pixels[i];
    
    // Simpler, but slower to calculate
    r = (int)red(c);
    g = (int)green(c);
    b = (int)blue(c);
    
    /* Very fast to calculate
    r = c>>16&0xFF;
    g = c>>8&0xFF;
    b = c&0xFF;
    */
    
    prom = (r + g + b)/3;
    p = color(prom, prom, prom);
    pi2.pixels[i] = p; 
  }
  pi2.updatePixels();
  pg.beginDraw();
  pg.background(pi2);
  pg.stroke(255);
  pg.endDraw();
  image(pg, 240, 20);
  
  // GRAY SCALE LUMA
  pi3 = createImage(200, 200, RGB);
  pi3.loadPixels();
  r=0; g=0; b=0; 
  int luma = 0;
  for (int i=0; i<pi.pixels.length; i++) {
    c = pi.pixels[i];
    
    // Simpler, but slower to calculate
    r = (int)(red(c)*0.21);
    g = (int)(green(c)*0.71);
    b = (int)(blue(c)*0.07);
    
    /* Very fast to calculate
    r = c>>16&0xFF;
    g = c>>8&0xFF;
    b = c&0xFF;
    */
    luma = r + g + b;
    p = color(luma, luma, luma);
    pi3.pixels[i] = p; 
  }
  pi3.updatePixels();
  
  pg2.beginDraw();
  pg2.background(pi3);
  pg2.stroke(255);
  pg2.endDraw();
  image(pg2, 460, 20);
  
  // Create an opaque image of the same size as the original
  PImage edgeImg = createImage(pi.width, pi.height, RGB);
  int rad = kernel.length/2;
  // Loop through every pixel in the image
  for (int y = rad; y < pi.height-rad; y++) {   // Skip top and bottom edges
    for (int x = rad; x < pi.width-rad; x++) {  // Skip left and right edges
      float sum1 = 0; // Kernel sum for this pixel
      float sum2 = 0; // Kernel sum for this pixel
      float sum3 = 0; // Kernel sum for this pixel
      for (int ky = -rad; ky <= rad; ky++) {
        for (int kx = -rad; kx <= rad; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*pi.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val1 = red(pi.pixels[pos]);
          float val2 = green(pi.pixels[pos]);
          float val3 = blue(pi.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum1 += kernel[ky+rad][kx+rad] * val1;
          sum2 += kernel[ky+rad][kx+rad] * val2;
          sum3 += kernel[ky+rad][kx+rad] * val3;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      edgeImg.pixels[y*pi.width + x] = color(sum1, sum2, sum3);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();

  image(edgeImg, 20, 240); // Draw the new image
  
  /////////////////histograma///////////////777
  int[] hist = new int[256];

// Calculate the histogram
for (int i = 0; i < pi.width; i++) {
  for (int j = 0; j < pi.height; j++) {
    int bright = int(brightness(get(i, j)));
    hist[bright]++; 
  }
}

// Find the largest value in the histogram
int histMax = max(hist);

stroke(255);
// Draw half of the histogram (skip every second value)
for (int i = 0; i < pi.width; i += 2) {
  // Map i (from 0..img.width) to a location in the histogram (0..255)
  int which = int(map(i, 0, pi.width, 0, 255));
  // Convert the histogram value to a location between 
  // the bottom and the top of the picture
  int y = int(map(hist[which], 0, histMax, pi.height, 0));
  line(i+200, pi.height+300, i+200, y+300);
}
  
  
  
  
  // OLD
  /*
  image(pg, 240, 20); // Posición de la imagen resultante, pg
  pg.beginDraw(); // Inicia el dibujo
  pg.background(100); // Background gris
  pg.stroke(255); // Color del borde
  pg.line(20, 20, mouseX, mouseY); // Movimiento de la linea con el mouse
  pg.endDraw();*/
}
