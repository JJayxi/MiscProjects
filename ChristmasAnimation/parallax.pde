ParallaxGround[] grounds;


void generateLand() {
  grounds = new ParallaxGround[6];
  for (int i = 0; i < grounds.length; i++) {
    int d = grounds.length - i;
    grounds[i] = new ParallaxGround(d, 200 + d * 20);
  }
}

void showLand() {
  for (ParallaxGround pg : grounds) {
    pg.show();
  }
}


class ParallaxGround {
  int depth;
  float h, phase;
  Tree[] trees;

  Wind wind;
  ParallaxGround(int depth, float h) {
    this.depth = depth;
    this.h = h;
    phase = random(TWO_PI);
    trees = new Tree[10 * depth];
    for (int i = 0; i < trees.length; i++) {
      trees[i] = new Tree(random(0, width / 2 * 3), 20f / depth);
    }
    wind = new Wind();
  }

  float movedX() {
    return time / depth * width / 2;
  }
  void show() {


    if (depth < 5)wind.show();
    noStroke();
    fill(map(depth, 1, 10, 255, 30));
    beginShape();
    for (int i = 0; i < width; i++) {
      vertex(i, height - groundHeight(i - movedX()));
    }
    vertex(width, height);
    vertex(0, height);
    endShape();

    noStroke();
    for (Tree tree : trees) {
      tree.show();
    }
  }

  float groundHeight(float x) {
    float d = (x) / width * TWO_PI;
    float val = cos(0.3 * d + phase);
    return h / 4 * 3 + val * h / depth / 2;
  }

  class Tree {

    float size, layers, x, y, saplin;
    color leafCol, tronk;

    Tree(float x, float s) {
      create(x, s);
    }

    void show() {
      float level = size / layers;
      float dy = layers / 6f * saplin;
      float px = x + movedX();

      fill(tronk);
      rect(px - saplin / 4, y - dy, saplin / 2, dy * 2);
      fill(leafCol);

      /*
      for (int i = 1; i <= layers; i++) {
       float py = y - (layers - i) * level;
       float w = (i + 1) * level;
       leafs(px, py, w / 2);
       }*/

      float py = y;
      pushMatrix();
      translate(px, py);
      for (int i = 1; i <= layers; i++) {
        py -=  level;
        float angle = -exp((PI + windAngle(x, py)))* 0.04;
        rotate(angle);
        float w = (layers - i + 2) * level;
        leafs(0, 0, w / 2);
        translate(0, -level);
      }
      popMatrix();


      if (2 * level + x - 100 + movedX() > width) {
        create(-movedX() - random(100, width), saplin);
      }
    }

    void create(float x, float s) {
      layers = int(random(4, 9));
      size = layers * random(0.7, 1.2) * s;
      saplin = s;
      this.x = x;
      y = height - groundHeight(x) + random(-10 / depth, -20 / depth);

      float gar = (7 - depth) / 10f;
      leafCol = color(35 + random(-15, 15), gar * 255, 35 + random(-10, 20));
      tronk = color(gar * 40 + 20 + random(10), gar * 30 + 10 + random(10), gar * 20 + 10 + random(10));
    }

    void leafs(float x, float y, float r) {
      float dx = r * cos(PI / 3);
      triangle(x - dx, y, x + dx, y, x, y - r);
    }
  }

  class Wind {
    WindLine[] windLines;
    Wind() {
      windLines = new WindLine[5 * depth];
      for (int i = 0; i < windLines.length; i++) {
        windLines[i] = new WindLine();
      }
    }

    void show() {
      strokeWeight((8 - depth) / 3);
      for (WindLine windLine : windLines) {
        windLine.show();
      }
    }
    class WindLine {
      Stack<PVector> positions;
      int lifeTime;
      WindLine() {
        positions = new Stack<PVector>();
        create();
      }

      void show() {
        for (int j = 0; j < positions.size() - 1; j++) {
          float ladw = 70 / depth + 30;
          stroke(ladw, ladw, ladw, cos(map(lifeTime, 0, 400, 0, PI)) * map(j, 0, positions.size(), 0, 255));
          line(positions.get(j).x - movedX(), positions.get(j).y, positions.get(j + 1).x - movedX(), positions.get(j + 1).y);
        }

        PVector last = positions.peek();
        PVector wind = windVector(last.x, last.y);
        lifeTime--;
        positions.add(new PVector(last.x - wind.x / depth, last.y - wind.y / depth));
        if (positions.size() > 50)positions.remove(0);
        if (positions.get(0).x - movedX() < 0 || lifeTime < 0) {
          create();
        }
      }

      void create() {
        positions.clear();
        positions.add(new PVector(width + movedX() + random(300), random(height)));
        lifeTime = int(random(1000, 3000));
      }
    }
  }
}
