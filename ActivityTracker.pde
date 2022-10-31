color back=#333333; 
color fore=#969696; 
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;

int d, mo, y, h, mi;
int[] maxDays={31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};


void setup(){
  size(700,700);
  
  d=day();
  mo=month();
  y=year();

}


void draw(){
  background(back);
  
  fill(accent);
  textSize(23);
  text("Date: "+d+"/"+mo+"/"+y, 100, 150);
  
  
}


void keyPressed(){
  switch(key){
    case ' ':
      println("==setup==");
      setup();
      break;
    case 'w':
      println("==exit==");
      exit();
      break;
  } 
}
