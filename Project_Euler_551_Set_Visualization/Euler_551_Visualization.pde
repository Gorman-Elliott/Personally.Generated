import java.lang.Math;
import processing.pdf.*;

int sizeX = 500;
int sizeY = 500;


void setup() {
  //size(1000, 500);
  fullScreen();
  beginRecord(PDF, "551.pdf");
  translate(width / 3, height / 3);
  background(#FDFD96);
  
  
  translate(0, 0);  
  run(5000);
  endRecord();
}

void draw() {
}


private int getSumOfDigits(int n) {
  int sum = 0;
  int exp = 1;

  while ((n / exp) > 0) {
   sum += (n / exp) % 10;
   exp *= 10;
  }
  
  return sum;  
}

private void run(int n) {
  int total = 1;
  for (int i = 0; i < n; i++) {
    
    int digitSum = getSumOfDigits(total);
    
    //Instead of displaying next total digit, display difference between this total and previous total
    int nextDigit = total + digitSum;
    int currentTotal = total;
    
    total += digitSum;
    
    
    
    int difference = Math.abs(nextDigit - currentTotal);
    displayNextNum(i, difference);
  }
}


private void displayNextNum(int x, int y) {
  stroke(#C28285);
  
  if (x > sizeX) {
    x = x - (((x / 1000) % 10) * 1000);
  }
  
  strokeWeight(3);
  point(x, y * 10);
}
