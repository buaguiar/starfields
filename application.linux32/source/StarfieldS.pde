import ddf.minim.*;
import java.io.*;
import java.util.*;

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

// SETUP E SEUS MÉTODOS ***************************************************
void setup() {
  size(800, 800);
 setupEstrelas();
 PFont font = loadFont("fonte.vlw");
  textFont(font);
  setupImagemCometa();
  setupImagemNave();
  
}

void setupEstrelas() {
   estrela = new Star[nStar];
  for (int i = 0; i < nStar; i++) {
    estrela[i] = new Star(random( width ), random( height ), random( 10 ));
  }
}

void setupImagemCometa() {
  PImage imgCometa = loadImage("meteorito.png");
  cometa = new Cometa( width + imgCometa.width/2, height/2, 5, imgCometa);
  frameRate(30); // FPS
  smooth();
}

void setupImagemNave() {

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

// DRAW E SEUS MÉTODOS ******************************************************


final int estadoMenu = 0;
final int estadoStarfield = 1;
final int estadoGameOver = 5;
final int estadoTOP3 = 3;
final int estadoDificuldade = 4;

int estado = estadoMenu;
int explo_count = 0;
int cometa_explo_count = 0;


void draw() {
  
  
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

void keyPressed() {
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

void keyPressedEstadoMenu() {
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

void keyPressedEstadoStarField() {
  
  switch(key) {
  case '1':
    estado = estadoMenu;
    break;
  }
    
}

void keyPressedEstadoTOP3() {
  
  switch(key) {
  case '2':
    estado = estadoStarfield;
    break;
   
   default:
      estado = estadoMenu;
      break;
  }
}

void keyPressedEstadoDificuldade() {

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

void drawScores() {
  background(0);
  drawStar();
  
  String pontuacoes[] = loadStrings("scores.txt");
  
  
  textSize(50);
  text("TOP 3 - Melhores Resultados", 150, 150);
  
  textSize(30);
  text(" 1º:   " + pontuacoes[0] + "  pontos", 300, 250);
  
             
  textSize(30);
  text(" 2º:   " + pontuacoes[1] + "  pontos", 300, 350);
             
  textSize(30);
  text(" 3º:   " + pontuacoes[2] + " pontos", 300, 450);
  
    textSize(25);
    text(" jogar / retornar ao jogo :  press '2'\n retornar ao menu :  press any key", 230, 650);
}

void escolherDificuldade() {
  
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

void drawMenu() {
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

void starfieldGameOverMenu() {
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


void drawStar() {
  for (int i = 0; i < nStar; i++) {
    frameRate(velocidadeEstrela); // FPS... mas aqui usei para controlar a velocidade das estrelas
    stroke(estrela[i].z * 25); // desenha os contornos para as estrelas 
    point(estrela[i].x, estrela[i].y); // desenha um ponto... que é a estrela
    strokeWeight(3); // tamanho da estrela
    estrela[i].x -= estrela[i].z;
 
    if (estrela[i].x < 0) {
      estrela[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
}

int maxScore() { 
  
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