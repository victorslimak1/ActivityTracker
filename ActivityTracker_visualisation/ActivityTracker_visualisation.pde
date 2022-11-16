String[] lines;
ArrayList<IntList> data=new ArrayList<IntList>();

color back=#333333;
color fore=#969696;
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;



void setup(){
  size(700,900);
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
  
  
  
  
}

void draw(){


}
