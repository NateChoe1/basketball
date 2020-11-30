double vectorToAngle(float x, float y) {
  double angle = PI * 3 / 2;
  if (x == 0) {
    if (y > 0) {
      angle = PI * 3 / 2;
    }
    if (y < 0) {
      angle = PI / 2;
    }
  }
  else {
    angle = Math.atan(y / x);
    angle += TWO_PI;
    if (x < 0) {
      angle += PI;
    }
    angle %= TWO_PI;
  }
  return angle;
}

class Ball {
  float x;
  float y;
  float xSpeed;
  float ySpeed;
  float gravity;
  color ballColor;
  
  Ball(color c, float xx, float yy, float xS, float yS) {
    x = xx;
    y = yy;
    xSpeed = xS;
    ySpeed = yS;
    gravity = 0.5;
    ballColor = c;
  }
  
  Ball(color c, float xx, float yy, float xS, float yS, float gg) {
    this(c, xx, yy, xS, yS);
    gravity = gg;
  }
  
  void draw() {
    if (y >= 800) ySpeed *= -1;
    ySpeed += gravity;
    fill(ballColor);
    noStroke();
    ellipse(x, y, 10, 10);
    Collider collided = colliding(x, y);
    if (collided != null) {
      double angle = vectorToAngle(xSpeed, ySpeed);
      double newAngle = collider.bounceAngle(x, y, angle);
      double energy = sqrt(pow(xSpeed, 2) + pow(ySpeed, 2));
      xSpeed = (float) (Math.cos(newAngle) * energy) * 0.8;
      ySpeed = (float) (Math.sin(newAngle) * energy) * 0.8;
    }
    x += xSpeed;
    y += ySpeed;
  }
}
