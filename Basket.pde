class Basket{
   float x, y;
   int w, h;
   String c;
   
   Basket(String basketColor){
     x = basketX;
     y = basketY;  
     w = 300;
     h = 300;
     c = basketColor;
   }
   void display(){
     x = basketX;
     if(c == "red"){
     image(basketRed,x,y,w,h);
     }
     else if(c == "blue")
     image(basketBlue,x,y,w,h);
   }
}
