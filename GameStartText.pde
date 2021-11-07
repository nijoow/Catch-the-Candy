class GameStartText{
  float x,y, w,h,amount, rectOpacity,textOpacity,opacityAmount;

  GameStartText(){
    x= width/2;
    y= height/2;
    //w = 400;
    //h = 200;
    w= 800;
    h =100;
    amount = 0.5;
    rectOpacity = 100;
    textOpacity = 255;
    opacityAmount = 5;
  }
  void move(){
    y+=amount;
    if( y >= height/2+10 || y<= height/2-10){
      amount*=-1;
    }
  }
  void opacity(){

    textOpacity -= opacityAmount;
    if(textOpacity >= 500 || textOpacity <= 0){
      opacityAmount*=-1;
    }
    
    float rectOpacityAmount;
    rectOpacityAmount  = map(opacityAmount,0,255,0,100);
    
    if(textOpacity>=255){
      rectOpacity = 100;
    }else{
      rectOpacity -= rectOpacityAmount;
    }
  }
  void display(){
    /*
    fill(0 ,0 ,0, rectOpacity);
    strokeWeight(2);
    stroke(255,255,255,rectOpacity);
    rect(x,y,w,h);
    noStroke();
    
    textFont(font,80);
    fill(0,0,0,textOpacity);
    text("START", x+4, y-26);
    text("GAME", x+4, y+34);
    fill(255,255,255,textOpacity);
    text("START", x, y-30);
    text("GAME", x, y+30);*/
    
    fill(0 ,0 ,0, rectOpacity);
    strokeWeight(2);
    stroke(255,255,255,rectOpacity);
    rect(x,y+200,w,h);
    noStroke();
    
    textFont(font,35);
    fill(0,0,0,textOpacity);
    text("PICK UP ONE BASKET TO START GAME",x+4,y+204);
    fill(255,255,255,textOpacity);
    text("PICK UP ONE BASKET TO START GAME",x,y+200);
    
    
    
  }
}
