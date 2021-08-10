Tile[][] tiles;
void setup(){
  size(500, 500);
  int rows = 20;
  int cols = 20;
  int sideLen = min(width/rows, height/cols);
  tiles = new Tile[rows][cols];
  for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[i].length; j++){
      tiles[i][j] = new Tile(i * sideLen, j * sideLen, sideLen);
    }
  }

}

void draw(){
  background(255);
  for(Tile[] tileRow : tiles){
    for (Tile t : tileRow){
      t.show();
      t.shiftColor();
    }
  }
}
