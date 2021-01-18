import java.lang.Math;

float noiseSeed = 0.1;
float phase = 1;
float rotation = 70;
float noiseMax = 2.5;
int shapes = 50;
int startTime;
boolean wait = false;
boolean flag = false;

int green = #00E571;
int grad2 = #33CC7E;
int grad3 = #55B38B;
int grad4 = #999A99;
int grad5 = #CC81A6;
int pink = #FF68B4;

int[] colors = {grad2, grad3, grad4, grad5, pink};

void setup() {
  size(1000, 1000, P2D);
  startTime = millis();
  
  background(0);
  translate(width / 2, height / 2);
  noFill();
  /*
  for (int i = 0; i < shapes; i++) {
    beginShape();
    for (float a = 0; a < TWO_PI; a+= 0.05) {
      float xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
      float yoff = map(sin(a+phase), -1, 1, 0, noiseMax);

      float r = map(noise(xoff, yoff), 0, 1, 25, 250);
      float x = r * tan(a);
      float y = r * sin(a);
      curveVertex(x + (i*1), y + (i*1));
    }
    
    stroke(255, 80);
    if (currentColor == 5) {
     currentColor = 0; 
    } else {
     currentColor++; 
    }
    
    endShape(); 
    rotate(rotation);
  }
  */
}

int currentColor = 0;


void draw() {
  background(0);
  translate(width / 2, height / 2);
  noFill();
  strokeWeight(2);
  
  for (int i = 0; i < shapes; i++) {
    beginShape();
    for (float a = 0; a < TWO_PI; a+= 0.05) {
      float xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
      float yoff = map(sin(a+phase), -1, 1, 0, noiseMax);

      float r = map(noise(xoff, yoff), 0, 1, 25, 250);
      float x = r * tan(a);
      float y = r * sin(a);
      curveVertex(x + (i*1), y + (i*1));
    }
    
    stroke(255, 75);
    if (currentColor == 4) {
     currentColor = 0; 
    } else {
     currentColor++; 
    }
    
    endShape(); 
    rotate(rotation);
  }

  phase += 0.01;
  
      
  if (wait && !flag) {
    //do nothing
    if (Math.abs(startTime - millis()) > 20000) {
      wait = false;
      startTime = millis();
      rotation = (float) Math.ceil(rotation) + 0.6; // +0.6 to offset rotation += 0.5
      flag = true;
    }
    rotation += 0.0001;
  }
  if (!wait) {
    //rotate
    rotation += 0.5; 
    //System.out.println(rotation);
    //tick time and check for reset
    if ((int) ((rotation - 10) % 10) == 0) {
      wait = true;
    }
  }
  
  if (flag) {
     //saveFrame("output/perlin-####.png");
  }
}
