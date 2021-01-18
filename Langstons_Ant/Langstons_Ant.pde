
int[][] grid;
int antX = 150;
int antY = 150;

final int ANTUP = 0;
final int ANTRIGHT = 1;
final int ANTDOWN = 2;
final int ANTLEFT = 3;

int antDir = 0;

void setup() {
 size(300, 300);
 grid = new int[width][height];
}

void draw() {
    
   for (int i = 0; i < 20; i++) {
     
   //black square is 1
   //white square is 0
     if (grid[antX][antY] == 0) {
       grid[antX][antY] = 1;
       
       switch (antDir) {
         case 0: 
           antDir = ANTRIGHT;
           antX++;
           break;
         case 1:
           antDir = ANTDOWN;
           antY--;
           break;
         case 2:
           antDir = ANTLEFT;
           antX--;
           break;
         case 3:
           antDir = ANTUP;
           antY++;
           break;
       }
       
       stroke(255);
       point(antX, antY);  
   }
     
     if (grid[antX][antY] == 1) {
       grid[antX][antY] = 0;
       
       switch (antDir) {
         case 0: 
           antDir = ANTLEFT;
           antX--;
           break;
         case 1:
           antDir = ANTUP;
           antY++;
           break;
         case 2:
           antDir = ANTRIGHT;
           antX++;
           break;
         case 3:
           antDir = ANTDOWN;
           antY--;
           break;
       }
       
       stroke(0);
       point(antX, antY);  
     }
   }
 }

  
  
