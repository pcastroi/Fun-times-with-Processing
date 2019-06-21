int MAX_OFF = 300;

void setup() {
  size(500, 500, P3D);
  smooth();
}

void draw() {
  background(0);
  translate(width/2, height/2, -MAX_OFF * 2);
  rotateX(frameCount * .01);
  rotateY(frameCount * .01);
  rotateZ(frameCount * .01);

  for (int xo = -MAX_OFF; xo <= MAX_OFF; xo += 50) {
    for (int yo = -MAX_OFF; yo <= MAX_OFF; yo += 50) {
      for (int zo = -MAX_OFF; zo <= MAX_OFF; zo += 50) {
        pushMatrix();
        translate(xo, yo, zo);
        rotateX(frameCount * .02);
        rotateY(frameCount * .02);
        rotateZ(frameCount * .02);
        fill(colorFromOffset(xo),colorFromOffset(yo),colorFromOffset(zo));
        box((float) (20 + (Math.sin(frameCount / 20.0)) * 15));
        popMatrix();
      }
    }
  }
  
  if((frameCount <= 180)){
    TImage frame = new TImage(width,height,RGB,sketchPath("frame_"+nf(frameCount,3)+".png"));
    frame.set(0,0,get());
    frame.saveThreaded();
  }
}

int colorFromOffset(int offset) {
  return (int) ((offset + MAX_OFF) / (1.8 * MAX_OFF) * 255);
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
