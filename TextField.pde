class field {

  int x, y;
  String text;

  field(int x_, int y_, String text_) {
    x=x_;
    y=y_;
    text=text_;
  }

  void show() {
    textAlign(CENTER, CENTER);

    fill(accent);
    textSize(35);
    rect(x, y, textWidth(text), 35);
    fill(back);
    text(text, x+textWidth(text)/2, y+35/2-5);
  }




  boolean update() {
    textSize(35);
    return(mouseX>x&&mouseX<x+textWidth(text)&&mouseY>y&&mouseY<y+35);
  }
}
