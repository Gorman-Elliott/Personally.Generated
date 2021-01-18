import java.lang.Math;
import processing.pdf.*;

void setup() {
  size(1000, 1000);
  //beginRecord(PDF, "minimal.pdf");
  //fullScreen();
  background(#FFB6C1);
  int allowableSizeX = (width / 100) - 1;
  int allowableSizeY = (height / 100) - 2;
  
  translate(80, 80);

  int iRunning = -1;
  int resetX = 0;
  for (int i = 0; i <= allowableSizeY; i++) {
    pushMatrix();
    for (int j = 1; j <= allowableSizeX; j++) {
      if (iRunning == 1) {
        translate(0, i*100);
        iRunning*= -1;
      }
      
      //push matrix to save information before swapping to next column
      // need to push matrix AFTER translating on y-axis to save position to new y
      // as new rows are created
      pushMatrix();
      
      //go to new column position
      if (iRunning == -1) {
        translate(resetX*100, 0);
      }
      resetX += 1; //inc resetX while generating a row

      scape();
      popMatrix(); //revert back to original matrix for the row
    }
    resetX = 0; //set resetX back to 0 after completing a row
    iRunning *= -1;
    popMatrix();
  }

  //endRecord();
}

// TODO
// Determine how many 50x50 squares the width of the screen can hold
// from this we can determine scale so if the screen size changes, scape() will too
private void scape() {
  
  //each scape is confined to a 50x50 pixel area
  //start in middle
  //translate(25, 25);
  
  //create variables that determine what type of combination this scape will have
  // variables 0 or 1, determined randomly, the image will always have lines
  
  int hasStraightLines = 1;
  int hasCircles = 1;
  int hasCurvyLines = 1;
  int hasPyramid = 1;
  
  //check if current run has the properties, if so, draw them
  // ...
  // ...
  // ...
  
  //push Matrix to revert back to original 50x50 square
  pushMatrix(); 
  if (hasStraightLines == 1) {
    //determine # lines and starting position
    int numLines = (int) random(2, 7);  
    int ranStartx = (int) random(1, 51);
    int ranStarty = (int) random(1, 51);
    int trackingX = ranStartx;
    int trackingY = ranStarty;
    translate(ranStartx, ranStarty);
    
    for (int i = 0; i < numLines; i++) {
      //determine current line properties
      // length and rotation are determined everytime to check if they reside in the 50x50 square
      int length;
      int rotation;
      float thickness = (int) random(1, 2);
      
      //calculate next line location if it continues to reside in the original 50x50 square
      // calculates based on current 0,0 as translations occur
      int nextX = 0;
      int nextY = 0;
      do {
        length = (int) random(10, 40);
        rotation = (int) random (30, 121); // 30 to 121 for truncation to int
        nextX = toCartesianX(length, rotation);
        nextY = toCartesianY(length, rotation);
      } while((trackingX + nextX) > 50 || (trackingX + nextX) < 0 || (trackingY + nextY) > 50 || (trackingY + nextY) < 0);
      trackingX += nextX; //track new x location for next iteration
      trackingY += nextY; //track new y location for next iteration
      
      
      //draw point and then next line
      stroke(0);
      strokeWeight(thickness + 3); // give point greater thickness than line
      point(0, 0);
      strokeWeight(thickness);
      line(0, 0, nextX, nextY);
      
      //translate to new position
      translate(nextX, nextY);
    }
  }
  popMatrix(); // pop back to original -- hasStraightLines
  
  if (hasCircles == 1) {
    //set stroke settings for circle
    stroke(0);
    strokeWeight(1);
    
    //circle Radii
    float r = 4;
    //determine number of circles and draw them randomly in 50x50 square
    int numCircles = (int) random(1, 5);
    for (int i = 0; i < numCircles; i++) {
      int circleX = (int) random(3, 48);
      int circleY = (int) random(3, 48);
      circle(circleX, circleY, r);
    }
  }
  
  if (hasCurvyLines == 1) {
    
  }
  
  if (hasPyramid == 1) {
    //stroke
    strokeWeight(1);
    
    final int MAX_LINES = 10;
    
    //determine starting location of first line
    int x0 = (int) random(2, 50);
    int y0 = (int) random(2, 50);
    
    //determine direction
    float dir = 0;
    if (x0 > 25 && y0 > 25) {
      dir = random(90, 180);
    }
    else if (x0 < 25 && y0 < 25) {
      dir = random(-90, 0); //choose negative so as to avoid going up or to the left
    }
    else if (x0 > 25 && y0 < 25) {
      dir = random(-180, -90);
    }
    else if (x0 < 25 && y0 > 25) {
      dir = random(0, 90);
    }
    
    //determine length of init line
    int startingLength = (int) random(1, 5);
    
    //while length is > 3 draw lines
    float nextLength = startingLength;
    for (int i = MAX_LINES; i >= 0; i--) {
      //draw lines in dir
      line(x0+10-(i*5), y0+10-(i*5), toCartesianX(nextLength+10-(i*5), dir), toCartesianY(nextLength+10-(i*5), dir));
      nextLength = nextLength * 0.99; //decrement
    }
    
  }
  
}

private int ranBool() {
  float rand = random(0, 1);
  if (rand > 0.5) {
    return (int) Math.ceil(rand);
  } else {
    return (int) rand;
  }
}

private int toCartesianX(double r, double theta) {
  double fin = r * Math.cos(theta);
  return (int) fin;
}

private int toCartesianX(float r, float theta) {
  double fin = r * Math.cos(theta);
  return (int) fin;
}

private int toCartesianY(double r, double theta) {
 double fin = r * Math.sin(theta); 
 return (int) fin;
}

private int toCartesianY(float r, float theta) {
 double fin = r * Math.sin(theta); 
 return (int) fin;
}
