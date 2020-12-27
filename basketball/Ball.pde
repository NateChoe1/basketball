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
	int collisionCooldown;
	
	Ball(color c, float xx, float yy, float xS, float yS) {
		x = xx;
		y = yy;
		xSpeed = xS;
		ySpeed = yS;
		gravity = 0.025;
		ballColor = c;
		collisionCooldown = 0;
	}
	
	Ball(color c, float xx, float yy, float xS, float yS, float gg) {
		this(c, xx, yy, xS, yS);
		gravity = gg;
	}
	
	void draw() {
		fill(ballColor);
		noStroke();
		ellipse(x, y, 10, 10);
		Collider collided = colliding(x, y);
		if (collided != null && collisionCooldown == 0) {
			double angle = vectorToAngle(xSpeed, ySpeed);
			double newAngle = (collider.bounceAngle(x, y, angle) + TWO_PI) % TWO_PI;
			println(angle + " " + newAngle);
			double energy = sqrt(pow(xSpeed, 2) + pow(ySpeed, 2));
			ySpeed = (float) (Math.cos(newAngle) * energy) * 0.8;
			xSpeed = (float) (Math.sin(newAngle) * energy) * 0.8;
			collisionCooldown = 2;
		}
		collisionCooldown = max(collisionCooldown - 1, 0);
		x += xSpeed;
		y += ySpeed;
		if (y >= 800) ySpeed *= -1;
		ySpeed += gravity;
	}
}
