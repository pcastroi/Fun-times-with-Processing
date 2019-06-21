int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;

float flying = 0;

float[][] terrain;


void setup() {
  size(500, 500, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void draw() {

  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -125, 125);
      xoff += 0.15;
    }
    yoff += 0.15;
  }


  background(0);
  stroke(255);
  noFill();
  frameRate(1);
  translate(width/1.25, height/1.25);
  rotateX(PI/2);
  rotateY(frameCount*0.005);

  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }

  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]+300);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]+300);
    }
    endShape();
  }
  if ((frameCount <= 112)) {
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
