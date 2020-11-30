Collider colliding(float x, float y) {
  if (collider.colliding(x, y)) {
    return collider;
  }
  return null;
}

float pow(double n, int p) {
  float product = 1;
  for (int i = 0; i < p; i++) product *= n;
  return product;
}

float pow(float n, int p) {
  float product = 1;
  for (int i = 0; i < p; i++) product *= n;
  return product;
}

double min(double[] mins) {
  if (mins.length == 0) return 0;
  double min = mins[0];
  for (int i = 1; i < mins.length; i++) {
    if (mins[i] < min) min = mins[i];
  }
  return min;
}

double distance(float x1, float y1, float x2, float y2) {
  return sqrt(pow(x1-x2, 2) + pow(y1-y2, 2));
}

abstract class Collider {
  double bounceAngle(float x, float y, double strikeAngle) {return 0;}
  boolean colliding(float x, float y) {return false;}
  void draw() {}
}

class Line extends Collider {
  float x1,y1,x2,y2;
  Line(float x_1, float y_1, float x_2, float y_2) {
    x1 = x_1;
    y1 = y_1;
    x2 = x_2;
    y2 = y_2;
  }
  
  boolean colliding(float x, float y) {
    double dist = distance(x1, y1, x2, y2);
    double dist1 = distance(x, y, x1, y1);
    double dist2 = distance(x, y, x2, y2); 
    float a = acos((pow(dist2, 2) - pow(dist, 2) - pow(dist1, 2))/((float) (2*dist*dist1)));
    double dist3 = sin(a) * dist1;
    return min(new double[] {dist3}) <= 20;//This was a pain to put together, but it finally works. I hate trigonometry so much.
  }
  
  double bounceAngle(float x, float y, double strikeAngle) {
    double lineAngle = vectorToAngle(x2 - x1, y2 - y1);
    return strikeAngle * 2 - lineAngle;//In this form it makes no sense, it would really be lineAngle+(strikeAngle-lineAngle)+(strikeAngle-lineAngle)=strikeAngle * 2 - lineAngle.
  }
  
  void draw() {
    stroke(255);
    strokeWeight(5);
    line(x1, y1, x2, y2);
  }
}
