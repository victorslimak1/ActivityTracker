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
        
  }
}




void draw() {
}
