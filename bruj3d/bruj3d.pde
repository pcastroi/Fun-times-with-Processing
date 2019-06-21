void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(100);
  stroke(0);
  translate(width/2, height/2);
  //strokeWeight(4);
  //fill(255);
  //ellipse(0, 0, 320, 320);
  //fill(100);
  //ellipse(0, 0, 200, 200);
  //noFill();
  //ellipse(0, 0, 237, 237);
  //ellipse(0, 0, 282, 282);
  //strokeWeight(1);
  //circtile(0, 0, 120, 140, 24);
  //bruj(0, 0, 0, 50, 120, 16);
  bruj(0, 0, 0, 30, 200, 4);
}
void bruj(float x, float y, float z, float radius1, float radius2, int numPoints) {
  float angle = TWO_PI/numPoints;
  float halfAngle = angle/2.0;
  fill(255);
  beginShape();
  for (float a = 0; a < TWO_PI; a+= angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    vertex(x, y);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  fill(0);
  beginShape();
  for (float a = 0; a < TWO_PI; a+= angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(x, y);
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void circtile(float x, float y, float radius1, float radius2, int numPoints) {
  float angle = TWO_PI/numPoints;
  int count = 0;
  beginShape(QUAD_STRIP);
  for (float a = -angle/2; a < TWO_PI-angle/2; a+= angle) {
    if (count%2==0) {
      fill(255);
    } else {
      fill(0);
    }
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    float ox = x + cos(a) * radius1;
    float oy = y + sin(a) * radius1;
    vertex(ox, oy);
    count++;
  }
  endShape();
}
