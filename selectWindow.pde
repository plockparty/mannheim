
int undoX = 10;
int undoY = 10;      // Position of square button
int saveX = 200;
int saveY = 10;      // Position of square button

int undoSize = 90;     // Diameter of rect
int saveSize = 90;     // Diameter of rect

int rectColor;

boolean delete = false;

//PImage img;

ArrayList quads = new ArrayList<int[]>();

ArrayList current = new ArrayList<Integer>();

PImage edgeImage;

//int width = 3574;
//int height = 2273;

void setup() {
  size(3574, 2273);
  //img = loadImage("../haus.jpg"); // Load the original image
  rectColor = color(0);
  quads = loadQuads();
  //frameRate(1);
  //image(img,0,0);
  edgeImage = drawBackground();
    image(edgeImage, 0, 0); // Draw the new image

  setupMovers();
}

void draw() {
  
  drawMovers();
  // Draw the buttons
  stroke(255);
  fill(255);
  rect(saveX, saveY, saveSize, saveSize);
  if(delete) {
  fill(50);
  }
  rect(undoX, undoY, undoSize, undoSize);
  fill(0);
  text("undo", 10, 50);
  text("save", 200, 50);

  stroke(0);
  
  for (int i = quads.size() - 1; i >= 0; i--) {
    int[] q = (int []) quads.get(i);
    quad(q[0],q[1],q[2],q[3],q[4],q[5],q[6],q[7]);
  }  
}


void mousePressed() {
  if(overRect(undoX, undoY, undoSize, undoSize)) {
    delete = !delete;
  }
  else if(overRect(saveX, saveY, saveSize, saveSize)) {
    saveQuads(this.quads);
  }
  else if (delete) {
    System.out.println("TRying to delete");
    for(int i = 0; i <  quads.size(); i++){
        if(overQuad((int[]) quads.get(i))){
          quads.remove(i);
        }
    }
  }
  else {
      current.add(new Integer(mouseX));
      current.add(new Integer(mouseY));
    if(current.size() == 8){
      int[] newQuad = convertIntegers(current);
      quads.add(newQuad);
      current = new ArrayList();
    }
  }
}

public static int[] convertIntegers(ArrayList<Integer> integers)
{
    int[] ret = new int[integers.size()];
    for (int i=0; i < ret.length; i++)
    {
        ret[i] = integers.get(i).intValue();
    }
    return ret;
}

//NOTE this is not very good, it is a very rough approximation which will only work if the rectangle is drawn clockwise
boolean overQuad(int[] quad) {
  System.out.println(mouseX);
  System.out.println(mouseY);
  System.out.println(quad[0]);
  System.out.println(quad[2]);
  System.out.println(quad[1]);
  System.out.println(mouseX >= quad[0] && mouseX <= quad[2]
    && mouseY>= quad[1] && mouseY <= quad[7]);

  return mouseX >= quad[0] && mouseX <= quad[2]
    && mouseY>= quad[1] && mouseY <= quad[7];
}


boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
