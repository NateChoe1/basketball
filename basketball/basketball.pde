Ball ball;
Collider collider;

void setup() {
  size(1000, 1000);
  ball = new Ball(color(255), 20, 500, 3, 0);
  collider = new Line(400, 600, 800, 500);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(5);
  line(0, 800, 1000, 800);
  ball.draw();
  collider.draw();
}
