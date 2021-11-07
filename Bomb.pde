class Bomb{
  float x, y;
  int w, h;
  String c;
  float angle, angleAmount;
  float speed;
  float gravity;
  int bombScore;
  Bomb() {
    x = random(50, width-50);
    y = -100;
    angleAmount=random(-2,2);
    w = 120;
    h = 66;
    speed = random(2, 4);
    bombScore = -50;
    c= "Black";
  }
  void init(){
    x = random(50, width-50);
    y = -100;
    angleAmount=random(-2,2);
    speed = random(2, 4);
  }
  void move() {
   if (y>height) {
      x = random(50, width-50);
      y = -100;
      angleAmount=random(-2,2);
      if( 30<= gameTimerSec && gameTimerSec <= 40)
        speed = random(2,4);
      else if( 20<=gameTimerSec && gameTimerSec<30)
        speed = random(5,8);
      else if(10<=gameTimerSec && gameTimerSec<20)
        speed = random(9,11);
      else
        speed = random(12,15); 
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
      bombSound.rewind();
      bombSound.play();
      score += bombScore;
      scoreText = new ScoreText(bombScore, x, c);
      x = random(50, width-50);
      y = -100;
      angleAmount=random(-2,2);
      if( 30<= gameTimerSec && gameTimerSec <= 40)
        speed = random(2,4);
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
    image(candyBlack, 0, 0, w, h);
    popMatrix();
  }
}
