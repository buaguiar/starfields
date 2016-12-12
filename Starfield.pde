public class Starfield {
  
  public Starfield() {
    drawStarField();
  }
  
  void drawStarField() {
   
       bala.update(); //update na posição
       bala.draw(); //desenha a bala
       
       if ( explo_count == 0 ) {
         if ( keyPressed == true && key == CODED ) {
           if ( keyCode == UP ) {
             ship.up();
           } else if ( keyCode == DOWN ) {
             ship.down();
           }
         }
         ship.draw();
       } else {
         image( explo, ship.getBox().x1, ship.getBox().y1 );
         explo_count--;
       }
       if ( ship.getBox().isOverlap( cometa.getBox())) {
         explo_count = 25;
         estado = estadoGameOver;
         maxScore();
         /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       }
       if ( bala.ativo && cometa.getBox().isOverlap( bala.getBox())) {
         cometa_explo_count = 2;
         bala.ativo = false;
       }
       if ( cometa_explo_count == 0 ) {
         cometa.update();
         cometa.draw();
       } else if ( cometa_explo_count == 1 ) {
         cometa.reset();
         cometa_explo_count--;
       } else {
         image( explo, cometa.getBox().x1, cometa.getBox().y1 );
         cometa_explo_count--;
       }
       
     
    textSize(32);
    text("Score :  " + score, 250, 150);
    cometa.update();
     if(explo_count == 0){
      if ( keyPressed == true && key == CODED ) {
        if ( keyCode == UP ) {
          ship.up();
        } else if ( keyCode == DOWN ) {
          ship.down();
        }
      }
      ship.draw();
    }else{
      image(explo, ship.getBox().x1,ship.getBox().y1);
      explo_count--;
    }
    if(ship.getBox(). isOverlap(cometa.getBox())) {
      explo_count = 30;//visto que 30fps para ficar ~1seg
       estado = estadoGameOver;
    }
    if(bala.getBox().contador(cometa.getBox())) {
      score++;
    }
    cometa.draw();
     if ( key == ' ' && !bala.ativo ) {
       bala.x = ship.x + ship.img.width/2 - 20;
       bala.y = ship.y;
       bala.ativo = true;
     }
   }
}