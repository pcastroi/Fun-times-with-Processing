void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  fill(255);
  stroke(255);
  translate(width/2, height/2);
  bruj(200,20,8);
  bruj(130,20,32);

}
void bruj(int r1,int r2, int numPoints) {
  if (numPoints%2!=0) {
      numPoints++;
  }
  int radius = r1;
  float angle = TWO_PI/(float)numPoints;
  beginShape();
  for (int i=0; i<numPoints; i++) {
    vertex(radius*sin(angle*i), radius*cos(angle*i));
  }
  for (int i=0; i<4; i++)
  endShape(CLOSE);
}
