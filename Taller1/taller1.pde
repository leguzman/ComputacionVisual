PImage img1, img2, img3, img4;
//PGraphics pg1, pg2;
PFont f;

PImage grayScaleBasic(PImage inputImg) {
  PImage outputImg = createImage(inputImg.width, inputImg.height, RGB); // Crea una imagen con el tamaño de inputImg
  outputImg.loadPixels(); // Carga los píxeles de la imagen en una matriz
  float r = 0, g = 0, b = 0, avg = 0;
  color c;
  for (int i = 0; i < inputImg.pixels.length; i++) {
    c = inputImg.pixels[i];
    //r = c>>16&0xFF; g = c>>8&0xFF; b = c&0xFF; // Más rápido
    r = red(c); g = green(c); b = blue(c);
    avg = (r + g + b)/3;
    outputImg.pixels[i] = color(avg, avg, avg);
  }
  outputImg.updatePixels();
  return outputImg;
}

PImage grayScaleLuma(PImage inputImg) {
  PImage outputImg = createImage(inputImg.width, inputImg.height, RGB); // Crea una imagen con el tamaño de inputImg
  outputImg.loadPixels(); // Carga los píxeles de la imagen en una matriz
  float r = 0, g = 0, b = 0, luma = 0;
  color c;
  for (int i = 0; i < inputImg.pixels.length; i++) {
    c = inputImg.pixels[i];
    r = red(c)*0.21; g = green(c)*0.71; b = blue(c)*0.08;
    luma = r + g + b;
    outputImg.pixels[i] = color(luma, luma, luma);
  }
  outputImg.updatePixels();
  return outputImg;
}

PImage blurEffect(PImage inputImg) {
  float v = 1.0 / 9.0;
  float[][] kernel = {{ v, v, v }, 
                      { v, v, v }, 
                      { v, v, v }};
  
  // Create an opaque image of the same size as the original
  PImage edgeImg = createImage(inputImg.width, inputImg.height, RGB);
  int rad = kernel.length/2;
  // Loop through every pixel in the image
  float val1, val2, val3, sum1, sum2, sum3;
  for (int y = rad; y < inputImg.height-rad; y++) {   // Skip top and bottom edges
    for (int x = rad; x < inputImg.width-rad; x++) {  // Skip left and right edges
      sum1 = 0; // Kernel sum for this pixel
      sum2 = 0; // Kernel sum for this pixel
      sum3 = 0; // Kernel sum for this pixel
      for (int ky = -rad; ky <= rad; ky++) {
        for (int kx = -rad; kx <= rad; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*inputImg.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          val1 = red(inputImg.pixels[pos]);
          val2 = green(inputImg.pixels[pos]);
          val3 = blue(inputImg.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum1 += kernel[ky+rad][kx+rad] * val1;
          sum2 += kernel[ky+rad][kx+rad] * val2;
          sum3 += kernel[ky+rad][kx+rad] * val3;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      edgeImg.pixels[y*img1.width + x] = color(sum1, sum2, sum3);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();
  return edgeImg;
}

void setup() {
  size(680, 600); // Tamaño de la ventana principal
  img1 = loadImage("partenon.jpg"); // Carga la imagen base
  f = createFont("Arial",16,true); // STEP 2 Create Font
  textFont(f, 12);                  // STEP 3 Specify font to be used
  fill(0);                         // STEP 4 Specify font color
  noLoop(); // Se ejecuta el programa una sola vez
}

void draw(){
  g.background(200, 200, 200); // Background gris claro
  image(img1, 20, 20); // Imagen original
  text("Imagen original", 20, 230);
  
  img2 = grayScaleBasic(img1); // Conversión a escala de grises básico
  image(img2, 240, 20);
  text("Escala de grises", 240, 230);

  img3 = grayScaleLuma(img1); // Conversión a escala de grises Luma
  image(img3, 460, 20);
  text("Luma", 460, 230);
  
  img4 = blurEffect(img1); // Uso de efecto blur
  image(img4, 20, 240);
  text("Blur", 20, 450);
  
  /////////////////histograma///////////////777
  int[] hist = new int[256];

  // Calculate the histogram
  for (int i = 0; i < img1.width; i++) {
    for (int j = 0; j < img1.height; j++) {
      int bright = int(brightness(get(i, j)));
      hist[bright]++; 
    }
  }

  // Find the largest value in the histogram
  int histMax = max(hist);
  
  stroke(255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < img1.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, img1.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, img1.height, 0));
    line(i+200, img1.height+300, i+200, y+300);
  }
  
  // Código antiguo
  /*
  image(pg, 240, 20); // Posición de la imagen resultante, pg
  pg.beginDraw(); // Inicia el dibujo
  pg.background(100); // Background gris
  pg.stroke(255); // Color del borde
  pg.line(20, 20, mouseX, mouseY); // Movimiento de la linea con el mouse
  pg.endDraw();
  */
}
