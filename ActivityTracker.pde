color back=#333333;
color fore=#969696;
color darkb=#0073D1;
color lightb=#69DDFF;
color accent=#F5F5F5;

int d, mo, y, h, mi;
int[] maxDays={31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

String goal="100";
String newGoal="";

String amount="10";
String newAmount="";

button nextDate=new button(345, 122.5, 35, 35, ">>");
button prevDate=new button(290, 122.5, 35, 35, "<<");

field goalField=new field(170, 225, goal);

button nextH=new button(160, 310, 20, 20, "^");
button prevH=new button(160, 355, 20, 20, "̌");
button nextM=new button(190, 310, 20, 20, "^");
button prevM=new button(190, 355, 20, 20, "̌");

field amountField=new field(200, 425, amount);

button submit=new button(200, 550, 100, 35, "SUBMIT");


boolean writingGoal=false;
boolean writingAmount=false;


String[] lines;
ArrayList<IntList> data=new ArrayList<IntList>();



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

  //Amount---------------
  textSize(23);
  text("Amount: ", 100, 450);
  amountField.show();
  if (writingAmount) {
    amountField.text=newAmount;
  }


  textAlign(TOP, LEFT);

  //SUBMIT----------------------
  submit.show();





  //mousePressed stuff--------------------
  if (mousePressed) {
    if (nextDate.updated()) {
      changeDate(1);
    } else if (prevDate.updated()) {
      changeDate(-1);
    } else if (goalField.update()) {
      changeGoal();
    } else if (nextH.updated()) {
      changeH(1);
    } else if (prevH.updated()) {
      changeH(-1);
    } else if (nextM.updated()) {
      changeM(1);
    } else if (prevM.updated()) {
      changeM(-1);
    } else if (amountField.update()) {
      changeAmount();
    } else if (submit.updated()) {
      submit();
    }
  }
}

void submit() {
  //Reading data
  lines = loadStrings("trackingSheet.txt");

  for (int i = 0; i < lines.length; i++) {
    IntList tempList=new IntList();
    int[] tempArr=int(split(lines[i], ","));
    for (int j=0; j<tempArr.length; j++) {
      tempList.append(tempArr[j]);
    }
    data.add(tempList);
  }

  int lastRow = data.size()-1;

  if (lastRow!=-1) {//When the ArrayList is not empty
    if (data.get(lastRow).get(0)==d&&data.get(lastRow).get(1)==mo&&data.get(lastRow).get(2)==y) {//If the last row is the date that is being submitted
      data.get(lastRow).append(h);
      data.get(lastRow).append(mi);
      data.get(lastRow).append(int(amountField.text));
    } else {
      data.add(new IntList());
      data.get(lastRow+1).append(d);
      data.get(lastRow+1).append(mo);
      data.get(lastRow+1).append(y);
      data.get(lastRow+1).append(int(goalField.text));
      data.get(lastRow+1).append(h);
      data.get(lastRow+1).append(mi);
      data.get(lastRow+1).append(int(amountField.text));
    }
  }else {
      data.add(new IntList());
      data.get(lastRow+1).append(d);
      data.get(lastRow+1).append(mo);
      data.get(lastRow+1).append(y);
      data.get(lastRow+1).append(int(goalField.text));
      data.get(lastRow+1).append(h);
      data.get(lastRow+1).append(mi);
      data.get(lastRow+1).append(int(amountField.text));
    }




  //Writing new data to .txt document
  String[] temp=new String[data.size()];
  for (int i=0; i<data.size(); i++) {
    String tempLine="";
    for (int j=0; j<data.get(i).size(); j++) {
      tempLine=tempLine+str(data.get(i).get(j))+"";
      if (j<data.get(i).size()-1) {
        tempLine=tempLine+",";
      }
    }
    temp[i]=tempLine;
  }
  saveStrings("trackingSheet.txt", temp);



  delay(100);
}

void changeAmount() {
  writingGoal=false;
  newAmount="";
  writingAmount=true;
}

void changeH(int dir) {
  h+=dir;
  if (h==24) {
    h=0;
  } else if (h==-1) {
    h=23;
  }

  delay(100);
}

void changeM(int dir) {
  mi+=dir;
  if (mi==60) {
    mi=0;
  } else if (mi==-1) {
    mi=59;
  }

  delay(100);
}

void changeGoal() {
  writingAmount=false;
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

  if (int(key)>=48&&int(key)<=57&&writingAmount) {
    newAmount+=key;
  }
  if (key==8&writingAmount) {
    if (newAmount.length()>0) {
      newAmount=newAmount.substring(0, newAmount.length()-1);
    }
  }
  if (key==ENTER) {
    writingGoal=false;
    writingAmount=false;
  }
}
