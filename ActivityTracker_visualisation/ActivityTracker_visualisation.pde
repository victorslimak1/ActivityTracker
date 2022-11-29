import processing.pdf.*; //<>// //<>// //<>//


String[] lines;
ArrayList<IntList> data=new ArrayList<IntList>();

color back=#333333;
color fore=#969696;
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;

int[][] dates;
int[] goals;
ArrayList<Set>[] sets;


int[] monthValues={1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6};//Values used for calcualting weekDay


float avgPerRecDay;
float avgPerAllDay;
int total;
int maxInDay;
int maxInSet;


boolean pdf=false;

void setup() {
  //size(700, 1200, PDF, "ActivityTracker.pdf");
  //change bool above as well
  size(700, 1100);


  lines = loadStrings("../trackingSheet.txt");


  for (int i = 0; i < lines.length; i++) {
    IntList tempList=new IntList();
    int[] tempArr=int(split(lines[i], ","));
    for (int j=0; j<tempArr.length; j++) {
      tempList.append(tempArr[j]);
    }
    data.add(tempList);
  }


  dates=new int[data.size()][3];
  sets=new ArrayList[data.size()];
  goals=new int[data.size()];

  for (int i=0; i<data.size(); i++) {
    dates[i][0]=data.get(i).get(0);
    dates[i][1]=data.get(i).get(1);
    dates[i][2]=data.get(i).get(2);
    goals[i]=data.get(i).get(3);
    sets[i]=new ArrayList<Set>();

    for (int j=4; j<data.get(i).size()-1; j+=3) {
      Set temp=new Set(data.get(i).get(j), data.get(i).get(j+1), data.get(i).get(j+2));
      sets[i].add(temp);
    }
  }


  getTotals();
}


void getTotals() {
  int sum=0;
  int setSum;
  maxInDay=0;
  maxInSet=0;

  for (int i=0; i<sets.length; i++) {
    setSum=0;
    for (int j=0; j<sets[i].size(); j++) {
      int amount=sets[i].get(j).amount;
      setSum+=amount;
      if (amount>maxInSet) {
        maxInSet=amount;
      }
    }
    sum+=setSum;
    if (setSum>maxInDay) {
      maxInDay=setSum;
    }
  }
  total=sum;
  avgPerAllDay=float(total)/sets.length;
}




void draw() {
  background(back);
  showGoals();
  showTotals();
  showBarChart();
  showTimeCircle();
  showDayCircle();
  showTimeTable();

  if (pdf) {
    exit();
  }
}


void mouseOver() {
  if (mouseX>width/7&&mouseX<6*width/7) {
    if (mouseY>190&&mouseY<430) {
      float spacing=((5*width/7)-40)/(sets.length);
      float offset=(width/7)+20;
      float wid=spacing/2;

      float x1, y1, x2, y2;

      int maxGoal=0;
      for (int i=0; i<goals.length; i++) {
        if (goals[i]>maxGoal) {
          maxGoal=goals[i];
        }
      }

      int maxVal=max(maxGoal, maxInDay);


      for (int i=0; i<sets.length; i++) {
        int sum=0;
        for (int j=0; j<sets[i].size(); j++) {
          sum+=sets[i].get(j).amount;
        }
        x1=spacing*(i+0.5)+offset-wid/2;
        y1=410-(200*sum/maxVal);
        x2=spacing*(i+0.5)+offset+wid/2;
        y2=410;

        if (mouseX>x1&&mouseX<x2) {
          if (mouseY>y1&&mouseY<y2) {
            stroke(accent);
            rect(mouseX, mouseY, 90, -60);
            fill(accent);
            textAlign(LEFT,CENTER);
            text(dates[i][0]+"/"+dates[i][1],mouseX+5,mouseY-50);
            text("Total: "+sum,mouseX+5,mouseY-30);
            text("Goal: "+goals[i],mouseX+5,mouseY-10);
          }
        }
      }
    }
  }
}


void showGoals() {
  textAlign(CENTER,CENTER);
  fill(fore);
  text("Goals by Summer:", width/5, 40);
  text("200 per Day", 2*width/5, 40);
  text("20 per Set", 3*width/5, 40);
  text("35 in 1 Set", 4*width/5, 40);
}

void showTimeTable() {
  pushMatrix();
  translate(width/7, 750);
  float wid=5*width/7;
  fill(accent);
  textAlign(CENTER, CENTER);
  text(0, 0, 0);
  text(6, wid/4, 0);
  text(12, wid/2, 0);
  text(18, 3*wid/4, 0);
  text(24, wid, 0);

  for (int i=0; i<sets.length; i++) {
    int sum=0;
    for (int j=0; j<sets[i].size(); j++) {
      int time=(sets[i].get(j).h)*60+(sets[i].get(j).mi);
      float dis=map(time, 0, 1440, 0, wid);

      sum+=sets[i].get(j).amount;

      if (sum<=goals[i]) {
        fill(lightb, 70);
      } else {
        fill(darkb, 40);
      }
      noStroke();
      ellipse(dis, 20*(i+2), 10+(sets[i].get(j).amount*0.8), 10+(sets[i].get(j).amount*0.8));
    }
    fill(fore);
    textSize(23);
    text(dates[i][0]+"/"+dates[i][1], -60, 20*(i+2));
  }



  popMatrix();
}

void showDayCircle() {
  pushMatrix();
  translate(5*width/7, 550);
  fill(accent);
  textAlign(CENTER, CENTER);
  text("Mon", 80*cos(0.5*TWO_PI/7-HALF_PI), 80*sin(0.5*TWO_PI/7-HALF_PI));
  text("Tue", 80*cos(1.5*TWO_PI/7-HALF_PI), 80*sin(1.5*TWO_PI/7-HALF_PI));
  text("Wed", 80*cos(2.5*TWO_PI/7-HALF_PI), 80*sin(2.5*TWO_PI/7-HALF_PI));
  text("Thr", 80*cos(3.5*TWO_PI/7-HALF_PI), 80*sin(3.5*TWO_PI/7-HALF_PI));
  text("Fri", 80*cos(4.5*TWO_PI/7-HALF_PI), 80*sin(4.5*TWO_PI/7-HALF_PI));
  text("Sat", 80*cos(5.5*TWO_PI/7-HALF_PI), 80*sin(5.5*TWO_PI/7-HALF_PI));
  text("Sun", 80*cos(6.5*TWO_PI/7-HALF_PI), 80*sin(6.5*TWO_PI/7-HALF_PI));


  int r=40;

  for (int i=0; i<sets.length; i++) {
    int day=getDay(dates[i]);
    float angle=map(day, 0, 6, (5.5*TWO_PI/7), (11.5*TWO_PI/7));
    int sum=0;

    for (int j=0; j<sets[i].size(); j++) {
      sum+=sets[i].get(j).amount;
    }

    fill(lightb, sum*0.1);
    noStroke();
    ellipse((r+(i*0.1))*cos(angle-HALF_PI), (r+(i*0.1))*sin(angle-HALF_PI), 10, 10);
  }

  fill(fore);
  text("Day", 0, 0);
  popMatrix();
}


int getDay(int[] date) {
  int day=date[0];
  int month=date[1];
  int year=date[2];

  int sum=0;

  //Instructions taken from here:
  //https://beginnersbook.com/2013/04/calculating-day-given-date/

  sum=(year/4)-500;//Dividing the last 2 digits by 4 and removing the remainder. -500 removes the first 2 digits (will work up to year 2100).
  sum+=day;
  sum+=monthValues[month-1];
  if (month==1||month==2) {
    if (year%4==0) {
      sum--;//Removing 1 if January or Febuary of leap year.
    }
  }
  sum+=6;//Adding 6 for the 2000s

  sum+=year-2000;//Adding last 2 digits of year

  int weekDay=sum%7;

  return weekDay;
}

void showTimeCircle() {
  pushMatrix();
  translate(2*width/7, 550);
  fill(accent);
  textAlign(CENTER, CENTER);
  text(0, 0, -80);
  text(6, 80, 0);
  text(12, 0, 80);
  text(18, -80, 0);

  int r=30;

  for (int i=0; i<sets.length; i++) {
    for (int j=0; j<sets[i].size(); j++) {
      int time=(sets[i].get(j).h)*60+(sets[i].get(j).mi);
      float angle=map(time, 0, 1440, 0, TWO_PI)-HALF_PI;

      fill(lightb, 10);
      noStroke();
      ellipse((r+i)*cos(angle), (r+i)*sin(angle), 10, 10);
    }
  }

  fill(fore);
  text("Time", 0, 0);
  popMatrix();
}

void showBarChart() {
  float spacing=((5*width/7)-40)/(sets.length);
  float offset=(width/7)+20;
  float wid=spacing/2;

  int maxGoal=0;
  for (int i=0; i<goals.length; i++) {
    if (goals[i]>maxGoal) {
      maxGoal=goals[i];
    }
  }

  int maxVal=max(maxGoal, maxInDay);

  strokeWeight(2);
  stroke(accent);

  beginShape();
  for (int i=0; i<sets.length; i++) {
    int sum=0;
    int maxSet=0;
    int amount=0;
    for (int j=0; j<sets[i].size(); j++) {
      amount=sets[i].get(j).amount;
      sum+=amount;
      if (amount>maxSet) {
        maxSet=amount;
      }
    }
    fill(darkb);
    rect(spacing*(i+0.5)+offset-wid/2, 410, wid, -(200*sum/maxVal));
    fill(lightb);
    rect(spacing*(i+0.5)+offset-wid/2, 410, wid, -(200*maxSet/maxVal));
    vertex(spacing*(i+0.5)+offset, 410-(200*goals[i]/maxVal));
    
    if(mouseX>spacing*(i+0.5)+offset-wid/2&&mouseX<spacing*(i+0.5)+offset+wid/2){
      if(mouseY>410-(200*sum/maxVal)&&mouseY<400){
        //mouseOver(i);
      }
    }
    
    
  }
  noFill();
  stroke(fore);
  strokeWeight(3);

  endShape();




  //----------------------- Axis


  //Y-axis
  stroke(accent);
  line(width/7, 190, width/7, 430);
  line(width/7, 190, width/7-5, 195);
  line(width/7, 190, width/7+5, 195);


  line(width/7-5, 210, width/7+5, 210);
  line(width/7-5, 310, width/7+5, 310);

  textAlign(RIGHT, CENTER);
  fill(accent);
  text(maxVal, width/7-15, 210);
  text(maxVal/2, width/7-15, 310);



  //X-axis
  line(width/7-20, 410, 6*width/7+20, 410);
  line(6*width/7+20, 410, 6*width/7+15, 405);
  line(6*width/7+20, 410, 6*width/7+15, 415);
}

void showTotals() {
  textFont(createFont("AppleSymbols", 20));
  fill(accent);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Average per Day", width/5, 80);
  text("Total #", 2*width/5, 80);
  text("Max in 1 Day", 3*width/5, 80);
  text("Max in 1 Set", 4*width/5, 80);

  textSize(30);
  text(avgPerAllDay, width/5, 120);
  text(total, 2*width/5, 120);
  text(maxInDay, 3*width/5, 120);
  text(maxInSet, 4*width/5, 120);
}
