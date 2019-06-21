

PVector[][] globe;
int total = 50;


void setup() {
  size(500, 500, P3D);
  globe = new PVector[total+1][total+1];
}

void draw() {
  delay(50);
  background(0);
  noFill();
  translate(width/2, height/2, -230);
  rotateX(100);
  rotateY((frameCount*0.01)+200);
  spherilla(0, 0, 200);
  spherilla(frameCount, frameCount, 200);
  spherilla(-frameCount, -frameCount, 200);
  spherilla(frameCount*2, frameCount*2, 200);
  if ((frameCount <= 250)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}
void spherilla(float w, float h, float r) {
  translate(w, h);
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, -PI, PI);
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, -HALF_PI, HALF_PI);
      float x = r * sin(lon) * cos(lat);
      float y = r * sin(lon) * sin(lat);
      float z = r * cos(lon);
      globe[i][j] = new PVector(x, y, z);
    }
  }

  for (int i = 0; i < total; i++) {
    beginShape();
    for (int j = 0; j < total; j++) {
      PVector v1 = globe[i][j];
      stroke(255);
      vertex(v1.x, v1.y, v1.z);
      PVector v2 = globe[i+1][j+1];
      stroke(255);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
  for (int i = 0; i < total; i++) {
    beginShape();
    for (int j = 0; j < total; j++) {
      PVector v1 = globe[i][j];
      stroke(255);
      vertex(-(v1.x), -(v1.y), -(v1.z));
      PVector v2 = globe[i+1][j+1];
      stroke(255);
      vertex(-(v2.x), -(v2.y), -(v2.z));
    }
    endShape();
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
