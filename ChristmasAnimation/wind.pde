import java.util.Stack;

PVector windVector(float x, float y) {
  float a = windAngle(x, y);
  float wx = -cos(a);
  float wy = sin(a) * 0.4; // - map(y, 0, height, 0.1, -0.4);
  return new PVector(wx * 3, wy * 1);
}

float windAngle(float x, float y) {
  float scale = 0.01;
  return map(noise(x * scale, y * scale, time), 0, 1, -TWO_PI, 0);
}


ArrayList<Stack<PVector>> leafs  = new ArrayList<Stack<PVector>>();
  void show() {
    for (Stack<PVector> leafStack : leafs) {
      
      PVector leaf = leafStack.peek();
      PVector wind = windVector(leaf.x, leaf.y);
      leafStack.add(new PVector(leaf.x - wind.x, leaf.y + wind.y)); 
      
      if (leafStack.size() > 30)leafStack.remove(0);
      leaf = leafStack.get(0);
      if (leaf.x > width || leaf.y < 0 || leaf.y > height || leaf.x < 0) {
        leafStack.clear();
        leaf.x =random(width, width + 200);
        leaf.y = random(height);
        leafStack.add(leaf);
      }
    }
  }
  
  void fillLeafs() {
  leafs.clear();
  for (int i = 0; i < 30; i++) {
    Stack<PVector> leaf = new Stack<PVector>();
    leaf.add(new PVector(random(-300, width), random(height)));
    leafs.add(leaf);
  }
}
