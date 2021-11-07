class Candy {
  float x, y;
  int w, h;
  String c;
  float angle, angleAmount;
  float speed;
  float gravity;
  int candyScore, rand;
  Candy() {
    x = random(50, width-50);
    y = random(-width/2 , 0); 
    angleAmount=random(-2,2);
    w = 120;
    h = 66;
    speed = random(2, 4);
    
    rand = (int)random(1, 5);
    if (rand == 1)
      c = "Red";
    else if (rand == 2 )
      c = "Blue";
    else if (rand == 3 )
      c = "Green";
    if(selectBasket=="red" && rand ==4)
      c = "Red";
    if(selectBasket=="blue" && rand ==4)
      c = "Blue";
    
  }
  void init(){
    x = random(50, width-50);
    y = random(-width/2 , 0); 
    speed = random(2, 4);
    rand = (int)random(1, 5);
    if (rand == 1)
      c = "Red";
    else if (rand == 2 )
      c = "Blue";
    else if (rand == 3 )
      c = "Green";
    if(selectBasket=="red" && rand ==4)
      c = "Red";
    if(selectBasket=="blue" && rand ==4)
      c = "Blue";
  }
  void move() {
    if (y>height) {
      x = random(50, width-50);
      y = -100;
      angleAmount=random(-2,2);
  
      if( 30<= gameTimerSec && gameTimerSec <= 40)
        speed = random(2, 4);
      else if( 20<=gameTimerSec && gameTimerSec<30)
        speed = random(5,8);
      else if(10<=gameTimerSec && gameTimerSec<20)
        speed = random(9,11);
      else
        speed = random(12,15); 
        
      rand = (int)random(1, 5);
      if (rand == 1)
        c = "Red";
      else if (rand == 2 )
        c = "Blue";
      else if (rand == 3 )
        c = "Green";
      if(selectBasket=="red" && rand ==4)
        c = "Red";
      if(selectBasket=="blue" && rand ==4)
        c = "Blue";
    }
    if( 30<= gameTimerSec && gameTimerSec <= 40)
      gravity = 0.04;
    else if( 20<=gameTimerSec && gameTimerSec<30)
      gravity = 0.07;
    else if(10<=gameTimerSec && gameTimerSec<20)
      gravity = 0.09;
    else
      gravity = 0.12;
    y += speed;
    speed += gravity;
  }
  void catched() {
    if ( y + 30 > basketY &&
      x > basketX - 100 &&
      x < basketX + 100) {
      candySound.rewind();
      candySound.play();
      int randomScore = (int)random(1,4);
      candyScore =10*randomScore;
      score += candyScore;
      scoreText = new ScoreText(candyScore, x, c);
      x = random(50, width-50);
      y = -100;
      angleAmount=random(-2,2);
      if( 30<= gameTimerSec && gameTimerSec <= 40)
        speed = random(2, 4);
      else if( 20<=gameTimerSec && gameTimerSec<30)
        speed = random(5,8);
      else if(10<=gameTimerSec && gameTimerSec<20)
        speed = random(9,11);
      else
        speed = random(12,15); 
    }
  }
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    angle += angleAmount;
    if(c=="Red")
    image(candyRed, 0, 0, w, h);
    else if(c=="Blue")
    image(candyBlue, 0, 0, w, h);
    else if(c=="Green")
    image(candyGreen, 0, 0, w, h);
    popMatrix();
  }
}
