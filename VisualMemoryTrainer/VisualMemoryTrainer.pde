Pattern pat;

void setup() {
  size(600, 600);
  noStroke();
  createPattern();
}

void createPattern() {
   pat = new Pattern(6, 6, 0.30);
}

void draw() {
  background(57);
  pat.show();
  pat.update();  
}

void mousePressed() {
  pat.press(); 
}

void keyPressed() {
  if(key == 'r')createPattern();
}
