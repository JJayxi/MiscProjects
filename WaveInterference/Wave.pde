public class Wave {
  public float period, lambda, amplitude;
  public float x, y;
  
  public Wave(float x, float y, float per, float lam, float amp) {
     period = per;
     lambda = lam;
     amplitude = amp;
     this.x = x;
     this.y = y;
  }
  
  public float distToWave(float px, float py) {
    return dist(x, y, px, py);
  }
  
  public float elongation(float dist, float time) {
    return amplitude * sin(2 * PI *(time/period + dist/lambda));
  }
}
