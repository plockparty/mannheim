String[] pallete = {"DADCDA", "DE200C", "3A6DA8", "A8BACC", "0A1D4E", "CD4645", "C0AEB5", "838CA9"};

int num = 10000;
ArrayList<Mover> movers = new ArrayList<Mover>();


class Mover {
  
  PVector pos;
    int noiseScaleX = 400;
    int noiseScaleY = 800;
    int noiseScaleZ = int(random(100, 200));
    PVector vel = new PVector(0, 0);
    float life = random(1);
    int count = int(random(1, 10));
    String c = pallete[int(random(pallete.length))];
  
  
  public Mover(int x, int y) {
    this.pos = new PVector(x, y);
  }

  public void update() {
    // let n = noise(this.pos.x / this.noiseScaleX, this.pos.y / this.noiseScaleY, frameCount / this.noiseScaleZ);
    float n = noise(this.pos.x / this.noiseScaleX, this.pos.y / this.noiseScaleY);
    float angle = map(n, 0, 1, 0, 2*PI);
    this.vel = new PVector(cos(angle), sin(angle));
    this.pos.add(this.vel);
    this.pos.x = constrain(this.pos.x, 0, width);
    this.pos.y = constrain(this.pos.y, 0, height);
    this.life -= random(0.01);
    this.life = constrain(this.life, 0, 1);
    //println(this.pos.toString());
  }

  public void display() {
    strokeWeight(map(this.life, 0, 1, 0, 5));
    //stroke(unhex(this.c)); // + "66"
    stroke(255, 255, 255);
    point(this.pos.x, this.pos.y);
  }
}


void setupMovers() {
  colorMode(HSB, 360, 100, 100, 100);
  //angleMode(DEGREES);

  //drawNoiseBackground(100000);
  // Don't draw background
  //int n = int(random(pallete.length));
  //String bg = pallete[n];
  //pallete.splice(n, 1);
  //offset = width / 10;
  
  for (int i = 0; i < num; i++) {
    int x = int(random(width));
    int y = int(random(height));
    movers.add(new Mover(x, y));
  }
  //background(bg);
}

void drawMovers() {
  for ( int i = 0; i < movers.size(); i++) {
    Mover mover = movers.get(i);
    mover.update();
    mover.display();
    if(mover.life == 0){
      movers.remove(i);
    }
  }

  for ( int i = movers.size(); i < num; i++) {
    int angle = int(random(360));
    int x = int(random(width));
    int y = int(random(height));
    movers.add(new Mover(x, y));
  }
}


//function drawNoiseBackground(_n, _graphics) {
//  let c = color(0, 0, 0, 0.2);
//  for (let i = 0; i < _n; i++) {
//    let x = random(1) * width;
//    let y = random(1) * height;
//    let w = random(1, 3);
//    let h = random(1, 3);
//    _graphics.noStroke();
//    _graphics.fill(c);
//    _graphics.ellipse(x, y, w, h);
//  }
//}
