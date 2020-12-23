/*
    Basketball, a 2D physics simulator.
    Copyright (C) 2020  Nathaniel Choe

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

Ball ball;
Collider collider;

int startX;
int startY;

void setup() {
  size(1000, 1000);
  ball = new Ball(color(255), 20, 400, 1, 0);
  collider = new Line(500, 600, 800, 500);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(5);
  line(0, 800, 1000, 800);
  for (int i = 0; i < 3; i++) {
    ball.draw();
    collider.draw();
  }
}

void mousePressed() {
  startX = mouseX;
  startY = mouseY;
}

void mouseReleased() {
  ball = new Ball(color(255), startX, startY, (mouseX - startX) / 20, (mouseY - startY) / 20);
}
