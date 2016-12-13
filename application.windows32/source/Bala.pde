public class Bala{
  int x;
  int y;
  boolean ativo;
  
  public Bala(int s, int x,int y){
    this.x=x;
    this.y=y;
    this.ativo = true;
  }
  
  void update(){
    if(ativo){
      x+= 20;
      if(x>width){
        ativo = false;
      }
    }
  }
  
  void draw(){
    if(ativo){ 
        rect(x-20,y-20,20,20,10);
    }
  }
  
  public Box getBox(){
    return new Box(x-20,y-20,x+20,y+20);
  }
}