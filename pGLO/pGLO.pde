ArrayList<Bacteria> bac;
ArrayList<DNA> dna;
Agar a;
int reproC = 0;
int timer = 0;
int enThresh = 150;
int rate = 500;
Button[] b = new Button[3];
void setup() {
  size(800, 800);
  int pop = 100;
  a = new Agar(width/2, height/2, 200);
  bac = new ArrayList<Bacteria>();
  for (int i = 0; i < pop; i++) {
    bac.add(new Bacteria());
  }
  dna = new ArrayList<DNA>();
  for (int i = 0; i < pop; i++) {
    dna.add(new DNA(10000, false));
  }
  b[0] = new Button(0, 0, 255, 0, 0, "-Rate");
  b[1] = new Button(40, 0, 0, 0, 255, "+Rate");
  b[2] = new Button(0, 40, 255, 255, 0, "Plasmid Drop");
  b[2].w = 80;
}
void draw() {
  background(0);
  int ampPlas = 0;
  int gfpPlas = 0;
  int enHar = 0;
  timer++;
  a.show();
  b[0].show();
  b[1].show();
  b[2].show();
  for (Bacteria b : bac) {
    b.show();
    b.move();
    b.mutate();
    if (dist(a.x, a.y, b.x, b.y) < a.r && random(0, 1)<0.1 && a.food >0) {
      if (b.energyHarvest) b.energy++;
      b.energy++;
      a.food--;
    }
    for (int i = dna.size()-1; i >= 0; i--) { 
      if (dist(b.x, b.y, dna.get(i).x, dna.get(i).y)<2) {
        b.plasmid.transform(dna.get(i));
        dna.remove(i);
      }
    }
  }
  if (timer%rate == 0) {
    reproduce();
  }


  for (Bacteria b : bac) {
    if (b.resist) ampPlas++;
    if (b.g == 255 && b.r == 0) gfpPlas++;
    if (b.energyHarvest) enHar++;
  }
  ampRes();
  textDisplay(ampPlas, gfpPlas, enHar);
}
void textDisplay(int ap, int b, int e) {
  textSize(20);
  fill(255, 255, 255, 150);
  text("Plasmids left: " + dna.size(), width/2, 50);

  text("AMP: " + ap, width/2, 75);

  text("GFP: " + b, width/2, 100);
  text("EH: " + e, width/2, 125);

  text("Gen: " + reproC, width/2, 150);

  text("Food Rem: " + a.food, width/2, 175);
  text("Timer: " + timer, width/2, 200);
  text("BacTotal: " + bac.size(), width/2, 225);
}
void test() {
  DNA d = new DNA(100, true);
  print(d.sequence);
}
void ampRes() {
  for (int i = bac.size()-1; i >=0; i--) {
    if (!bac.get(i).resist && random(0, 1)<0.02) {
      bac.get(i).energy-=2;
    }
  }
}
void reproduce() {
  reproC++;
  for (int i = bac.size()-1; i >= 0; i--) {
    if (bac.get(i).energy <= 0) {
      dna.add(new DNA(bac.get(i).plasmid));
      bac.remove(i);
    }
    if (bac.get(i).energy >= enThresh) {
      while (bac.get(i).energy > enThresh) {
        bac.add(new Bacteria(bac.get(i)));
        bac.get(i).energy -= enThresh/2;
      }
    }
  }
}
DNA plasmid(){
  return new DNA("ATGGTATAAAAAATTTTCTTCGCCGGCCTATAATGTCTAAA");
}
void mousePressed(){
  if (mouseX > b[0].x 
    && mouseX < b[0].x + b[0].w 
    && mouseY > b[0].y 
    && mouseY < b[0].y + b[0].h)
  {
      b[0].clicked = true;
      rate+=10;
  }
  if (mouseX > b[1].x 
    && mouseX < b[1].x + b[1].w 
    && mouseY > b[1].y 
    && mouseY < b[1].y + b[1].h)
  {
    b[1].clicked = true;
      rate-=10;
  }
  if (mouseX > b[2].x 
    && mouseX < b[2].x + b[2].w 
    && mouseY > b[2].y 
    && mouseY < b[2].y + b[2].h)
  {
      b[2].clicked = true;
      for (int i = 0; i < 20; i++){
        dna.add(plasmid());
      }
  }
}
void mouseReleased(){
  b[0].clicked = false;
  b[1].clicked = false;
  b[2].clicked = false;
}