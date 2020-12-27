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
		float a1 = acos((pow(dist2, 2) - pow(dist, 2) - pow(dist1, 2))/((float) (2*dist*dist1)));
		double dist3 = sin(a1) * dist1;
		float a2 = acos((pow(dist1, 2) - pow(dist, 2) - pow(dist2, 2))/((float) (-2*dist*dist2)));
		if (a1 > PI/2 && a2 < PI/2) {
			return dist3 < 10;
		}
		return ((dist1 < dist2)? dist1:dist2) < 10;
	}
	
	double bounceAngle(float x, float y, double strikeAngle) {
		double lineAngle = vectorToAngle(x2 - x1, y2 - y1);
		return 2*strikeAngle	- lineAngle;//In this form it makes no sense, it would really be lineAngle+(strikeAngle-lineAngle)+(strikeAngle-lineAngle)=strikeAngle * 2 - lineAngle.
	}
	
	void draw() {
		stroke(255);
		strokeWeight(5);
		line(x1, y1, x2, y2);
	}
}
