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



int avgPerRecDay;
int avgPerAllDay;
int total;
int maxInDay;
int maxInSet;


void setup() {
  size(700, 900);
  background(back);

  lines = loadStrings("../trackingSheet.txt");


  for (int i = 0; i < lines.length; i++) {
    IntList tempList=new IntList();
    int[] tempArr=int(split(lines[i], ","));
    for (int j=0; j<tempArr.length; j++) {
      tempList.append(tempArr[j]);
    }
    data.add(tempList);
  }


  dates=new int[data.size()-1][3];
  sets=new ArrayList[data.size()-1];
  goals=new int[data.size()-1];

  for (int i=0; i<data.size()-1; i++) {
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

  println(data);

  getTotals();

  println(total);
  println(maxInDay);
  println(maxInSet);
}


void getTotals() {
  int sum=0;
  int setSum;
  maxInDay=0;
  maxInSet=0;

  for (int i=0; i<sets.length; i++) {
    setSum=0;
    for (int j=0; j<sets[i].size()-1; j++) {
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
}




void draw() {
}
