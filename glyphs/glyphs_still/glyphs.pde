import java.util.ArrayList;

void setup() {
  size(700, 700);
  background(255);
  
  stroke(0);
  Glyph agent = new Glyph(20);
  
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

      agent.render(); //draw
      popMatrix(); //revert back to original matrix for the row
    }
    resetX = 0; //set resetX back to 0 after completing a row
    iRunning *= -1;
    popMatrix();
  }
  
  //end drawing glyphs 
  popMatrix();
  translate(width/2, height/2);
  stroke(255);
  circle(0, 0, 250);
  stroke(0);
  circle(0, 0, 125);
  stroke(0);
  line(-width/2 + 10, 0, width/2 - 10, 0);
  circle(0, 0, 75);
  noFill();
  rect(10 - width/2, 10 - width / 2, width - 20, height - 20);
  
  
}


void draw() {
  frameRate(10);
  translate((width / 2) - 10, (height / 2) - 10);
  stroke(255);
  fill(255);
  rect(-5, -5, 30, 30); //this rect redraws the portion of the screen that should change)
  stroke(0);
  Glyph agent = new Glyph(20);
  agent.render();
  
}


class Glyph {
  
  //locations contains information only about sizing for pos
  //actual pos are calculated in render()
  float[] locations = {0, 0, 0, 0};
  int weight;
  int gWidth;
  
  
  private Glyph(int size) {
    this.gWidth = size;
    calPos(size);
    
    //calculate stroke weight based on size;
    this.weight = size / 15;
    
  }
  
  //float size: in pixels
  public void render() {
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
