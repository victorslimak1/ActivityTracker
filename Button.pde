class button{
  float x,y,w,h;
  String text;
  
  button(float x_, float y_, float w_, float h_, String text_){
    x=x_;
    y=y_;
    w=w_;
    h=h_;
    text=text_;
  }
  
  // button(float x_, float y_, float w_, float h_){
  //  x=x_;
  //  y=y_;
  //  w=w_;
  //  h=h_;
  //  text="";
  //}
  
  void show(){
    fill(fore);
    rect(x,y,w,h);
    
    //if(text!=""){
      fill(accent);
      textSize(23);
      text(text,x+10,y+30);
    //}
    
  }
  
  
  boolean updated(){
    return(mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h);
  }

}
