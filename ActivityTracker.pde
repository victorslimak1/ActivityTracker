color back=#333333;
color fore=#969696;
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;

int d, mo, y, h, mi;
int[] maxDays={31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

button nextDate=new button(345, 122.5, 35, 35, "+");
button prevDate=new button(290, 122.5, 35, 35, "-");


void setup() {
  size(500, 700);

  d=day();
  mo=month();
  y=year();
}


void draw() {
  background(back);

  fill(accent);
  textSize(23);
  text("Date: "+d+"/"+mo+"/"+y, 100, 150);

  nextDate.show();
  prevDate.show();


  if (mousePressed) {
    if (nextDate.updated()) {
      changeDate(1);
    } else if (prevDate.updated()) {
      changeDate(-1);
    }
  }
}

void changeDate(int dir) {
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
