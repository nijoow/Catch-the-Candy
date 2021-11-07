
import SimpleOpenNI.*;      // kinect
SimpleOpenNI kinect;        //

import processing.serial.*; // arduino
import cc.arduino.*;        // `
Arduino arduino;            //
Serial myPort;              //

import processing.video.*;  // video
Movie gameOverRedVideo;
Movie gameOverBlueVideo;

import ddf.minim.*;         // sound
Minim minim;
AudioPlayer gameStartBGM;
AudioPlayer gameOnBGM;
AudioPlayer gameOverBGM;
AudioPlayer candySound;
AudioPlayer bombSound;

PFont font;
PImage gameStartBG, gameName, backGround, scoreTime,candyBlue,candyRed,candyGreen,candyBlack, basketRed, basketBlue;
int startTimer = 240;
int maxStartTimer = 240;
int startTimerSec;

int gameTimer = 240;
int maxGameTimer = 240;
int gameTimerSec;

int gameOverTimer = 1080;
int maxGameOverTimer =1080;

int score = 0;
boolean gameStart, gameOver;
float userPosX,basketX,basketY;
Candy[] candys = new Candy[6];
Bomb bomb;
Basket basket;
GameStartText gameStartText;
ScoreText scoreText;
float candyX;
float candyY;
float bombX = random(40, 700);
float bombY = 0;
int redIlluminanceInt, blueIlluminanceInt;  // arduino
String selectBasket = "";
void setup() {
  //fullScreen(P2D);
  size(1920,1080);
  background(100);
  gameName = loadImage("gameName.png");
  gameStartBG = loadImage("gameStartBG.png");
  backGround = loadImage("backGround.png");
  scoreTime = loadImage("scoreTime.png");
  candyRed = loadImage("candyRed.png");
  candyBlue = loadImage("candyBlue.png");
  candyGreen = loadImage("candyGreen.png");
  candyBlack = loadImage("candyBomb.png");
  basketRed = loadImage("basketRed.png");
  basketBlue = loadImage("basketBlue.png");
  
  font= createFont("Pixellari.ttf",100);
  
  minim = new Minim(this);
  candySound = minim.loadFile("candy.mp3");
  bombSound = minim.loadFile("bomb.mp3");
  gameStartBGM = minim.loadFile("gameStartBGM.mp3");
  gameOnBGM = minim.loadFile("gameOnBGM.mp3");
  gameOverBGM = minim.loadFile("gameOverBGM.mp3");
  frameRate(30);
  smooth();
  imageMode(CENTER);
  rectMode(CENTER);
  
  textAlign(CENTER,CENTER);
  gameStart = false;
  gameOver = false;
  for (int i=0; i<candys.length; i++) {
    candys[i] = new Candy();
  }
  bomb = new Bomb();
  gameStartText = new GameStartText();
  userPosX = width/2;
  basketX= width/2;
  basketY=height-100;
  //myPort = new Serial(this, "COM11", 9600);  // arduino
  //myPort.clear();                            //
  //myPort.bufferUntil('\n');                  //
  //kinect = new SimpleOpenNI(this);           // kinect
  //kinect.enableDepth();                      //
  //kinect.enableUser();                       //
  
  gameOverRedVideo = new Movie(this, "gameOverRedVideo.mov");
  gameOverBlueVideo = new Movie(this, "gameOverBlueVideo.mov");
}

void draw() {
  println(redIlluminanceInt, blueIlluminanceInt);
  if(gameStart == false && gameOver == false ){
    image(gameStartBG,width/2, height/2, width, height);
    image(gameName,width/2, height/2-200, 1428, 226);
    gameStartText.move();
    gameStartText.opacity();
    gameStartText.display();
    fill(0,100);
    rect(300,height/2+200,400,300);
    rect(width-300,height/2+200,400,300);
    image(basketRed,300,height/2+200,500,500);
    image(basketBlue,width-300,height/2+200,500,500);
    if(gameStartBGM.isPlaying()==false){
      gameStartBGM.rewind();
    }
    gameStartBGM.play();
    gameOverBGM.pause();
    gameOverBGM.rewind();
    
    score = 0; 
    gameOverTimer = maxGameOverTimer;
    scoreText = new ScoreText(0,0,"");
    //if(redIlluminanceInt > 300 && blueIlluminanceInt < 300 ){         // arduino                                                //
    //  selectBasket = "red";                                           //
    //}                                                                 //
    //else if(blueIlluminanceInt > 300 && redIlluminanceInt < 300){     //
    //  selectBasket = "blue";                                          //
    //}                                                                 //
     if(selectBasket=="red"){                                        
       basket = new Basket(selectBasket);                                  
       gameStart = true;
     }
     else if(selectBasket=="blue"){
       basket = new Basket(selectBasket);
       gameStart = true;
     }
  }
  //kinect.update();                           // kinect
  //IntVector userList = new IntVector();      //
  //kinect.getUsers(userList);                 //
  //if (userList.size() > 0) {                 //
  //  int userId = userList.get(0);            //
  //  if (kinect.isTrackingSkeleton(userId))   // 
  //    drawSkeleton(userId);                  //
  //}                                          //
  
  if(gameStart == true && gameOver == false){
    gameStartBGM.pause();
    gameStartBGM.rewind();
    gameOnBGM.play();
    image(backGround,width/2, height/2, width, height);
    fill(59,20,93);
    textFont(font,80);
    text(score, 180, 214);
    gameTimerSec = floor(gameTimer/60)%60;
    text(gameTimerSec, width-140, 214);
    textFont(font,100);
    fill(255);
    startTimerSec = floor(startTimer/60)%60;
    if(startTimerSec < 4 && startTimerSec > 0)
    text(startTimerSec, width/2, height/2);
    startTimer -= 2;
    //basketX=userPosX;                        // kinect
    basketX=mouseX;                        // mouse play
    basketY=height-100;
    basket.display();
    if(startTimerSec < 1 && startTimerSec >= 0)
    text("Game Start!", width/2, height/2);
    if(startTimerSec <= 0){
      for (int i=0; i<candys.length; i++) {
        candys[i].move();
        candys[i].display();
        candys[i].catched();
      }
      bomb.move();
      bomb.display();
      bomb.catched();
      basket.display();
      scoreText.display();
      
      image(scoreTime,width/2, height/2, width, height);
      fill(59,20,93);
      textFont(font,80);
      text(score, 180, 214);
      gameTimerSec = floor(gameTimer/60)%60;
      text(gameTimerSec, width-140, 214);
      noFill();
      gameTimer -= 2;
      if(gameTimer <= 0){
        gameStart = false;
        gameOver = true;        
      } 
    }
  }
  
  if(gameStart == false && gameOver == true){
    startTimer = maxStartTimer; 
    gameTimer = maxGameTimer;
        score = 0; 
        for (int i=0; i<candys.length; i++) {
          candys[i].init();
        }
    bomb.init();
    
    gameOverTimer -=2;
    if(gameOverTimer <= 1080 && gameOverTimer >= 900){
      image(backGround,width/2, height/2, width, height);
      fill(59,20,93);
      textFont(font,80);
      text(score, 180, 214);
      text("0", width-140, 214);
      textFont(font,100);
      fill(255,0,0);
      if(gameOverTimer<=1080 && gameOverTimer >=1040){
        text("GAME OVER", width/2, height/2);
      }
      if(gameOverTimer<=1020 && gameOverTimer >=980){
        text("GAME OVER", width/2, height/2);
      }
      if(gameOverTimer<=960 && gameOverTimer >=900){
        text("GAME OVER", width/2, height/2);
      }
    }
    if(selectBasket=="red" && gameOverTimer < 900){
      gameOverRedVideo.play();
      if(gameOverTimer <=600){
        gameOverBGM.play();
        gameOnBGM.pause();
        gameOnBGM.rewind();
      }
      image(gameOverRedVideo,width/2,height/2);
    }
    if(selectBasket=="blue" && gameOverTimer < 900){
      gameOverBlueVideo.play();
      if(gameOverTimer <=600){
        gameOverBGM.play();
        gameOnBGM.pause();
        gameOnBGM.rewind();
      }
      image(gameOverBlueVideo,width/2,height/2);
    }
    
    
    //if(redIlluminanceInt < 300 && blueIlluminanceInt < 300 && gameOverTimer <=0){         // arduino
    //selectBasket="";
    //gameOver= false; 
    //gameOverRedVideo.pause();
    //gameOverBlueVideo.pause();
    //gameOverRedVideo.jump(0);
    //gameOverBlueVideo.jump(0);
    //}                                                                 
  }
}

void mousePressed() {                                              // mouse play
  if(gameStart == false && gameOver ==false){
    if(mouseY > height/2+150 && mouseY < height/2+650){
      if(mouseX > 250 && mouseX < 750){
        selectBasket = "red";
      }
      if(mouseX > width-750 && mouseX < width-250){
        selectBasket = "blue";
      }
    }
  }
    
  if(gameStart == false && gameOver ==true && gameOverTimer <=0){
    selectBasket="";
    gameOverRedVideo.pause();
    gameOverBlueVideo.pause();
    gameOverRedVideo.jump(0);
    gameOverBlueVideo.jump(0);
    gameOver = false;
  }
  
}
void movieEvent(Movie m) {
  m.read();
}

//// kinect
//void drawSkeleton(int userId) {
//  noStroke();

// fill(255,0,0);
// drawJoint(userId, SimpleOpenNI.SKEL_HEAD);
//}

//void drawJoint(int userId, int jointID) {
// PVector joint = new PVector();

// float confidence = kinect.getJointPositionSkeleton(userId, jointID,
//joint);
// if(confidence < 0.5){
//   return;
// }
// PVector convertedJoint = new PVector();
// kinect.convertRealWorldToProjective(joint, convertedJoint);
// userPosX = map(convertedJoint.x,0,640, 0,1600);
 
//}

//void onNewUser(SimpleOpenNI kinect, int userID){
//  println("Start skeleton tracking");
//  kinect.startTrackingSkeleton(userID);
//}


////  arduino
//void serialEvent (Serial myPort) 
//{
//    try {
//        String data = myPort.readStringUntil('\n');
//            if (data == null) {
//            return;
//        }
//        int commaIndex = data.indexOf(",");
//        String redIlluminance  = data.substring(0, commaIndex);
//        String blueIlluminance = data.substring(commaIndex+1, data.length()-1);
           
//        redIlluminanceInt = StringToInt(redIlluminance);
//        blueIlluminanceInt = StringToInt(blueIlluminance);
//    } catch(RuntimeException e) {}
   
//}
//int StringToInt(String string)
//{
//    int value = 0;
//    for(int i = 0; i < string.length(); ++i) {
//        if(string.charAt(i) >= '0' && string.charAt(i) <= '9') {
//            value *= 10;
//            value += (string.charAt(i) - '0');
//        }}
//     return value;
//}
