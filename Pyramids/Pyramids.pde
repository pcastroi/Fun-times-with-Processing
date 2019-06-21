int MAX_OFF = 300;


void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(0);
  translate(127, 185, 100-(frameCount*0.5));
  rotateZ(frameCount*0.01);
  rotateY(frameCount*0.01);

  rotateX(1);
  strokeWeight(3);
  Pyramid(0, 0, 0, 250);
  if ((frameCount > 250) && (frameCount <= 1000)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}

int colorFromOffset(int offset) {
  return (int) ((offset + MAX_OFF) / (1.8 * MAX_OFF) * 255);
}

void Pyramid(int x, int y, int z, int basePoints) {
  float t=1;
  int f=0;
  for (int k=z; k<(basePoints+z); k=k+5) {
    for (int j=y+f; j<(basePoints+y) - f; j=j+5) {
      for (int i=z+f; i<(basePoints+x) - f; i=i+5) {
        stroke(colorFromOffset(i), colorFromOffset(j), colorFromOffset(k));
        point(i, j, k);
      }
    }
    t=t+0.5;
    f=f+5;
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
