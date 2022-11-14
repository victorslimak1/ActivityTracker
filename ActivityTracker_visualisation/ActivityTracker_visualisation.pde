String[] lines;
ArrayList<IntList> data=new ArrayList<IntList>();





void setup(){
  size(200,200);
  background(41);
  
  lines = loadStrings("trackingSheet.txt");

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
