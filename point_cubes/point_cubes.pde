int MAX_OFF = 500;

void setup() {
  size(500, 500, P3D);
  smooth();
}

void draw() {
  background(0);
  translate(width/2, height/2, -MAX_OFF*2.5);
  rotateX(frameCount * .01);
  rotateY(frameCount * .01);
  rotateZ(frameCount * .001);



  for (int xo = -MAX_OFF; xo <= MAX_OFF; xo += 50) {
    for (int yo = -MAX_OFF; yo <= MAX_OFF; yo += 50) {
      for (int zo = -MAX_OFF; zo <= MAX_OFF; zo += 50) {
        pushMatrix();
        translate(xo, yo, zo);
        stroke(255);
        point(xo, yo, zo);
        //line(xo, yo, zo, xo+50, yo, zo);        
        //line(xo, yo, zo, xo, yo+50, zo);
        //line(xo, yo, zo, xo, yo, zo+50);
        //line(xo, yo, zo, xo-50, yo, zo);        
        //line(xo, yo, zo, xo, yo-50, zo);
        //line(xo, yo, zo, xo, yo, zo-50);
        popMatrix();
      }
    }
  }

  if ((frameCount <= 200)) {
    TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
    frame.set(0, 0, get());
    frame.saveThreaded();
  }
}

class TImage extends PImage implements Runnable{ //separate thread for saving images
  String filename;

  TImage(int w,int h,int format,String filename){
    this.filename = filename;
    init(w,h,format);
  }

  public void saveThreaded(){
    new Thread(this).start();
  }

  public void run(){
    this.save(filename);
  }
}
