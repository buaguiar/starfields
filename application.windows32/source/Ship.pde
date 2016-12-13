public class Ship {
  PImage img;
  int speed;
  int x;
  int y;
    public Ship( int x, int y, int speed, PImage img ) {
    this.speed = speed;
    this.x = x;
    this.y = y;
    this.img = img;
    }
      void draw() {
      pushMatrix();
      translate ( x, y );
      rotate(PI/2);
      img.resize(0,50);
      image( img, -img.width/2, -img.height/2 );
      popMatrix();
      }
        void up() {
        y -= speed;
        if ( y < img.height/2 ) { y = img.height/2; }
        }
        void down() {
        y += speed;
        if ( y > height - img.height/2 ) { y = height - img.height/2; }
        }
          public Box getBox() {  
            return new Box( x - img.width/2, y-img.height/2, x+img.height/2, y+img.height/2);
          }
}