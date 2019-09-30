void histogram(PImage img){  
  /////////////////histograma///////////////777
  int[] histRed = new int[256];
  int[] histGreen = new int[256];
  int[] histBlue = new int[256];
  // Calculate the histogram
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int reds = int(red(img.get(i, j)));
      int greens = int(green(img.get(i, j)));
      int blues = int(blue(img.get(i, j)));
      histRed[reds]++;
      histGreen[greens]++;
      histBlue[blues]++;
    }
  }
  
  // Find the largest value in the histogram
  int histMaxR = max(histRed);
  int histMaxG = max(histGreen);
  int histMaxB = max(histBlue);
  
  // HISTOGRAMA ROJO
  stroke(255, 0, 0);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < 200; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, 200, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(histRed[which], 0, histMaxR, 0, 200));
    
    line(i+700, 440-y, i+700, 440);
  }
  
  // HISTOGRAMA VERDE  
  stroke(0, 255, 0);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < 200; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, 200, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(histGreen[which], 0, histMaxG, 0, 200));
    
    line(i+920, 440-y, i+920, 440);
  }
  
  // HISTOGRAMA BLUE
  stroke(0, 0, 255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < 200; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, 200, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(histBlue[which], 0, histMaxB, 0, 200));
    
    line(i+1140, 440-y, i+1140, 440);
  }
}
