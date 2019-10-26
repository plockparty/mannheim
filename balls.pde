int numBalls = 30;
float spring = 0.05;
float gravity = 0.4;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];

void setupBalls() {
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(0,100), random(80, 100), i, balls);
  }
}

void drawBalls() {
  //background(0);
    image(edgeImage, 0, 0); // Draw the new image

  noStroke();
  fill(255, 204);
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();  
  }
}

class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
        diameter *= 0.9;
      }
    }
    for (int i = 0; i < quads.size(); i++) {
      int[] quad = quads.get(i);
      int right = Math.max(quad[2],quad[4]);
      int left = Math.min(quad[0],quad[6]);
      int top = Math.min(quad[1],quad[3]);
      int bottom = Math.max(quad[5],quad[7]);
      float radius = diameter /2;
      if(left < x + radius && right > x - radius) {
        // TOP
        if(y < top && y + radius >= top && vy > 0) {
          vy = -vy;
        diameter *= 0.9;
        }
        // BOTTOM
        if(y > bottom && y - radius <= bottom  && vy < 0) {
          vy = -vy;
        diameter *= 0.9;
        }
      }
      if(top < y - radius && bottom > y + radius ) {
        // LEFT
        if(x < left && x+radius >= left && vx > 0) {
          vx = -vx;
        diameter *= 0.9;
        }
        // RIGHT
        if(x > right && x-radius <= right && vx < 0) {
          vx = -vx;
        diameter *= 0.9;
        }
      }
    }
  }
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
              diameter *= 0.9;

    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
        diameter *= 0.9;

  }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
        diameter *= 0.9;

      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
        diameter *= 0.9;

  }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
    if(diameter < 30) {
      x = random(width);
      y = random(height);
      diameter = random(80, 100);
      vx=0;
      vy=0;
    }
  }
}
