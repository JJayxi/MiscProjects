float time = 0.00;
void setup() {
  size(600, 600);
  noCursor();
  noStroke();
  generateScene();
  frameRate(60);
  background(0);
}

void draw() {
  nightsky();
  showLand();  
  time += 0.01;
  
}



void keyPressed() {
  switch(key) {
  case 'r':
    generateScene();
    noiseSeed(frameCount);
    break;
  case 'l':
    break;
  }
}

void generateScene() {
  sprinkleStars();
  generateLand();
}
