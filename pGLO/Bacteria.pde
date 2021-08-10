class Bacteria{
  DNA plasmid;
  boolean resist = false;
  boolean energyHarvest = false;
  int energy = 100;
  float mutRate = 0.005;
  int x, y, r, g, b;
  Bacteria(){
    x = (int) random(0, width);
    y = (int) random(0, height);
    r = 255;
    g = 255;
    b = 255;
    plasmid = new DNA(15000, true);
  }
  Bacteria(Bacteria ba){
    x = ba.x;
    y = ba.y;
    r = ba.r;
    g = ba.g;
    b = ba.b;
    plasmid = new DNA(ba.plasmid);
  }
  void show(){
    fill(r, g, b);
    express();
    ellipse(x, y, energy/25, energy/25);
  }
  void move(){
    x += (int) random(-2, 2);
    y += (int) random(-2, 2);
  }
  void express(){
    if (plasmid.sequence.contains("ATGTCTAAA")){
      g = 255;
      r = 0;
      b = 100;
    }
    if (plasmid.sequence.contains("ATGGTATAA")){
      resist = true;
    }
    if (plasmid.sequence.contains("GGCCTATA")){
      energyHarvest = true;
    }
    if (plasmid.sequence.contains("AAAATTTTCTTCGCC")){
      mutRate = 0.05;
    }
  }
  void mutate(){
    int pointMut = (int) random(0, plasmid.sequence.length());
    if (random(0, 1) < mutRate) {
      g--;
      plasmid.genRandBase(pointMut);
    }
  }
}