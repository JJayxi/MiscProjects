final float PHI = (1 + sqrt(5))/2, curvature = PI/2;
void setup() {
  size(971, 600);
  recursiveFibonacci(height, height, height, 0, 12);
}
void recursiveFibonacci(float x, float y, float h, float angle, int n) {
  arc(x, y, h * 2, h * 2, angle + PI, angle + 2 * HALF_PI + curvature, PIE);
  if(n > 0) recursiveFibonacci(x - sin(angle) * (-h + h / PHI), 
            y + cos(angle) * (-h + h / PHI), h * (PHI - 1), angle + curvature, n - 1);
}
