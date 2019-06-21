int BLOCK_W;
int BLOCK_H;

void setup() {
  size(500, 500);
  BLOCK_W = width/10;
  BLOCK_H = height/10;
}

void draw() {
  for (int i = 0; i < width; i = i+BLOCK_W) {
    for (int j = 0; j < height; j = j+BLOCK_H) {
      drawBlock(j, i);
    }
  }
  
  if ((frameCount <= 100)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}

void drawBlock(int x, int y) {
  rect(x, y, BLOCK_W, BLOCK_H);
  fill(random(255),random(255),random(255));
}

class TImage extends PImage implements Runnable { //separate thread for saving images
  String filename;

  TImage(int w, int h, int format, String filename) {
    this.filename = filename;
    init(w, h, format);
  }

  public void saveThreaded() {
    new Thread(this).start();
  }

  public void run() {
    this.save(filename);
  }
}
