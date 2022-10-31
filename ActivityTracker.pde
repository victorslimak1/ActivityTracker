color back=#333333;
color fore=#969696;
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;

int d, mo, y, h, mi;
int[] maxDays={31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

int goal;

button nextDate=new button(345, 122.5, 35, 35, "+");
button prevDate=new button(290, 122.5, 35, 35, "-");
field goalField=new field(170,225,"200");


void setup() {
  size(500, 700);

  d=day();
  mo=month();
  y=year();
}


void draw() {
  background(back);


  //Date---------------
  fill(accent);
  textSize(23);
  text("Date: "+d+"/"+mo+"/"+y, 100, 150);

  nextDate.show();
  prevDate.show();

  //Goal------------------
  textSize(23);
  text("Goal: ",100,250);
  goalField.show();

  //Buttons--------------------
  if (mousePressed) {
    if (nextDate.updated()) {
      changeDate(1);
    } else if (prevDate.updated()) {
      changeDate(-1);
    }
  }
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
    d=maxDays[mo-2];
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
  case 'w':
    println("==exit==");
    exit();
    break;
  }
}
