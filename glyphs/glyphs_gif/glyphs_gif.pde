import java.util.ArrayList;
import java.lang.Math;

ArrayList agents = new ArrayList<Glyph>();

void setup() {
  size(1000, 1000);
  background(0);
  
  stroke(255);
  
  pushMatrix();
  //draw glyphs
  int maxWidth = 20;
  int spacing = 30;
  translate(spacing/2, spacing/2);
  int allowableSizeX = (width / (spacing+maxWidth));
  int allowableSizeY = (height / (spacing+maxWidth));


  int iRunning = -1;
  int resetX = 0;
  for (int i = 0; i <= allowableSizeY; i++) {
    pushMatrix();
    for (int j = 1; j <= allowableSizeX; j++) {
      if (iRunning == 1) {
        translate(0, i*spacing + i*maxWidth);
        iRunning*= -1;
      }
      
      //push matrix to save information before swapping to next column
      // need to push matrix AFTER translating on y-axis to save position to new y
      // as new rows are created
      pushMatrix();
      
      //go to new column position
      if (iRunning == -1) {
        translate(resetX*(spacing+maxWidth), 0);
      }
      resetX += 1; //inc resetX while generating a row

      Glyph agent = new Glyph(20);
      agent.render(); //draw
      agent.updatePos(15+(resetX*(spacing+maxWidth)), 15+ (i*spacing + i*maxWidth));
      agents.add(agent);
      popMatrix(); //revert back to original matrix for the row
    }
    resetX = 0; //set resetX back to 0 after completing a row
    iRunning *= -1;
    popMatrix();
  }
  
  //end drawing glyphs 
  popMatrix();
  
}


float phase = 0;
void draw() {
  //frameRate(60);
  
  for (int i = 0; i < 4; i++) {
    Glyph temp = (Glyph) agents.get((int) random(0, agents.size()));
    stroke(0);
    fill(0);
    rect(temp.xPos-2, temp.yPos-2, 25, 25);
    stroke(255);
    temp.render();
  }
  
  //Draw extra stuff to make it look fancy
  translate(width/2, height/2);
  stroke(0);
  //circle(0, 0, 350);
  pushMatrix();
  rotate(-phase);
  quad(0, -450, 175, 0, 0, 450, -175, 0);
  popMatrix();
  stroke(255);
  circle(0, 0, 125);
  stroke(255);
  line(-width/2 + 10, 0, width/2 - 10, 0);
  pushMatrix(); // push to only rotate center diamond
  rotate(phase);
  quad(0, -75, 29, 0, 0, 75, -29, 0);
  circle(-62, 0, map(noise(phase*10), 0, 1, 5, 10));
  circle(62, 0, map(noise(phase*10), 0, 1, 5, 10));
  popMatrix();
  noFill();
  rect(10 - width/2, 10 - width / 2, width - 20, height - 20);
  
  //draw corner triangles
  // already translated to center
  fill(255);
  triangle((width/2) - 10, -(height/2) + 10, (width/2) - 65, -(height/2) + 10, (width/2) - 10, -(height/2)+65);
  triangle((width/2) - 10, (height/2) - 10, (width/2) - 65, (height/2) - 10, (width/2) - 10, (height/2)-65);
  triangle(-(width/2) + 10, -(height/2) + 10, -(width/2) + 65, -(height/2) + 10, -(width/2) + 10, -(height/2)+65);
  triangle(-(width/2) + 10, (height/2) - 10, -(width/2) + 65, (height/2) - 10, -(width/2) + 10, (height/2)-65);
  
  //draw center glyph
  circle(0, 0, map(noise(phase*10), 0, 1, 15, 30));
  /*
  pushMatrix();
  translate(-10, -10);
  stroke(0);
  fill(0);
  rect(-5, -5, 30, 30); //this rect redraws the portion of the screen that should change)
  stroke(255);
  Glyph agent = new Glyph(20);
  agent.render();
  popMatrix();
  */
  
  phase += 0.01;
  
  
  //saveFrame("output/glyphs-####.png"); //save photos!
}


class Glyph {
  
  //locations contains information only about sizing for pos
  //actual pos are calculated in render()
  float[] locations = {0, 0, 0, 0};
  int weight;
  int gWidth;
  public int xPos;
  public int yPos;
  
  
  private Glyph(int size) {
    this.gWidth = size;
    calPos(size);
    
    //calculate stroke weight based on size;
    this.weight = size / 15;
    
  }
  
  //float size: in pixels
  public void render() {
    pushMatrix();
    translate(xPos, yPos);
    //decide number of lines to draw
    int numLines = (int) random(3, 6);
    
    //draw lines from random points in the 9 point square
    strokeWeight(this.weight);
    float previousx = 0;
    float previousy = 0;
    for (int i = 0; i < numLines; i++) {
      //determine x and y start
      float xs = 0;
      float ys = 0;
      float xf = 0;
      float yf = 0;
      do {
        xs = locations[(int) random(0, locations.length)];
        ys = locations[(int) random(0, locations.length)];
        xf = locations[(int) random(0, locations.length)];
        yf = locations[(int) random(0, locations.length)]; 
      } while ((xs != previousx) && (ys != previousy));
      
      previousx = xf;
      previousx = yf;
      
      line(xs, ys, xf, yf);
    }
    
   popMatrix(); //don't fuck anything up is what this is for
  }
  
  public void updatePos(int xPos, int yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  //calculate positions and set them
  //yes, I hate that I did it this way too
  private void calPos(int size) {
    this.locations[0] = 0;
    this.locations[1] = size / 2;
    this.locations[2] = size / 4;
    this.locations[3] = size;
  }
  
}
