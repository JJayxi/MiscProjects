final float PHI = (1 + sqrt(5))/2, spiralHeight = 600;  //0 - PI * 0.5
float curvature = PI, h;
int numberRecursion = 15;

void setup() {
  size(971, 742);
  
  h = 0.7639323 * spiralHeight;  //y position of the tip of the spiral
}

void draw() {
  curvature = map(mouseX, 0, width, -TWO_PI, TWO_PI);
  background(11);
    
  stroke(0);
  recursiveFibonacci(spiralHeight, spiralHeight, spiralHeight, 0, numberRecursion);
  
  noFill();
  stroke(255, 130);
  ellipse(spiralHeight, h  / 2, h, h);
}

void recursiveFibonacci(float x, float y, float h, float angle, int n) {
  float newX = x - sin(angle)*(-h + h/PHI), 
        newY = y + cos(angle)*(-h + h/PHI), 
        newH = h * (PHI - 1);
        
  int fillValue = 255 - 255 / numberRecursion * n;
  
  fill(fillValue, 200);  
  arc(x, y, h * 2, h * 2, angle + PI, angle + 3 * HALF_PI);
  
  fill(40, fillValue, 71, 200);
  arc(newX, newY, newH * 2, newH * 2, angle + PI + min(HALF_PI, curvature), angle + PI + max(HALF_PI, curvature));
  
  if (n > 0)recursiveFibonacci(newX, newY, newH, angle + curvature, n - 1);
}
