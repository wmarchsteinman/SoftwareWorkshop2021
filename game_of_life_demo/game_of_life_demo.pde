Grid g;
boolean playing = false;
void setup(){
  size(500, 500);
  g = new Grid(100, 100);
}
void draw(){
   background(255);
   g.show();
   if (playing){
     if (frameCount%3 == 0) g.generate();
   }
}
void mouseClicked(){
  g.clicked(mouseX, mouseY);
}
void keyPressed(){
  if (keyCode == 32) playing = !playing;
}
