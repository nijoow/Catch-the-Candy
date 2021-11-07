class ScoreText{
  
  int opa, s;
  float x;
  String c;
  
  ScoreText(int thisScore, float thisX, String thisColor){
    x = thisX;
    opa = 300;
    s = thisScore;
    c= thisColor;
  }
  //void opacity(){}
  void display(){
      opa -= 10;
      textFont(font,50);
      if(s>0){
        if(c == "Red")
        fill(255,0,0,opa);
        else if( c=="Blue")
        fill(0,0,255,opa);
        else if (c=="Green")
        fill(0,255,0,opa);
        text("+"+ s,x,height-190);
      }
      else if(s<0){
        fill(0,0,0,opa);
        text(s,x,height-190);
      }
      else{
      }
  }
}
