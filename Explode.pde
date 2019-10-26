/**
 * Explode 
 * by Daniel Shiffman. 
 * 
 * Mouse horizontal location controls breaking apart of image and 
 * Maps pixels from a 2D image into 3D space. Pixel brightness controls 
 * translation along z axis. 
 */

int cellsize = 1;// Dimensions of each cell in the grid
int columns, rows;   // Number of columns and rows in our system
float explodeTime = 0;

int width_per_frame = 300;
int height_per_frame = 400;

int current_width = 0;
int current_height = 0;

void setupExplode() {
    image(img, 0, 0); // Draw the new image

}



void drawExplode() {
  // Begin loop for columns
  background(0);
  float w_center =  img.width/2;
  float h_center =  img.height/2;
  explodeTime +=0.01;
  //for ( int i = current_width; i < Math.min(current_width + width_per_frame, img.width); i++) {
  for ( int i = 0; i < img.width; i++) {
    // Begin loop for rows
    //for ( int j = current_height; j < Math.min(current_height + height_per_frame, img.height); j++) {
    for ( int j = 0; j < img.height; j++) {
      int loc = i + j*img.width;  // Pixel array location
      color c = img.pixels[loc];  // Grab the color
      float z = (explodeTime) * brightness(img.pixels[loc]) - 20.0;
      pushMatrix();
      translate(i, j , z);
      fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();

    }
  }
  current_width = (int) random(img.width);
  current_height = (int) random(img.height);
  
}
