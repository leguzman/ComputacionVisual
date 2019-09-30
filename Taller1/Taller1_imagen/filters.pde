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

PImage convolution(PImage inputImg, int[][] kernel) {
   
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
