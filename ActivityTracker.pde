color back=#333333; 
color fore=#969696; 
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;


void setup(){
  size(700,700);

}


void draw(){
  background(back);
  
  
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
