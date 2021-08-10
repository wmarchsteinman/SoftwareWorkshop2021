class DNA{
  String sequence;
  int x, y;
  DNA(int len, boolean random){
    if (random) len = (int) random(0, len);
    sequence = "";
    for (int i = 0; i < len; i++){
      int r = (int) random(0, 4);
      String t = "";
      if (r == 0) t = "A";
      if (r == 1) t = "T";
      if (r == 2) t = "C";
      if (r == 3) t = "G";
      sequence += t;
    }
    x = (int) random(0, width);
    y = (int) random(0, height);
  }
  DNA (DNA d){
    this.sequence = d.sequence;
    this.x = d.x;
    this.y = d.y;
  }
    DNA (String s){
    this.sequence = s;
    x = (int) random(0, width);
    y = (int) random(0, height);
  }
  void transform(DNA d){
    String s = cut(d);
    sequence += s;
  }
  String cut(DNA d){
    String t = d.sequence;
    int a = (int) random(0, t.length());
    int b = (int) random(a, t.length());
    t = t.substring(0, a) + t.substring(b);
    return t;
  }
  boolean hasAMP(){
    return sequence.contains("ATGAGTATTCAA");
  }
  boolean hasGFP(){
    return sequence.contains("ATGTCTAAA");
  }
  void genRandBase(int loc){
      int r = (int) random(0, 4);
      String t = "";
      if (r == 0) t = "A";
      if (r == 1) t = "T";
      if (r == 2) t = "C";
      if (r == 3) t = "G";
      if (loc != sequence.length()-1)
      sequence = sequence.substring(0,loc) + r + sequence.substring(loc+1);
      else sequence = sequence.substring(0, loc) + r;
  }
}