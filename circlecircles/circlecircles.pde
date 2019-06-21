void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(0);
  noFill();
  stroke(255, 125.0);
  translate(width/2, height/2);
  circ(200);
  circ(frameCount);
  if ((frameCount <= 200)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}

void circ(int obj) {
  float r = 100 + frameCount*4;
  float y = 0;
  float x = 0;
  for (x = -obj; x < obj; x++) {
    y=sqrt(pow(r, 2)-pow(x, 2));
    ellipse(x, y, r, r);
    ellipse(-x, -y, r, r);
  }
  for (y = -obj; y < obj; y++) {
    x=sqrt(pow(r, 2)-pow(y, 2));
    ellipse(x, y, r, r);
    ellipse(-x, -y, r, r);
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
