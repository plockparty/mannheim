
int animalNum = 30;
ArrayList<Animal> animals = new ArrayList<Animal>();

int animalLife = 10;


class Animal {
  
  PVector pos;
    int noiseScaleX = 400;
    int noiseScaleY = 800;
    int noiseScaleZ = int(random(100, 200));
    PVector vel = new PVector(0, 0);
    float life = random(maxLife);
    int count = int(random(1, 10));
    int c = int(random(255));
    int direction = getDirection(); 
  
  
  
  public Animal(int x, int y) {
    this.pos = new PVector(x, y);
  }

  public void update() {
    // let n = noise(this.pos.x / this.noiseScaleX, this.pos.y / this.noiseScaleY, frameCount / this.noiseScaleZ);
    float n = noise(this.pos.x / this.noiseScaleX, this.pos.y / this.noiseScaleY);
    //float n = noise(this.pos.x , this.pos.y);
    float angle = map(n, 0, 1, 0, 2*PI);
    //println(angle);
    //println(cos(angle));

    this.vel = new PVector(this.direction * cos(angle), this.direction * sin(angle));
    this.pos.add(this.vel);
    this.pos.x = constrain(this.pos.x, 0, width);
    this.pos.y = constrain(this.pos.y, 0, height);
    this.life -= random(0.01);
    this.life = constrain(this.life, 0, animalLife);
    //println(this.pos.toString());
  }

  public void display() {
    strokeWeight(map(this.life, 0, animalLife, 0, 200));
    //stroke(unhex(this.c)); // + "66"
    colorMode(HSB);
    stroke(this.c, 200, 255);
    point(this.pos.x, this.pos.y);
  }
}


void setupAnimals() {
  colorMode(HSB, 360, 100, 100, 100);
  //angleMode(DEGREES);

  //drawNoiseBackground(100000);
  // Don't draw background
  //int n = int(random(pallete.length));
  //String bg = pallete[n];
  //pallete.splice(n, 1);
  //offset = width / 10;
  
  for (int i = 0; i < animalNum; i++) {
    //int x = int(random(width));
    //int y = int(random(height));
    //movers.add(new Mover(x, y));
    initAnimalBehindWindow();
  }
  //background(bg);
}



void drawAnimals() {
  for ( int i = 0; i < animals.size(); i++) {
    Animal animal = animals.get(i);
    animal.update();
    animal.display();
    
    if(animal.life == 0){
      animals.remove(i);
    }
  }

  for ( int i = animals.size(); i < animalNum; i++) {
    //int angle = int(random(360));
    initAnimalBehindWindow();
  }
}

void initAnimalBehindWindow(){
  int[] quad = quads.get(int(random(quads.size())));
  int x = int(random(quad[0], quad[2]));
  int y = int(random(quad[1], quad[7]));
  animals.add(new Animal(x,y));
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
