void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(0);
  noFill();
  stroke(255, 125.0);
  translate(width/2, height/2, -500);
  rotateY(frameCount*0.01);
  shape(1000);
  if ((frameCount <= 400)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}

void shape(int obj) {
  float r = 50;
  float y0 = 0;
  float x0 = 0;
  float a = 0;
  float p = 0;
  for (x0 = -obj; x0 < obj; x0++) {
    y0 = sqrt(pow(r, 2)-pow(x0, 2));
    p = frameCount*1.6;
    a -= PI/2.0;
    line(x0, y0, -p, x0 + cos(a)*p, y0 + sin(a)*p, p);
    line(-x0, -y0, -p, x0 + cos(a)*p, y0 + sin(a)*p, p);

    line(x0, y0, p, x0 + cos(a)*p, y0 + sin(a)*p, -p);
    line(-x0, -y0, p, x0 + cos(a)*p, y0 + sin(a)*p, -p);
  }
  for (y0 = -obj; y0 < obj; y0++) {
    x0 = sqrt(pow(r, 2)-pow(y0, 2));
    p = frameCount*1.6;
    a -= PI/2.0;
    line(x0, y0, -p, x0 + cos(a)*p, y0 + sin(a)*p, p);
    line(-x0, -y0, -p, x0 + cos(a)*p, y0 + sin(a)*p, p);
    line(x0, y0, p, x0 + cos(a)*p, y0 + sin(a)*p, -p);
    line(-x0, -y0, p, x0 + cos(a)*p, y0 + sin(a)*p, -p);
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
