//Ernes Railey
//TODO add eerie music, refactor with switch statements
//FFT analyzer for spawning things based on frequency

import controlP5.*;

ControlP5 cp5;

String userName, submission;
int gameState;
boolean submitted;
boolean titleDebug;

static final int TITLE = 0;
static final int INTRO = 1;
static final int INTRO_2 = 2;
static final int PHASE_1 = 3;
static final int PHASE_2 = 4;
static final int END = 5;

ArrayList<Bubble> bubbles;

float visc;

float efficiency = 1200;

float counter;


void setup(){
  
  size(800, 800);
  background(50);
  
  titleDebug = false;
  
  userName = "";
  
  counter = 0;
  
  submitted = false;
  
  gameState = INTRO;
  
  cp5 = new ControlP5(this);
  
  bubbles = new ArrayList<Bubble>();
  
  visc = 0.8;
  
  userInput1();
}

void draw(){
  
  background(50);
 
   println(gameState);
    
  if (gameState == TITLE){
    
    drawTitle();
    
    cp5.remove("START");
    bubInteractions();
  }
  
    userInput2();
  
  if (gameState == PHASE_1){
    
  
    cp5.remove("START");
    bubInteractions();
  
  for (int i = bubbles.size()-1; i > 0; i--){
    
    bubbles.get(i).update();
  }
    drawHub(); 
  }
  
}
