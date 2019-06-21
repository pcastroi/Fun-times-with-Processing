int iter=100;
PShape s;

void setup() {
  size(500, 500, P3D);
  s = createShape();
}

void draw() {
  background(0);
  stroke(255);
  translate(width/2, height/2);
  rotateY(frameCount*0.02);
  if (frameCount==1 || frameCount % 40==0) {
    s = createShape();
    for (int j = 0; j < iter; j++) {
      s.beginShape(POINTS);
      for (int i = 0; i < frameCount*0.5; i++) {
        s.vertex(random(-iter, iter), random(-iter, iter), random(-iter, iter));
      }
      s.endShape(CLOSE);
    }
  }
  shape(s, 0, 0);

  if ((frameCount <= 479)) {
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
