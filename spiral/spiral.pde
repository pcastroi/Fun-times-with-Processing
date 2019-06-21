void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  strokeWeight(5);
  translate(width/2, height/2);
  spiralP();
  if ((frameCount >= 1800) && (frameCount <= 2500)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}

void spiralP() {
  int radius=0;
  int numPoints=frameCount;
  float angle=TWO_PI/((float)numPoints/300);
  for (int i=0; i<numPoints; i++) {
    point(radius*sin(angle*i), radius*cos(angle*i));
    radius++;
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
