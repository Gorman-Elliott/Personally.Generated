import java.util.List;
import java.lang.Math;
import processing.pdf.*;

final int pink = #FFB5E8;
final int sky = #FFABAB;
final int mint = #AFF8DB;
final int purple = #97A2FF;
final int numCircles = 300;

final int[] leftPalette = {pink, sky};
final int[] rightPalette = {mint, purple};
final int[] fullPalette = {pink, sky, mint, purple};

int changeSpeed = 0;
int startTime;

ObjectGroup circles = new ObjectGroup();


private int pickColor() {
  return fullPalette[(int) random(4)];
}

void setup() {
  size(1920, 1080, P2D);
  
  //record pdf
  //beginRecord(PDF, "flow.pdf");
  startTime = second();
  
  
  background(0);
  int spawnWidth = 1220;
  int circleSteps = (spawnWidth / numCircles);
  for (int i = 1; i <= numCircles; i++) {
    Circle test = new  Circle(spawnWidth - (i * circleSteps), height / 2);
    circles.add(test);
  }
  
}


void draw() {

  for (int i = 0; i < circles.size(); i++) {
    Circle currentCircle = circles.get(i);
    int currentCircleX = currentCircle.getCenter()[0];
    int currentCircleY = currentCircle.getCenter()[1];
    
    ArrayList collisions = circles.groupCollide(currentCircle, circles);
    
    for (int j = 0; j < collisions.size(); j++) {
      Circle collidedCircle = (Circle) collisions.get(j);
      stroke(pickColor(), 20);
      line(currentCircleX, currentCircleY, collidedCircle.getCenter()[0], collidedCircle.getCenter()[1]);
    }

   
   //check if speed should be updated
   if (changeSpeed % 20 == 0) {
     circles.get(i).changeSpeed();
   }
  
   //update circle positions
   circles.get(i).update(); 
  }
  
  changeSpeed += 1;
  
  
  //catch recording of pdf after x number of seconds
  if (Math.abs(startTime - second()) > 15) {
   //endRecord();
   exit();
  }
  
}

class ObjectGroup {

  private List array = new ArrayList();

  private void add(Circle object) {
    array.add(object);
  }
  
  public Circle get(int index) {
   return (Circle) array.get(index); 
  }
  
  public int size() {
    return array.size();
  }
  
  
  //returns the group of circles that have collided with an object
  public ArrayList groupCollide(Circle object, ObjectGroup group) {
    
    ArrayList<Circle> collided = new ArrayList<Circle>();
    
    for (int i = 0; i < group.size(); i++) {
      int dx = Math.abs(group.get(i).getCenter()[0] - object.getCenter()[0]);
      int dy = Math.abs(group.get(i).getCenter()[1] - object.getCenter()[1]);
      double distance = Math.sqrt(dx * dx + dy * dy);
      
      if (distance == 0) {
        break; 
      }
      
      if (distance < object.getRadius()) { //<>//
        collided.add(group.get(i));
      }
    }
    
    return collided;

  }
  
  
  
}

class Circle {
  
  private int x = 0;
  private int y = 0;
  private int r = 60;
  private int ySpeed = (int) random(-10, 10);
  private int xSpeed;
  public int[] center = {0, 0};

  private Circle(int x, int y) {
    this.x = x;
    this.y = y;
    
    this.xSpeed = xSpeed();
  }
  
  private int xSpeed() {
    //if spawn x is on the left side of screen, move left
    if (this.x < width / 2) {
      return (int) random(-4, -1);
    } else {
     return (int) random(1, 4); 
    }
  }

  public void display() {
    noFill();
    circle(this.x, this.y, this.r);
  }
  
  public int getRadius() {
   return r; 
  }

  
  public void update() {
    this.y += ySpeed;
    this.x += xSpeed;
    
    //Capture center
    center[0] = this.x;
    center[1] = this.y;
    
    noFill();
    noStroke();
    circle(this.x, this.y, r);
  }
  
  public int[] getCenter() {
    return center;
  }
  
  public void changeSpeed() {
   ySpeed = (int) random(-10, 10); 
  }
}
