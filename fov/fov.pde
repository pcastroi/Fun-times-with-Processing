public void setup() {
  size(1000, 500);
  smooth();
  noStroke();
  background(0);

  frameRate(12);
}
void draw() {
  
  background(255, 255, 255);
  for (float t = 0.0; t < 10.0; t= t+2.0){
    drawplane(t);
  }
  if(frameCount <= 120){
    TImage frame = new TImage(width,height,RGB,sketchPath("frame_"+nf(frameCount,3)+".png"));
    frame.set(0,0,get());
    frame.saveThreaded();
  }

}
void drawplane(float offset) {
  
  int center_x = mouseX;
  int center_y = mouseY;
  for (int i = 0; i < width; i = i+10) {
    for (int j = 0; j < height; j = j+10) {
      if((i == center_x) || (j == center_y)){
        stroke(0, 0, 0);
        point(center_x, center_y);
      }else{
        int m = (j - center_y)/(i - center_x);
        if ((i>center_x) && (j>center_y)){
          float x_o = i - offset*m;
          float y_o = j - offset*m;
          point(x_o, y_o);
        } else if ((i>center_x) && (j<center_y)){
          float x_o = i - offset*m;
          float y_o = j + offset*m;
          point(x_o, y_o);
        } else if ((i<center_x) && (j<center_y)){
          float x_o = i + offset*m;
          float y_o = j + offset*m;
          point(x_o, y_o);
        } else if ((i<center_x) && (j>center_y)){
          float x_o = i + offset*m;
          float y_o = j - offset*m;
          point(x_o, y_o);
        }
      }
    }
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
