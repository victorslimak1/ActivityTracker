import processing.pdf.*; //<>//


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



float avgPerRecDay;
float avgPerAllDay;
int total;
int maxInDay;
int maxInSet;


void setup() {
  //size(700, 900, PDF, "ActivityTracker.pdf");
  size(700, 900);


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
  showTotals();
  showBarChart();
  showTimeCircle();
  showDayCircle();


  //exit();
}

void showDayCircle() {
  pushMatrix();
  translate(5*width/7, 600);  
  fill(accent);
  textAlign(CENTER, CENTER);
  text("Mon", 80*cos(0.5*TWO_PI/7-HALF_PI), 80*sin(0.5*TWO_PI/7-HALF_PI));
  text("Tue", 80*cos(1.5*TWO_PI/7-HALF_PI), 80*sin(1.5*TWO_PI/7-HALF_PI));
  text("Wed", 80*cos(2.5*TWO_PI/7-HALF_PI), 80*sin(2.5*TWO_PI/7-HALF_PI));
  text("Thr", 80*cos(3.5*TWO_PI/7-HALF_PI), 80*sin(3.5*TWO_PI/7-HALF_PI));
  text("Fri", 80*cos(4.5*TWO_PI/7-HALF_PI), 80*sin(4.5*TWO_PI/7-HALF_PI));
  text("Sat", 80*cos(5.5*TWO_PI/7-HALF_PI), 80*sin(5.5*TWO_PI/7-HALF_PI));
  text("Sun", 80*cos(6.5*TWO_PI/7-HALF_PI), 80*sin(6.5*TWO_PI/7-HALF_PI));


  int r=30;

  for (int i=0; i<sets.length; i++) {
    for (int j=0; j<sets[i].size(); j++) {
      int time=(sets[i].get(j).h)*60+(sets[i].get(j).mi);
      float angle=map(time, 0, 1440, 0, TWO_PI)-HALF_PI;

      fill(lightb, 50);
      noStroke();
      ellipse((r+i)*cos(angle), (r+i)*sin(angle), 10, 10);
    }
  }

  fill(fore);
  text("Day", 0, 0);
  popMatrix();
}

void showTimeCircle() {
  pushMatrix();
  translate(2*width/7, 600);
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

      fill(lightb, 50);
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
  fill(darkb);
  stroke(accent);

  beginShape();
  for (int i=0; i<sets.length; i++) {
    int sum=0;
    for (int j=0; j<sets[i].size(); j++) {
      sum+=sets[i].get(j).amount;
    }

    rect(spacing*(i+0.5)+offset-wid/2, 410, wid, -(200*sum/maxVal));
    vertex(spacing*(i+0.5)+offset, 410-(200*goals[i]/maxVal));
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
  text("Average per Day: ", width/5, 80);
  text("Total #: ", 2*width/5, 80);
  text("Max in 1 Day: ", 3*width/5, 80);
  text("Max in 1 Set: ", 4*width/5, 80);

  textSize(30);
  text(avgPerAllDay, width/5, 120);
  text(total, 2*width/5, 120);
  text(maxInDay, 3*width/5, 120);
  text(maxInSet, 4*width/5, 120);
}
