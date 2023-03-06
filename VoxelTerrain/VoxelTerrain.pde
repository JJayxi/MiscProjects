QuadTree tree;

void setup() {
  size(700, 700);
  //fullScreen();
  frameRate(1000);
  tree = new QuadTree(0, 0, width, height, 0);
}


void draw() {
  long start = System.nanoTime();
  background(51); 
  if (showTree)tree.show();
  stroke(0, 255, 0);
  noFill();
  ellipse(mouseX, mouseY, fillSize * 2, fillSize * 2);

  if (showRay) {
    int n = 200;
    fill(255);
    noStroke();
    //beginShape();
    for (int i = 0; i < n; i++) {
      //PVector t = rayTraversal(mouseX, mouseY, -PI + TWO_PI / n * i + 0);
      ray(mouseX, mouseY, -PI + TWO_PI / n * i + 0);
      //vertex(t.x, t.y);
    }
    //endShape();
  }

  if ((System.nanoTime() / 1000000000) % 1 == 0) {
    long end = System.nanoTime();
    println(frameRate + " fps (Frametime: " + (end - start) / 1000 + " us)");
  }
}

void mousePressed() {
  int toFill = -1;
  switch(mouseButton) {
  case LEFT:
    toFill = 1;
    break;
  case RIGHT:
    toFill = 0;
    break;
  case CENTER:
    showRay = true;
    break;
  }
  if (toFill != -1) {
    long start = System.nanoTime();
    tree.fillCircle(mouseX, mouseY, fillSize, toFill);
    long end = System.nanoTime();
    println("Time to fill: " + (end - start) / 1000 + " us");
  }
}

void mouseReleased() {
  switch(mouseButton) {
  case CENTER:
    showRay = false;
    break;
  }
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  fillSize += e * 5;

  fillSize = max(2, min(fillSize, 200));
}

float fillSize = 40;
void mouseDragged() {
  int toFill = 0;
  switch(mouseButton) {
  case LEFT:
    toFill = 1;
    break;
  case RIGHT:
    toFill = 0;
    break;
  }
  tree.fillCircle(mouseX, mouseY, fillSize, toFill);
}


boolean showRay = false, showTree = true;
void keyPressed() {
  switch(key) {
  case 'r':
    showRay = !showRay;
    break;
  case 't':
    showTree = !showTree;
    break;
  }
}
