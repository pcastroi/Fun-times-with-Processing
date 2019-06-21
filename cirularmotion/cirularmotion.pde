void setup() {
  size(250, 250);
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  translate(width/2, height/2);
  circ(160/2, int(frameCount));
  circ(53/2, int(frameCount));
  circ(480/2, int(frameCount));
  if ((frameCount <= 200)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}

void circ(int obj, int num) {
  float radius=obj;
  int numPoints=num;
  float angle=TWO_PI/(float)numPoints;
  for (int i=0; i<numPoints; i++) {
    ellipse(radius*sin(angle*i),radius*cos(angle*i),radius,radius);
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
