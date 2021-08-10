public class Grid{
  boolean[][] curr;
  boolean[][] next;
  public Grid(int r, int c){
    curr = new boolean[r][c];
    next = new boolean[r][c];
    for(int i = 0; i < r; i++){
      for (int j = 0; j < c; j++){
        next[i][j] = random(0, 1)<0.5;
      }
    }
    copyNextToCurr();
  }
  public void copyNextToCurr(){
    for (int i = 0; i < curr.length; i++){
      for (int j = 0; j < curr[i].length; j++){
        curr[i][j] = next[i][j];
      }
    }
  }
  public void show(){
    noStroke();
    for (int i = 0; i < curr.length; i++){
      for (int j = 0; j < curr[i].length; j++){
        if (curr[i][j] == false) fill(255, 0, 255);
        else fill(0, 255, 0);
        rect(i*width/curr.length, j*height/curr[i].length,width/curr.length, height/curr[i].length);
      }
    }
  }
  public void clicked(int x, int y){
    int w = width/curr.length;
    int h = height/curr[0].length;
    curr[x/w][y/h] = !curr[x/w][y/h];
  }
  public void generate(){
    for (int i = 0; i < curr.length; i++){
      for (int j = 0; j < curr[i].length; j++){
        int num = getLivingNeighbors(i,j);
        if (curr[i][j]){
          if (num < 2) next[i][j] = false;
          else if (num > 3) next[i][j] = false;
          else next[i][j] = true;
        }
        else if (num == 3){
          next[i][j] = true;
        }
      }
    }
    //curr = next;
    copyNextToCurr();
  }
  public int getLivingNeighbors(int x, int y){
    int sum = 0;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++){
        if (x + i < 0 || x + i > curr.length-1) break;
        if (y + j < 0 || y + j > curr.length-1) continue;
        if (i != 0 || j != 0){
          if (curr[x + i][y + j]) {
            sum++;
          }
        }
      }
    }
    return sum;
  } 
  
}
