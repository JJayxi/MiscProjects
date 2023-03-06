class QuadTree {

  public static final int MAX_DEPTH = 9;
  QuadTree branches[];

  boolean subdivided = false;
  int value, depth;
  float x, y, w, h;

  QuadTree(float x, float y, float w, float h, int depth) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.depth = depth;
    branches = new QuadTree[4];
    value = 0;
  }

  boolean isInCircle(float px, float py, float radius) {
    float dx = max(abs(px - x), abs(px - x - w));
    float dy = max(abs(py - y), abs(py - y - h));
    return dx * dx + dy * dy < radius * radius;
  }

  boolean intersectsCircle(float px, float py, float radius) {
    float cx = min(max(px, x), x + w) - px;
    float cy = min(max(py, y), y + w) - py;
    return cx * cx + cy * cy < radius * radius;
  }

  boolean fillCircle(float px, float py, float radius, int value) {
    if (this.value == value)return true;
    if (isInCircle(px, py, radius)) {
      unsubdivide();
      this.value = value;
      return true;
    }

    if (intersectsCircle(px, py, radius)) {
      if (depth == MAX_DEPTH) {
        this.value = value;
        insert(px, py, value);
        return true;
      }

      if (!subdivided)subdivide();
      boolean unsub = true;
      for (QuadTree branch : branches) {
        branch.fillCircle(px, py, radius, value);
        if (branch.value != value)unsub = false;
      }
      if (unsub) {
        unsubdivide();
        this.value = value;
        return true;
      }
    }
    return false;
  }

  void insert(float px, float py, int value) {
    if (value == this.value) return; 
    if (depth < MAX_DEPTH) {
      int qN = quadrant(px, py);
      if (!subdivided) subdivide();
      branches[qN].insert(px, py, value);

      for (QuadTree branch : branches) {
        if (branch.value != value)return;
      }

      this.value = value;
      unsubdivide();
    } else {
      this.value = value;
    }
  }


  void unsubdivide() {
    branches = null;
    subdivided = false;
  }

  void subdivide() {
    float w2 = w / 2;
    float h2 = h / 2;
    branches = new QuadTree[4];
    branches[0] = new QuadTree(x, y, w2, h2, depth + 1);
    branches[1] = new QuadTree(x + w2, y, w2, h2, depth + 1);
    branches[2] = new QuadTree(x, y + h2, w2, h2, depth + 1);
    branches[3] = new QuadTree(x + w2, y + h2, w2, h2, depth + 1);
    branches[0].value = this.value;
    branches[1].value = this.value;
    branches[2].value = this.value;
    branches[3].value = this.value;
    subdivided = true;
    value = -1;
  }

  QuadTree getAt(float px, float py) {
    if (!subdivided)return this;
    int quadr = quadrant(px, py);
    if (quadr == -1)return null;
    return branches[quadr].getAt(px, py);
  }

  int quadrant(float px, float py) {
    if (px < x || px > x + w || py < y || py > y + h)return -1;
    int qN = ((px - x - w / 2 > 0) ? 1 : 0) + ((py - y - h / 2 > 0) ? 2 : 0);
    return qN;
  }

  void show() {

    if(subdivided)
    for (QuadTree branch : branches) {
      if (branch != null)branch.show();
    }
    noStroke();
    stroke(21);
    if (value == 1) {
      fill(#8A6093);
      rect(x, y, w, h);
    } else if (value == 2) {
      fill(255, 0, 0);
    } else {
      noFill();
    }
  }
}
