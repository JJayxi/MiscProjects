class WinParticles {
  
  Particle first = null;
  
  WinParticles() {
    for(int i = 0; i < 500; i++)addNewParticle();
  }
  
  void addNewParticle() {
    Particle newFirst = new Particle();
    newFirst.next = first;
    first = newFirst;
  }
  
  void update() {
    update(first);
  }
  
  void update(Particle current) {
    if(current == null)return;
    current.update();
    current.show();
    update(current.next);
  }
  
  class Particle {
    float x, y, vx, vy, a;
    color col;
    Particle next = null;
    
    Particle() {
      a = random(0.6, 1.3);
     reset();
    }
    
    void reset() {
      col = color(random(190, 255), random(150, 255), random(90, 180));
      x = mouseX; y = mouseY;
     vx = random(-3, 3); vy = random(-3, 3);
   }
      
    void update() {
      x += vx;
      y += vy;
      vy += a;
      
      if(y > height)reset();
    }
    
    void show() {
      fill(col);
      stroke(col);
      line(x-5, y, x+5 , y); 
      line(x, y-5, x , y+5); 
      ellipse(x, y, 2, 2);
    }
  }
}
