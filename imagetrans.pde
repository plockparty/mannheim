/**
 * Explode 
 * by Daniel Shiffman. 
 * 
 * Mouse horizontal location controls breaking apart of image and 
 * Maps pixels from a 2D image into 3D space. Pixel brightness controls 
 * translation along z axis. 
 */

int imgcellsize = 20;// Dimensions of each cell in the grid
int imgcolumns, imgrows;   // Number of columns and rows in our system
float imgexplodeTime = 0;

void setupTrans() {
  imgcolumns = edgeImage.width / imgcellsize;  // Calculate # of columns
  imgrows = edgeImage.height / imgcellsize;  // Calculate # of rows
}

void drawTrans() {
  background(0);
  // Begin loop for columns
  for ( int i = 0; i < imgcolumns; i++) {
    // Begin loop for rows
    explodeTime +=0.1;
    for ( int j = 0; j < imgrows; j++) {
      int x = i*imgcellsize + imgcellsize/2;  // x position
      int y = j*imgcellsize + imgcellsize/2;  // y position
      int loc = x + y*edgeImage.width;  // Pixel array location
      color c = edgeImage.pixels[loc];  // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (explodeTime / float(width)) * brightness(edgeImage.pixels[loc]) - 20.0;
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x , y, z);
      //fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
}
