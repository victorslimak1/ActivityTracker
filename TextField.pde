class field {

  int x, y;
  String text;

  field(int x_, int y_, String text_) {
    x=x_;
    y=y_;
    text=text_;
  }

  void show() {
    fill(accent);
    textSize(35);
    rect(x, y, textWidth(text), 35);
    fill(back);
    text(text, x, y+30);
  }
}
