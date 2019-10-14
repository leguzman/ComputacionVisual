import processing.video.*;
PFont f;
Movie video;
int fr = 60;
int Width = 690, Height = 600;

int[][] edge = {
  {-1, -1, -1},
  {-1,  8, -1},
  {-1, -1, -1}
};

int[][] sharpen = {
  { 0, -1 , 0},
  {-1,  5, -1},
  { 0, -1 , 0}
};

int[][] blur = {
  { 0,  1,  0},
  { 1,  2,  1},
  { 0,  1,  0},
};

void grayScaleBasic(int posX, int posY){
  loadPixels();
  color c, cAvg;
  for(int x = posX; x < posX + 200; x++) {
   for(int y = posY; y < posY + 200; y++) {
     c = get(x, y);
     cAvg = color(red(c) + green(c) + blue(c));
     pixels[y * Width + x] = cAvg;
   }  
  }
  updatePixels();
}

void grayScaleLuma(int posX, int posY){
  loadPixels();
  color c, cLuma;
  for(int x = posX; x < posX + 200; x++) {
   for(int y = posY; y < posY + 200; y++) {
     c = get(x, y);
     cLuma = color(red(c) * 0.2126 + green(c) * 0.7152 + blue(c) * 0.0722);
     pixels[y * Width + x] = cLuma;
   }  
  }
  updatePixels();
}

void convolution(int posX, int posY, int[][] kernel){
  loadPixels();
  for(int x = posX; x < posX + 200 ; x++) {
   for(int y = posY; y < posY + 200; y++){
     color cFilter = getFilter(x, y, kernel);
     pixels[y * Width + x] = cFilter;
   }   
  }
  updatePixels();
}

color getFilter(int x, int y, int[][] kernel){
  color result;
  float r = 0.0, g = 0.0, b = 0.0;
  for(int wi = -1; wi <= 1; wi++){
    for(int hi = -1; hi <= 1; hi++){
      int new_x = x + wi, new_y = y + hi;
      color temp_color = get(new_x, new_y);
      float val_mat = kernel[wi + 1][hi + 1];
      r += (red(temp_color) * val_mat);
      g += (green(temp_color) * val_mat);
      b += (blue(temp_color) * val_mat);
    }
  }
  result = color(r,g,b);
  return result;
}

void setup() {
  size(690, 600);
  f = createFont("Arial", 16, true); // Crea la fuente
  textFont(f, 12); // Especifica la fuente
  fill(0); // Especifica el color de la fuente
  video = new Movie(this, "sun_clouds.mp4");
  video.loop(); 
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(200, 200, 200); // Background gris claro
  loadPixels();
  
  image(video, 20, 20, 200, 200); // Video original
  text("Video original", 20, 230);
  
  image(video, 240, 20, 200, 200); // Escala de grises
  grayScaleBasic(240, 20); 
  text("Escala de grises", 240, 230);
  
  image(video, 460, 20, 200, 200); // Luma 
  grayScaleLuma(460, 20); 
  text("Luma", 460, 230);
  
  image(video, 20, 240, 200, 200); // Convolución Edge
  convolution(20, 240, edge); 
  text("Edge", 20, 450);
  
  image(video, 240, 240, 200, 200); // Convolución Sharpen
  convolution(240, 240, sharpen); 
  text("Sharpen", 240, 450);
  
  image(video, 460, 240, 200, 200); // Convolución Blur
  convolution(460, 240, blur); 
  text("Blur", 460, 450);
  
  String frtxt = "Framerate "+ frameRate;
  text(frtxt, 20, 480);
  
  String efftxt = "Efficiency "+ frameRate/fr*100 + "%";
  text(efftxt, 20, 500);
} //<>//
