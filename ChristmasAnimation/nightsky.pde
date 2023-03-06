ArrayList<Star> stars;
color nightskycolor = #0F1117;

void nightsky() {
  background(nightskycolor);
  stars();
  moon();
}

void moon() {
  float rx = 0.73, ry = 0.13, size = min(width, height) * 0.15;
  fill(#FFF4BF);
  ellipse(width * rx, height * ry, size, size);
}

//STARS

void stars() {
  noStroke();
  for (Star star : stars) {
    star.shine();
  }
}

void sprinkleStars() {
  stars = new ArrayList<Star>();
  float fact = 0.01;
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      float nois = noise(i * fact, j * fact);
      if (random(0, 1000) * nois < 1.7) {
        stars.add(new Star(i, j, nois * 5));
      }
    }
  }
}

class Star {
  float x, y, lum;
  Star(float x, float y, float lum) {
    this.x = x;
    this.y = y;
    this.lum = lum;
    
  }

  void shine() {
    float toMap = lum + noise(x, y, time) * 20;
    color col = color(map(toMap, 0, 1.5, 210, 230), map(toMap, 0, 1.5, 210, 230), map(toMap, 0, 1.5, 10, 30));
    fill(col);
    ellipse(x, y, lum, lum);
    if (random(0, 10000) < 1) {
      stroke(col);
      line(x - lum * 2, y, x + lum * 2, y);
      line(x, y - lum * 2, x, y + lum * 2);
      noStroke();
    }
  }
}
