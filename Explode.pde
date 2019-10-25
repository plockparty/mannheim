/**
 * Explode 
 * by Daniel Shiffman. 
 * 
 * Mouse horizontal location controls breaking apart of image and 
 * Maps pixels from a 2D image into 3D space. Pixel brightness controls 
 * translation along z axis. 
 */

int cellsize = 20;// Dimensions of each cell in the grid
int columns, rows;   // Number of columns and rows in our system
float explodeTime = 0;
void setupExplode() {
  columns = edgeImage.width / cellsize;  // Calculate # of columns
  rows = edgeImage.height / cellsize;  // Calculate # of rows
}

void drawExplode() {
  background(0);
  // Begin loop for columns
  for ( int i = 0; i < columns; i++) {
    // Begin loop for rows
    explodeTime +=0.1;
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  // x position
      int y = j*cellsize + cellsize/2;  // y position
      int loc = x + y*edgeImage.width;  // Pixel array location
      color c = edgeImage.pixels[loc];  // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (explodeTime / float(width)) * brightness(edgeImage.pixels[loc]) - 20.0;
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x , y, z);
      fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
}
