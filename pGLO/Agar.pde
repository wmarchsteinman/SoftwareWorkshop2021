class Agar{
  int x, y, r;
  int food;
  Agar(int x, int y, int r){
    this.x = x;
    this.y = y;
    this.r = r;
    food = r*r;
  }
  void show(){
    fill(200, 220, 50, 150);
    ellipse(x, y, r*2, r*2);
  }
}