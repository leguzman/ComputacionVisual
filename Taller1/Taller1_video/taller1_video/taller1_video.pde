import processing.video.*;
Movie video;
PFont f;

void setup() {
  size(680, 600);
  //f = createFont("Arial", 16, true); // Crea el tipo de fuente
  //textFont(f, 12); // Tipo de fuente a usar
  //fill(0); // Fuente de color negro
  video = new Movie(this, "sun_clouds.mp4");
  video.loop();
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void luma(int posX, int posY, int Width, int Heigth){
  loadPixels();
  float r = 0, g = 0, b = 0, avg = 0;
  for(int x = 0; x < 220; x++) { 
   for(int y = 0; y < 220; y++){
     color c = get(x, y);
     r = red(c); g = green(c); b = blue(c);
     avg = (r + g + b)/3;
     pixels[y*200 + x] = color(avg, avg, avg);
   }
  }
  updatePixels();
}

void draw() {
  //g.background(200, 200, 200); // Fondo gris claro
  image(video, 20, 20, 200, 200);
  luma(20,20,200,200);
}
