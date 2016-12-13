import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import java.io.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class starfields extends PApplet {





AudioPlayer player;
Minim minim;//audio context

Star estrela[];
int nStar = 100;
int velocidadeEstrela = 25;
int score = 0;

Cometa cometa;
Ship ship;
Bala bala;

Starfield starfield;

PImage explo;
PImage gold;
PImage silver;
PImage bronze;

// SETUP E SEUS M\u00c9TODOS ***************************************************
public void setup() {
  
 setupEstrelas();
 PFont font = loadFont("fonte.vlw");
  textFont(font);
  setupImagemCometa();
  setupImagemNave();
  
}

public void setupEstrelas() {
   estrela = new Star[nStar];
  for (int i = 0; i < nStar; i++) {
    estrela[i] = new Star(random( width ), random( height ), random( 10 ));
  }
}

public void setupImagemCometa() {
  PImage imgCometa = loadImage("meteorito.png");
  cometa = new Cometa( width + imgCometa.width/2, height/2, 5, imgCometa);
  frameRate(30); // FPS
  smooth();
}

public void setupImagemNave() {

  PImage simg = loadImage( "ship.png" );
  ship = new Ship( 100, height/2, 10, simg );
   
  explo = loadImage("Xd.png");
  explo.resize(0,70);
  bala = new Bala (20,10,240);
  bala.ativo = false;
  
  
  frameRate( 30 );
  smooth();
}


// **************************************************************************

// DRAW E SEUS M\u00c9TODOS ******************************************************


final int estadoMenu = 0;
final int estadoStarfield = 1;
final int estadoGameOver = 5;
final int estadoTOP3 = 3;
final int estadoDificuldade = 4;

int estado = estadoMenu;
int explo_count = 0;
int cometa_explo_count = 0;


public void draw() {
  
  
  switch(estado) {
    case estadoMenu:
             drawMenu();
             break;
     
     case estadoStarfield:
       
       background(0); // DESENHA O BACKGROUND
       drawStar(); // DESENHA AS ESTRELAS
       starfield =  new Starfield();
       break;
       
       case '3':
         
         break;
         
       case estadoTOP3:
         drawScores();
         break;
         
       case estadoDificuldade:
         escolherDificuldade();
         break;
         
       case estadoGameOver:
          starfieldGameOverMenu();
          break;
     
     default:
       
       exit();      
  }
}

public void keyPressed() {
  // keyboard. Also different depending on the state.
  switch (estado) {
  case estadoMenu:
    
    keyPressedEstadoMenu();
    break;
  
  case estadoStarfield:
   
    keyPressedEstadoStarField();
    break;
    
    case '3':
      keyPressedEstadoMenu();
      break;
      
    case estadoTOP3:
      keyPressedEstadoTOP3();
      break;
      
     case estadoDificuldade:
       keyPressedEstadoDificuldade();
       break;
  
  default:

    println ("Unknown state (in keypressed) "
      + estado
      + " ++++++++++++++++++++++");
    exit();
    break;
  
} // switch
  //
}

int count = 0;

public void keyPressedEstadoMenu() {
  //
  switch(key) {
  case '1':
    estado = estadoMenu;
    break;
  case '2':
    estado = estadoStarfield;
    break;
  case '3':
    count++;
    if (count%2 != 0) {
      minim = new Minim(this);
      player = minim.loadFile("ThePursuitOfVikings.mp3", 2048);
      player.play();
      estado = estadoMenu; 
    } else if ((count%2 == 0) && count != 0) {
      player.close();
      minim.stop();
    }
    break;
  
  case '4':
    estado = estadoTOP3;
    break;
  
  case '5':
    estado = estadoDificuldade;
    break;
  case 'x':
  case 'X':
    // quit
    exit();
    break;
  default:
    // do nothing
    break;
  }// switch
  //
}

public void keyPressedEstadoStarField() {
  
  switch(key) {
  case '1':
    estado = estadoMenu;
    break;
  }
    
}

public void keyPressedEstadoTOP3() {
  
  switch(key) {
  case '2':
    estado = estadoStarfield;
    break;
   
   default:
      estado = estadoMenu;
      break;
  }
}

public void keyPressedEstadoDificuldade() {

 switch(key) {
  case '2':
    estado = estadoStarfield;
    break;
  
  case 'f':
    cometa.setSpeed(2);
    break;
  
  case 'm':
    cometa.setSpeed(7);
    break;
    
  case 'l':
    cometa.setSpeed(15);
    break;
  case 'd':
    cometa.setSpeed(5);
    break;
  
   default:
      estado = estadoMenu;
      break;
  }
}

public void drawScores() {
  background(0);
  drawStar();
  
  String pontuacoes[] = loadStrings("scores.txt");
  
  
  textSize(50);
  text("TOP 3 - Melhores Resultados", 150, 150);
  
  textSize(30);
  text(" 1\u00ba:   " + pontuacoes[0] + "  pontos", 300, 250);
  
             
  textSize(30);
  text(" 2\u00ba:   " + pontuacoes[1] + "  pontos", 300, 350);
             
  textSize(30);
  text(" 3\u00ba:   " + pontuacoes[2] + " pontos", 300, 450);
  
    textSize(25);
    text(" jogar / retornar ao jogo :  press '2'\n retornar ao menu :  press any key", 230, 650);
}

public void escolherDificuldade() {
  
  background(0); // DESENHA O BACKGROUND
  drawStar();
             
  textSize(50);
  text("Escolher Dificuldade", 200, 150);
  
  textSize(30);
  text(" press 'f' :  Facil", 300, 250);
  
             
  textSize(30);
  text("press 'm':  Media", 300, 350);
             
  textSize(30);
  text("press 'l' :  Lendario", 300, 450);
  
  textSize(30);
  text("press 'd':  Default", 300, 550);
  
  textSize(25);
  text("DICA: Ao escolheres LENDARIO recebes 3 VEZES MAIS pontos!!!", 100, 650);
  
  
  
    textSize(25);
    text("                   Comandos:\njogar / retornar ao jogo :  press '2'\n retornar ao menu :  press any key", 250, 740);
}

public void drawMenu() {
             background(0); // DESENHA O BACKGROUND
             drawStar();
             
             textSize(90);
             text("S t a r f i e l d", 150, 150);
             
             textSize(30);
             text(" 1 - Menu ", 300, 250);
             
             textSize(30);
             text(" 2 - jogar ", 300, 350);
             
             textSize(30);
             text(" 3 - Reproduzir/fechar musica ", 300, 450);
             
             textSize(30);
             text(" 4 - Ver TOP 3", 300, 550);
             
             textSize(30);
             text(" 5 - Escolher Dificuldade", 300, 650);
             
             textSize(30);
             text(" X - Sair ", 300, 750);
}

public void starfieldGameOverMenu() {
     background(0); // DESENHA O BACKGROUND
     drawStar(); 
     
     textSize(90);
     text("Perdeste   :(", 170, 250);
             
     textSize(40);
     text("Score :  " + score + "  pontos", 230, 390);
     
     textSize(40);
     text("High Score :  " + maxScore() + "  pontos", 200, 500);
     
    // maxScore();
             
     textSize(30);
     text("Pressiona uma tecla para saires...", 185, 600);
     
 
}


public void drawStar() {
  for (int i = 0; i < nStar; i++) {
    frameRate(velocidadeEstrela); // FPS... mas aqui usei para controlar a velocidade das estrelas
    stroke(estrela[i].z * 25); // desenha os contornos para as estrelas 
    point(estrela[i].x, estrela[i].y); // desenha um ponto... que \u00e9 a estrela
    strokeWeight(3); // tamanho da estrela
    estrela[i].x -= estrela[i].z;
 
    if (estrela[i].x < 0) {
      estrela[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
}

public int maxScore() { 
  
  String pontuacoes[] = loadStrings("scores.txt");
  
  // printArray(pontuacoes);
  System.out.println(pontuacoes[0]);
   
   String[] auxScore = new String[3];
  
   
   //int count = 0;
  
    if ((Integer.parseInt(pontuacoes[0]) < score) && (Integer.parseInt(pontuacoes[1]) < score) && (Integer.parseInt(pontuacoes[2]) < score)){
     auxScore[0] = str(score);
     auxScore[1] = pontuacoes[0];
     auxScore[2] = pontuacoes[1];
     saveStrings("/data/scores.txt", auxScore);
     return score;
    }
    
    if ((Integer.parseInt(pontuacoes[0]) > score) && (Integer.parseInt(pontuacoes[1]) < score) && (Integer.parseInt(pontuacoes[2]) < score)) {
     auxScore[1] = str(score);
     auxScore[0] = pontuacoes[0];
     auxScore[2] = pontuacoes[1];
      return Integer.parseInt(auxScore[0]);
    }
    
    if ((Integer.parseInt(pontuacoes[0]) > score) && (Integer.parseInt(pontuacoes[1]) > score) && (Integer.parseInt(pontuacoes[2]) < score)) {
     auxScore[2] = str(score);
     auxScore[1] = pontuacoes[1];
     auxScore[0] = pontuacoes[0];
      return Integer.parseInt(auxScore[0]);
    }
    
    else return Integer.parseInt(pontuacoes[0]);
}

// *************************************************************************************************************
public class Bala{
  int x;
  int y;
  boolean ativo;
  
  public Bala(int s, int x,int y){
    this.x=x;
    this.y=y;
    this.ativo = true;
  }
  
  public void update(){
    if(ativo){
      x+= 20;
      if(x>width){
        ativo = false;
      }
    }
  }
  
  public void draw(){
    if(ativo){ 
        rect(x-20,y-20,20,20,10);
    }
  }
  
  public Box getBox(){
    return new Box(x-20,y-20,x+20,y+20);
  }
}
public class Box {
  int x1, x2;
  int y1, y2;
  Box( int x1, int y1, int x2, int y2 ) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
 
  public boolean isOverlap( Box b ) {
  if ((( x1 <= b.x1 && b.x1 <= x2 ) || ( x1 <= b.x2 && b.x2 <= x2 ))  && (( y1 <= b.y1 && b.y1 <= y2 ) || ( y1 <= b.y2 && b.y2 <= y2 ))) {
      return true;
  }
  return false;
  }
  
  public boolean contador(Box b) {
      if((( x1 <= b.x1 && b.x1 <= x2 ) || ( x1 <= b.x2 && b.x2 <= x2 ))  && (( y1 <= b.y1 && b.y1 <= y2 ) || ( y1 <= b.y2 && b.y2 <= y2 ))) { // EMENDAR
      return true;
    }
    return false;
  }
}
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
  
  public void update() {    
    alph-= 0.1f;    
    x -= speed;    
    if ( x < - img.width/2 ) {      
      reset();  
    }
  }
  public void reset() {
    x = width + img.width/2;
    y = PApplet.parseInt(random ( height - img.width )) + img.width/2;
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
 
  public void draw() {    
    pushMatrix();    
    translate ( x, y );    
    rotate( alph );   
    image( img, -img.width/2, -img.height/2 );
    img.resize(60, 60);
    popMatrix();
  }
}
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
      public void draw() {
      pushMatrix();
      translate ( x, y );
      rotate(PI/2);
      img.resize(0,50);
      image( img, -img.width/2, -img.height/2 );
      popMatrix();
      }
        public void up() {
        y -= speed;
        if ( y < img.height/2 ) { y = img.height/2; }
        }
        public void down() {
        y += speed;
        if ( y > height - img.height/2 ) { y = height - img.height/2; }
        }
          public Box getBox() {  
            return new Box( x - img.width/2, y-img.height/2, x+img.height/2, y+img.height/2);
          }
}
public class Star {  
  
  float x, y, z;  

  Star( float x, float y, float z ) {    
    this.x = x;    
    this.y = y;    
    this.z = z;
  }
}
public class Starfield {
  
  public Starfield() {
    drawStarField();
  }
  
  public void drawStarField() {
   
       bala.update(); //update na posi\u00e7\u00e3o
       bala.draw(); //desenha a bala
       cometa.draw();
       if ( key == ' ' && !bala.ativo ) {
         bala.x = ship.x + ship.img.width/2 - 20;
         bala.y = ship.y;
         bala.ativo = true;
       }
       
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
    text("Score :  " + score, 330, 70);
    textSize(20);
    text("Pause o Jogo voltando ao menu :  press '1' ", 200, 20);
    cometa.update();
     //if(explo_count == 0){
     // if ( keyPressed == true && key == CODED ) {
     //   if ( keyCode == UP ) {
     //     ship.up();
     //   } else if ( keyCode == DOWN ) {
     //     ship.down();
     //   }
     // }
     // ship.draw();
    //}else{
     // image(explo, ship.getBox().x1,ship.getBox().y1);
     // explo_count--;
    //}
    
    if(bala.getBox().contador(cometa.getBox())) {
      if (cometa.getSpeed() != 15) {
        score++;
      } else {
        score++;
        score *= 3;
      }
  }
   }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "starfields" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
