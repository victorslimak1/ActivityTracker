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

  //exit();
}

void showBarChart() {
  float spacing=((5*width/7)-40)/(sets.length);
  float offset=(width/7)+20;
  float wid=spacing/2;


  fill(darkb);
  stroke(fore);
  strokeWeight(4);


  for (int i=0; i<sets.length; i++) {
    int sum=0;
    for (int j=0; j<sets[i].size(); j++) {
      sum+=sets[i].get(j).amount;
    }
    //line((spacing*(i+0.5))+offset,410,(spacing*(i+0.5))+offset,410-(200*sum/maxInDay));
    rect(spacing*(i+0.5)+offset-wid/2, 410, wid, -(200*sum/maxInDay));
  }

  stroke(accent);
  line(width/7, 190, width/7, 430);
  line(width/7, 190, width/7-5, 195);
  line(width/7, 190, width/7+5, 195);

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
