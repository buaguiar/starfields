public class Cometa {  
  
  int x;  
  int y;  
  int speed;  
  PImage img;  
  float alph;    
  
  Cometa( int x, int y, int speed, PImage img ) {    
    this.x = x;    
    this.y = y;    
    this.speed = speed;    
    this.img = img;    
    this.alph = 0;  
  }    
  
  void update() {    
    alph-= 0.1;    
    x -= speed;    
    if ( x < - img.width/2 ) {      
      reset();  
    }
  }
  public void reset() {
    x = width + img.width/2;
    y = int(random ( height - img.width )) + img.width/2;
  }
      
    public Box getBox() {
      return new Box( x - img.width/2, y-img.height/2, x+img.height/2, y+img.height/2);
    }
    
    public void setSpeed(int speed) {
      this.speed = speed;
    }
    
    public int getSpeed() {
      return speed;
    }
 
  void draw() {    
    pushMatrix();    
    translate ( x, y );    
    rotate( alph );   
    image( img, -img.width/2, -img.height/2 );
    img.resize(60, 60);
    popMatrix();
  }
}