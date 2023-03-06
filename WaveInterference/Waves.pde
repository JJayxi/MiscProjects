
float scale = 1.7f/100f;
Wave[] waves = new Wave[2];
float time = 0.0;
float lambda = 0.9;
float freq = 0.6;

void setup() {
  size(1000, 1000, P2D);
  waves[0] = new Wave(0, -3, freq, lambda, 1);
  waves[1] = new Wave(0, 3, freq,  lambda, 1);
}


void draw() {
  time -= 0.01;
  translate(width / 2, height / 2);
  
 // waves[1].x = (mouseX - width / 2) * scale;
  //waves[1].y = (mouseY - height / 2) * scale;
  float maxElongation = 0;
  float[] elong = new float[height * width];
  for (int j = 0; j < height; j++) {
    float y = (j - height / 2) * scale;
    for (int i = 0; i < width; i++) {
      float x = (i - width / 2) * scale;
      float elongation = 0;

      for (Wave wave : waves) {
        elongation += wave.elongation(wave.distToWave(x, y), time);
      }
      if (elongation > maxElongation)maxElongation = elongation;
      elong[j * width + i] =elongation;
    }
  }

  loadPixels();
  for (int j = 0; j < height; j++) {
    float y = (j - height / 2) * scale;
    for (int i = 0; i < width; i++) {
      float x = (i - width / 2) * scale;
      
      //float elong1 = waves[0].elongation(waves[0].distToWave(x, y), time) + 1;
      //float elong2 = waves[1].elongation(waves[1].distToWave(x, y), time) + 1;
      float elongation = elong[j * width + i];
      
      float isConstant = abs((2/lambda * (abs(waves[1].distToWave(x, y) - waves[0].distToWave(x, y))) - 1) % 2);
      
      
      int colHue = int((elongation + maxElongation) / (2 * maxElongation) * 255);
      if(isConstant < 0.08) {
        pixels[j * height + i] = color(int(255 * abs(isConstant)));
       continue;
      }

    pixels[j * height + i] = color(255 - colHue * 0.5); //, 51, 111);
      
      
    }
  }
  updatePixels();
  for(int i = -10; i < 10; i++) {
    stroke(0, 0, 0, 130);
    line(-width / 2, i / scale, width / 2, i / scale);
    line(i / scale, -height / 2, i / scale , height / 2);
  }
}
