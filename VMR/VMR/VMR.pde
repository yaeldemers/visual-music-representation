// Need G4P library
import g4p_controls.*;

public void setup(){
 fullScreen();
  createGUI();
  customGUI();
  // Place your setup code here
  
}

public void draw(){
  background(5);
  if(ifdraw == true){
  translate(width/2, height/2);
  scale(scale);
  translate(-xPan, -yPan);
  if(zoomIn){
   scale*= zoomSpeed; 
  }
  if (zoomOut){
   scale/= zoomSpeed; 
  }
  if(up){
    yPan -= panSpeed;
  }
  if(down){
    yPan += panSpeed;
  }
  if(left){
    xPan -= panSpeed;
  }
  if(right){
    xPan += panSpeed;
  }

  float beats = 0;
  float currentBeatx = 0;
  float currentBeaty = 0;
  float squareMultiplier =0 ;
  
  for (int f = 0; f<data[1].length;f++){
    loopMod = 0;
    loopMod = checkRecurrence(loopMod, f, data, data[1].length);
    beats += data[1][f];
    f += loopMod;
  }
  beats = ceil(beats);
  float x =(1000/(beats+2));
  if (x<7){
   x = 7; 
  }
  float y;
  for (int i = 0; i<data[1].length ; i++){
    loopMod = 0;
    loopMod = checkRecurrence(loopMod, i, data, data[1].length);
    if(data[0][i]>9){
      y = 0.80; 
    }
    else{
      y = 1.2;
    }
    if (x>10){
    textSize(x/6);
    }
    else{
     textSize(x/5); 
    }
    fill(255);
    noteName1 = noteDeterm(int(data[0][i]));
    text(noteName1, (x*currentBeatx)+x+260, 0.85*x);
    currentBeaty = 0;
    for (int j = 0; j<data[1].length ; j++){
      loopMod2 = 0;
      loopMod2 = checkRecurrence(loopMod2, j, data, data[1].length);
      
     if(data[0][j]>9){
       y = 0.5; 
      }
      else{
        y = 0.6;
      }
      if(x>10){
      textSize(x/6);
      }
      else{
       textSize(x/5); 
      }
      fill(255);
      noteName2 = noteDeterm(int(data[0][j]));
      text(noteName2, (y*x)+260, (x*currentBeaty)+1.25*x);
      
     if(data[0][i] == data[0][j]){
       fill(244, 66, 110);
       
       if(data[1][j] > data[1][i])
       {
        squareMultiplier = data[1][i]; 
       }
       else if(data[1][j]<data[1][i])
       {
        squareMultiplier = data[1][j];
       }
       else if(data[1][j]==data[1][i])
       {
        squareMultiplier = data[1][j]; 
       }
       if(data[0][j] == 0){
         fill(255, 255, 255);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
         
       }
       if(data[0][j] == 1){
         fill(237, 243, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 2){
         fill(222, 233, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 3){
         fill(204, 222, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 4){
         fill(182, 208, 249);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 5){
         fill(164, 197, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 6){
         fill(141, 183, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 7){
         fill(123, 173, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 8){
         fill(100, 159, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 9){
         fill(80, 146, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 10){
         fill(55, 131, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 11){
         fill(32, 115, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(data[0][j] == 12){
         fill(5, 99, 252);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
       if(i == j){
         fill(247, 162, 4);
         rect(currentBeatx*x+x+260, currentBeaty*x+x, squareMultiplier*x, squareMultiplier*x);
       }
     }
     currentBeaty += data[1][j];
     j+= loopMod2;
    }
    currentBeatx += data[1][i];
    i+=loopMod;
  }
  }
}
int checkRecurrence(int loopMod, int j, float [][] data, int dataLength){
 if(j+1 < dataLength && data[2][j] == data[2][j+1]){
           if(j+2 < dataLength && data[2][j] == data[2][j+2]){
             if(j+3 < dataLength && data[2][j] == data[2][j+3]){
               if(j+4 < dataLength && data[2][j] == data[2][j+4]){
                 if(j+5 < dataLength && data[2][j] == data[2][j+5]){
                   loopMod+=5;
                 }
                 else{
                   loopMod+=4;
                 }
               }
               else{
                 loopMod+=3; 
               }
             }
             else{

               loopMod+=2;
               
             }
           }
           else{
            loopMod+=1;
            
           }
         }
         else {
         loopMod = 0;  
         }
         
  return loopMod;
}
void keyPressed(){
 if(keyCode == UP){
  zoomIn = true; 
  zoomOut = false;
 }
 if(keyCode == DOWN){
  zoomOut = true;
  zoomIn = false;
  
 }
 if(key == 'w'){
  up = true;
  down = false;
 }
 if(key == 's'){
  down = true;
  up = false;
 }
 if(key == 'a'){
  left = true;
  right = false;
 }
 if(key == 'd'){
  right = true;
  left = false;
 }
}

void keyReleased(){
  if(keyCode == UP){
  zoomIn = false; 
 }
 if(keyCode == DOWN){
  zoomOut = false;
  
 }
 if(key == 'w'){
  up = false;
 }
 if(key == 's'){
  down = false;
 }
 if(key == 'a'){
  left = false;
 }
 if(key == 'd'){
  right = false;
 }
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}
