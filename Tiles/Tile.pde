public class Tile{
 private int side;
 private int r;
 private int g;
 private int b;
 private int x;
 private int y;
 
 public Tile(int a, int b, int s){
   x = a;
   y = b;
   side = s;
   r = 0;
   g = 0;
   this.b = 0;
 }
 public void show(){
   fill(255-r, 255-g, 255-b);
   rect(x, y, side, side);
   fill(r, g, b);
   ellipse(x+side/2, y+side/2, side, side);
 }
 public void changeColor(int red, int green, int blue){
   r = red;
   g = green;
   b = blue;
 }
 public void shiftColor(){
   if (random(0,1)<0.2){
     r+=random(-20, 20);
     b+=random(-20, 20);
   }
 }
}
