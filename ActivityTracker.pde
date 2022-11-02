color back=#333333;
color fore=#969696;
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;

int d, mo, y, h, mi;
int[] maxDays={31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

String goal="100";
String newGoal="";

button nextDate=new button(345, 122.5, 35, 35, ">>");
button prevDate=new button(290, 122.5, 35, 35, "<<");

field goalField=new field(170, 225, goal);

button nextH=new button(160, 310, 20, 20, "^");
button prevH=new button(160, 355, 20, 20, "̌");
button nextM=new button(190, 310, 20, 20, "^");
button prevM=new button(190, 355, 20, 20, "̌");

boolean writingGoal=false;


void setup() {
  size(500, 700);

  d=day();
  mo=month();
  y=year();

  h=hour();
  mi=minute();
}


void draw() {
  background(back);

  textAlign(TOP, LEFT);


  //Date---------------
  fill(accent);
  textSize(23);
  text("Date: "+d+"/"+mo+"/"+y, 100, 150);

  nextDate.show();
  prevDate.show();

  textAlign(TOP, LEFT);


  //Goal------------------
  textSize(23);
  text("Goal: ", 100, 250);
  goalField.show();
  if (writingGoal) {
    goalField.text=newGoal;
  }

  textAlign(TOP, LEFT);


  //Time------------
  fill(accent);
  textSize(23);
  if (mi<10) {
    text("Time: "+h+":0"+mi, 100, 350);
  } else {
    text("Time: "+h+":"+mi, 100, 350);
  }

  nextH.show();
  prevH.show();
  nextM.show();
  prevM.show();

  textAlign(TOP, LEFT);

  //Quantity---------------
  textSize(23);
  text("Quantity: ", 100, 450);
  goalField.show();
  if (writingGoal) {
    goalField.text=newGoal;
  }


  textAlign(TOP, LEFT);

  //SUBMIT----------------------
  fill(accent);
  textSize(23);
  text("Submit: ", 100, 550);





  //mousePressed stuff--------------------
  if (mousePressed) {
    if (nextDate.updated()) {
      changeDate(1);
    } else if (prevDate.updated()) {
      changeDate(-1);
    } else if (goalField.update()) {
      changeGoal();
    }
  }
}

void changeGoal() {
  newGoal="";
  writingGoal=true;
}

void changeDate(int dir) {
  d+=dir;
  if (d>maxDays[mo-1]) {
    d=1;
    mo++;
    if (mo==13) {
      mo=1;
      y++;
    }
  } else if (d==0) {
    if (mo==1) {
      d=31;
    } else {
      d=maxDays[mo-2];
    }
    mo--;
    if (mo==0) {
      mo=12;
      y--;
    }
  }

  delay(100);
}


void keyPressed() {
  switch(key) {
  case ' ':
    println("==setup==");
    setup();
    break;
  }
  if (int(key)>=48&&int(key)<=57&&writingGoal) {
    newGoal+=key;
  }
  if (key==8&writingGoal) {
    if (newGoal.length()>0) {
      newGoal=newGoal.substring(0, newGoal.length()-1);
    }
  }
  if (key==ENTER) {
    writingGoal=false;
  }
}
