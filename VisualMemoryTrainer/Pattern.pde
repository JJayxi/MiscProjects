class Pattern {
  boolean[][] pattern;
  boolean[][] played;
  int w, h;
  float filling;


  //CONSTRUCTOR
  Pattern(int w, int h) {
    create(w, h, 0.5);
  }
  
  Pattern(int w, int h, float filledRatio) {
    create(w, h, filledRatio);
  }
  
  
  int WAITING_LENGTH = 0, WIN_PAUSE_LENGTH = 1000;
  long startTime = -1;
  int state = 0;
  public static final int STATE_WAITING_TO_START = -1, STATE_SHOW = 0, STATE_PLAYER = 1, STATE_FINISHED = 2;
  
  WinParticles winParticles = null;
  
  void create(int w, int h, float filledRatio) {
    filling = filledRatio;
    winParticles = null;
    
    WAITING_LENGTH = (int)(Math.sqrt((w + h) / 4) * 500);
    startTime = -1;
    state = STATE_WAITING_TO_START;
    
    this.w = w;
    this.h = h;
    pattern = new boolean[h][w];
    played  = new boolean[h][w];
    for (int i = 0; i < h; i++) {
      for (int j = 0; j < w; j++) {
        pattern[i][j] = Math.random() < filling;
      }
    }
  }
  
  public void show() {
    noStroke();
    if (state == STATE_WAITING_TO_START) {
      fill(#C3E3D8);
      rect(50, 120, width - 100, height - 240, 24);
      
      fill(#4E4550);
      textSize(40);
      textAlign(CENTER);
      text("CLICK TO START", width / 2, height / 2 + 20);
      return;
    }
    
    
    int dw = width / w, dh = height / h, padding = 2;

    for (int i = 0; i < h; i++) {
      for (int j = 0; j < w; j++) {
        if (state == STATE_PLAYER) {
          if (!played[i][j])       fill(27     );
          else if (pattern[i][j])  fill(#4DD376);
          else                     fill(#EA4545);
        } else {
          if (pattern[i][j])       fill(#4DD376);
          else                     fill(27      );
        }
        rect(j * dw + padding, i * dh + padding, 
          dw - 2 * padding, dh - 2 * padding, 14);
      }
    }
  }

  
  void update() {
    if (state == STATE_SHOW && (System.nanoTime() - startTime) / 1000000 >= WAITING_LENGTH) {
      state = STATE_PLAYER;
    } else if (state == STATE_FINISHED) {
      winParticles.update();
      if((System.nanoTime() - startTime) / 1000000 >= WIN_PAUSE_LENGTH)create(w, h, filling);
    }
  }

  void press() {
    if (state == STATE_WAITING_TO_START) {
      state = STATE_SHOW;
      startTime = System.nanoTime();
    } else if (state == STATE_PLAYER) {
      played[mouseY / (height / h)][mouseX / (width / w)] = !played[mouseY / (height / h)][mouseX / (width / w)];

      boolean everythingCorrect = true;
      for (int i = 0; i < h; i++) {
        for (int j = 0; j < w; j++) {
          if (pattern[i][j] != played[i][j])everythingCorrect = false;
        }
      }
      if(everythingCorrect) {
        winParticles = new WinParticles();
        state = STATE_FINISHED;
        startTime = System.nanoTime();
      }
    }
  }
}
