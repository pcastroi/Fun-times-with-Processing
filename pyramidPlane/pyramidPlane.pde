int MAX_OFF = 300;


void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(0);
  translate(127, 185, 100-(frameCount*0.5));
  //rotateZ(frameCount*0.01);
  //rotateY(frameCount*0.01);

  rotateX(1);
  stroke(255);
  noFill();
  Pyramid(0, 0, 0, 250);
  //  if ((frameCount > 250) && (frameCount <= 1000)) {
  //    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
  //    frame.set(0, 0, get());
  //    frame.saveThreaded();
  //  }
}

int colorFromOffset(int offset) {
  return (int) ((offset + MAX_OFF) / (1.8 * MAX_OFF) * 255);
}

void Pyramid(int x, int y, int z, int basePoints) {
  int f=0;
  for (int k=z; k<(basePoints+z); k=k+5) {
    beginShape();
    for (int j=y+f; j<(basePoints+y) - f; j=j+5) {
      for (int i=x+f; i<(basePoints+x) - f; i=i+5) {
        if (((i==x+f) && (j==y+f)) || ((i==(basePoints+x) - f - 5) && (j==y+f))) {
          println("entro al if 1");
          vertex(i, j, k);
        }
        if (((i==x+f) && (j==(basePoints+y) - f - 5))) {
          println("entro al if 2");
          vertex(i, j, k);
        }
        if ((i==(basePoints+x) - f - 5) && (j==(basePoints+y) - f - 5)) {
          println("Maximo en i y j");
          vertex(i, j, k);
        }
      }
      endShape(CLOSE);
    }
    f=f+5;
  }
}
//class TImage extends PImage implements Runnable { //separate thread for saving images
//  String filename;

//  TImage(int w, int h, int format, String filename) {
//    this.filename = filename;
//    init(w, h, format);
//  }

//  public void saveThreaded() {
//    new Thread(this).start();
//  }

//  public void run() {
//    this.save(filename);
//  }
//}
