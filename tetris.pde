static int cellSize = 25;

int state = 0;
PVector[][] tetrimino;
boolean[][] world;

PVector mino;

void settings() {
    size(12*cellSize,24*cellSize);
}

void setup(){
  //allocate tetrimino
  tetrimino = new PVector[4][4];
  
  //allocate world
  world = new boolean[12][24];
  
  //set tetrimino too 'O'
  tetrimino[0][0] = new PVector(6,0);
  tetrimino[0][1] = new PVector(7,0);
  tetrimino[0][2] = new PVector(6,1);
  tetrimino[0][3] = new PVector(7,1);
  
  //set tetrimino too 'I'
  tetrimino[0][0] = new PVector(6,0);
        tetrimino[0][1] = new PVector(7,0);
        tetrimino[0][2] = new PVector(8,0);
        tetrimino[0][3] = new PVector(9,0);
        
        tetrimino[1][0] = new PVector(6,0);
        tetrimino[1][1] = new PVector(6,1);
        tetrimino[1][2] = new PVector(6,2);
        tetrimino[1][3] = new PVector(6,3);
        
        tetrimino[2][0] = new PVector(6,0);
        tetrimino[2][1] = new PVector(7,0);
        tetrimino[2][2] = new PVector(8,0);
        tetrimino[2][3] = new PVector(9,0);
        
        tetrimino[3][0] = new PVector(6,0);
        tetrimino[3][1] = new PVector(6,1);
        tetrimino[3][2] = new PVector(6,2);
        tetrimino[3][3] = new PVector(6,3);
  
  frameRate(4);
  
  mino = new PVector(6,0);
}

void draw(){
  boolean update = true;
  background(0);
  
  //draw world
  for(int i = 0; i < 12; i++){
    for(int j = 0; j < 24; j++){
      if (world[i][j] == true)
        rect(i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }
  
  //draw tetrimino
  for(int i = 0; i < 4; i++){
    rect(tetrimino[state][i].x*cellSize, tetrimino[state][i].y*cellSize, cellSize, cellSize);
  }
  
  //check collision
  for(int i = 0; i < 4; i++){
    ////check if on screen
    if (tetrimino[state][i].x >= 0 && tetrimino[state][i].x < 12 &&
        tetrimino[state][i].y >= 0 && tetrimino[state][i].y < 24){
      if ( tetrimino[state][i].y+1 > 23 || world[(int)tetrimino[state][i].x][(int)tetrimino[state][i].y+1]==true){
          //set tetrimino to world 
          for(int j = 0; j < 4; j++){
            ////check if on screen
            if (tetrimino[state][j].x >= 0 && tetrimino[state][j].x < 12 &&
                tetrimino[state][j].y >= 0 && tetrimino[state][j].y < 24){
                  world[(int)tetrimino[state][j].x][(int)tetrimino[state][j].y] = true;
            }
          }
          
          //set tetrimino too 'I'
          tetrimino[0][0] = new PVector(6,0);
          tetrimino[0][1] = new PVector(7,0);
          tetrimino[0][2] = new PVector(8,0);
          tetrimino[0][3] = new PVector(9,0);
          
          tetrimino[1][0] = new PVector(6,0);
          tetrimino[1][1] = new PVector(6,1);
          tetrimino[1][2] = new PVector(6,2);
          tetrimino[1][3] = new PVector(6,3);
          
          tetrimino[2][0] = new PVector(6,0);
          tetrimino[2][1] = new PVector(7,0);
          tetrimino[2][2] = new PVector(8,0);
          tetrimino[2][3] = new PVector(9,0);
          
          tetrimino[3][0] = new PVector(6,0);
          tetrimino[3][1] = new PVector(6,1);
          tetrimino[3][2] = new PVector(6,2);
          tetrimino[3][3] = new PVector(6,3);
          
        } else {
          update = true;
        }
     }
  }
  
  //update tetrimino
  if(update)
    for(int i = 0; i < 4; i++){
      for(int j = 0; j < 4; j++){
        tetrimino[j][i].y++;
      }
    }
    
  //update world
  //check if row is completed
  for(int j = 0; j < 24; j++){
    boolean completed = true;
    
    for(int i = 0; i < 12; i++){
      if(world[i][j] == false) completed = false;
    }
    
    if(completed) {
      for(int i = 0; i < 12; i++){
        world[i][j] = false;
      }
      
      //move all cells above 1 down
      for(int z = j; z > 0; z--){
        for(int i = 0; i < 12; i++){
          if (world[i][z] == true){
            world[i][z] = false;
            world[i][z+1] = true;
          }
        }
      }
    }
  }
}

void keyPressed(){
  if(key == 'a'){
    for(int i = 0; i < 4; i++){
      for(int j = 0; j < 4; j++){
        tetrimino[j][i].x--;
      }
    }
  }
  if(key == 'd'){
    for(int i = 0; i < 4; i++){
      for(int j = 0; j < 4; j++){
        tetrimino[j][i].x++;
      }
    }
  }
  
  if(key == 'w'){
    state = ((state+1)%4);
  }
}
