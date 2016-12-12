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
         
       case '4':
         
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
      
    case '4':
      keyPressedEstadoMenu();
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
    minim = new Minim(this);
    player = minim.loadFile("ThePursuitOfVikings.mp3", 2048);
    player.play();
    estado = estadoMenu;
    break;
  
  case '4':
    player.close();
    minim.stop();
   // super.stop();
    estado = estadoMenu;
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

void drawMenu() {
             background(0); // DESENHA O BACKGROUND
             drawStar();
             
             textSize(32);
             text("S T A R F I E L D", 250, 150);
             
             textSize(25);
             text(" 1 - Menu ", 300, 250);
             
             textSize(25);
             text(" 2 - jogar ", 300, 350);
             
             textSize(25);
             text(" 3 - Reproduzir musica ", 300, 450);
             
             textSize(25);
             text(" 4 - fechar musica ", 300, 550);
             
             textSize(25);
             text(" X - Sair ", 300, 650);
}

void starfieldGameOverMenu() {
     background(0); // DESENHA O BACKGROUND
     drawStar(); 
     
     textSize(90);
     text("Perdeste   :(", 170, 250);
             
     textSize(50);
     text("Score :  " + score, 275, 390);
             
     textSize(30);
     text("Pressiona uma tecla para saires...", 185, 500);
     
 
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

void maxScore() { // nao funciona nao sei porque
 
  try {
  
    File file = new File("pontuacoes");
    Scanner scf = new Scanner(file);
   
   int pontuacao[] = new int[1];
   int count = 0;
   while(scf.hasNextLine()) {
     pontuacao[count] = Integer.parseInt(scf.nextLine());
   }
    
    if (pontuacao[0] < score) {
      PrintWriter pw = new PrintWriter(file);
      pw.println(score);
      System.out.println(score);
      pw.close();
  }
    
    scf.close();
  
  } catch(FileNotFoundException e) {
    System.out.println("Ficheiro nao encontrado");
  }
}

// *************************************************************************************************************