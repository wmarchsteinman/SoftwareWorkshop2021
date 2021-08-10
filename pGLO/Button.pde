class Button{
  int x, y, r, g, b, w, h;
  boolean clicked = false;
  String label;
  Button(int x, int y, int r, int g, int b, String label){
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
    w = 40;
    h = 40;
    this.label = label;
  }
  void show(){
    if (clicked){
      fill(200, 200, 200);
    }
    else{
      fill(r, g, b);
    }
    rect(x, y, w, h);
    fill(100, 100, 100);
    textSize(15);
    text(label, x+1, y+h/3);
  }
}