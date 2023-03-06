PImage normals, diffuse, ambientOcclusion;

boolean doNormal = true, doDiffuse = true, doAmbientOcclusion = true;

void setup() {
  size(600, 600);
  normals = loadImage("cobblestone/nor.jpg");
  diffuse = loadImage("cobblestone/diff.jpg");
  ambientOcclusion = loadImage("cobblestone/ao.jpg");
}

void draw() {
  loadPixels();
  

  for (int x = 0; x < width; x++) {
    float u = x / float(width) - 0.5f;
    for (int y = 0; y < height; y++) {
      float v = y / float(height) - 0.5f;

      pixels[x + y * width] = processColor(u, v);
    }
  }
  updatePixels();
}

color processColor(float u, float v) {
  PVector light = new PVector(float(mouseX) / width - 0.5f, float(mouseY) / height - 0.5f, 0.5f);
  light.mult(2);
  
  color nColor = getColor(normals, u, v);
  PVector normal = new PVector(red(nColor) / 255f - 0.5f, -green(nColor) / 255f + 0.5f, blue(nColor) / 255f - 0.5f);
  PVector dir = PVector.sub(light, new PVector(u, v, 0));
  float lightness = 1;
  if (doNormal)lightness = normal.dot(dir) * 2;
  if (doAmbientOcclusion)lightness *= brightness(getColor(ambientOcclusion, u, v)) / 255f;

  color dif = color(255, 255, 255);
  if (doDiffuse)dif = getColor(diffuse, u, v);

  color c = color(lightness * red(dif), lightness * green(dif), lightness * blue(dif));
  
  return c;
}

color getColor(PImage img, float u, float v) {
  return img.get(int((u + 0.5f) * img.width), int((v + 0.5f) * img.height));
}

void keyPressed() {
  switch(key) {
  case 'n':
    doNormal = !doNormal;
    break;
  case 'o':
    doAmbientOcclusion = !doAmbientOcclusion;
    break;
  case 'd':
    doDiffuse = !doDiffuse;
    break;
  }
}
