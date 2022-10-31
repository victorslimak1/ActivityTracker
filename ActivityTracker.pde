

void setup(){
  size(700,700);

}


void draw(){
  background(255);
  
  
}


void keyPressed(){
  switch(key){
    case ' ':
      println("==setup==");
      setup();
      break;
    case 'f':
      println("==save frame==");
    saveFrame(frameCount+".jpg");
      break;
    case 'w':
      println("==exit==");
      exit();
      break;
  } 
}
