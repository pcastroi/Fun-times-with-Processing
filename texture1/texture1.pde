int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;


void setup() {
  size(1000, 1000, P3D);
  cols = w / scl;
  rows = h / scl;
}

void draw() {
  background(0);
  stroke(255, 125.0);
  frameRate(1);
  translate(-w/2, -h/2-cols, 100-frameCount*15);

  for (int y = 0; y < rows-1; y++) {
    beginShape(LINES);
    for (int x = 0; x < cols; x++) {
      vertex((x+y)*scl, y*scl, 0);
      vertex(x*scl, (y+x)*scl, 0);
    }
    //for (int x = 0; x < cols; x++) {
    //  vertex(x*scl, y*scl, 0);
    //  vertex(x*scl, (y+1)*scl, 0);
    //}
    endShape();
  }
  if ((frameCount <= 200)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
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
