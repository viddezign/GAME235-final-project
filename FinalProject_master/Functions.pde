
void mousePressed(){  
  
  if (gameState == PHASE_1 || gameState == PHASE_2){ 
    
    if (bubbles.size() < 750){
    
      counter++;
      bubbles.add(new Bubble());
    }
  }
 
 if(gameState == INTERIM){
   
   development = false;
   gameState = PHASE_2;
 }
}

void mouseDragged(){
  
  if (gameState == PHASE_1 || gameState == PHASE_2){
   
    if (bubbles.size() < 750){
      
      counter++;
      bubbles.add(new Bubble());
    }
  }
}

//Bubble Interactions
void bubInteractions(){
  
  //bubble interactions
  for (Bubble tempBub : bubbles){
    
    PVector acceleration = new PVector(0, 0);
    
    
    for (Bubble otherBub : bubbles){
      
      if (tempBub != otherBub){
    
      PVector xY = new PVector();
     
      xY.x = otherBub.position.x - tempBub.position.x;
      xY.y = otherBub.position.y - tempBub.position.y;
      
      float distance = sqrt(xY.x* xY.x + xY.y * xY.y);
      
      //super short line so I'm keeping it inline
      if (distance < 1){  distance = 1; }
      
      float force = (distance - 300)* (otherBub.mass/distance);
      
      acceleration.x += force * xY.x;
      acceleration.y += force * xY.y;
    }
  
  //mouse interactions
  
  PVector xY2 = new PVector();
  
  xY2.x = mouseX - tempBub.position.x;
  xY2.y = mouseY - tempBub.position.y;
  
   float distance = sqrt(xY2.x*xY2.x + xY2.y * xY2.y);
   
   if (distance < 20) {
     
     distance = 20;
   }
   
   if (distance > 30){
     
     distance = 30;
   } 
   
   float force = (distance-30)/(3*distance);
   acceleration.x += force * xY2.x;
   acceleration.x += force * xY2.y;
  }
  
  
  tempBub.velocity.x = tempBub.velocity.x * visc + acceleration.x * tempBub.mass;
  tempBub.velocity.y = tempBub.velocity.y * visc + acceleration.y * tempBub.mass;
}
}

void drawTitle(){
  
  fill(255, 255, 255, 67);
  textSize(20);
  text("t h e", width/2 + 200, height/2 - 135);
  
  fill(255, 255, 255, 67);
  textSize(50);
  text("c u r e", width/2 + 160, height/2 - 105);
  
  fill(255, 255, 255, 127);
  textSize(50);
  text("c u r e", width/2 + 155, height/2 - 100);

  fill(255, 255, 255, 225);
  textSize(50);
  text("c u r e", width/2 + 150, height/2 - 95);
 
}

void spawn(FFT thisFFT){
  

     thisFFT = fft;
     
     int time = (65 - millis()/1000); 
     
     for(int i = 0; i < fft.specSize(); i++){
    
       if( fft.getBand(i)*10000 > 536.3 && fft.getBand(i)*1000 < 536.8 ){
         
         if(gameState == PHASE_2 && limit < 7 && time < 55){        
           
           limit++;
           crosshairs.add(new Crosshair());
         }
       }
     }
   }
   
void drawHub(){
 
 if(gameState == PHASE_1){
   
    fill(255);
    textSize(25);
    text("CURE DEVELOPMENT: " + round((counter/efficiency) * 100) + "%", RIGHT, 50 ); 
 
    fill(255, 255, 255, 127);
    textSize(25);
   
   text("Click and drag to create the anti-virus' molecular structure", RIGHT, 80);
 }
 
 if(gameState == INTERIM){ //cahnge to interim <-- for intstructions
   
    fill(255);
    textSize(25);
    text("CURE DEVELOPMENT: " + round((counter/efficiency) * 100) + "%", RIGHT, 50 ); 
 
    fill(255, 255, 255, 127);
    textSize(25);
   
    text("Proceeding to the DURABILITY TEST...", RIGHT, 80);
   
    fill(255, 255, 255, 127);
    text("Click anywhere to begin", RIGHT, 110);
 }
 
 if(gameState == PHASE_2){
   
    spawn(fft);
     
    fill(255);
    
    if (counter < 525){
      
      fill(255, 0 ,0);
    }
    
    
    textSize(25);
    text("DURABILITY: " + round((counter/efficiency) * 100) + "%", RIGHT, 50 ); 
    
    fill(255);
    
    int time = 60 - (millis()/1000);
    text("TIME REMAINING: " + time + " s", RIGHT, height - 50); 
    
    if(time == 0){
       
      gameState = END;
    }
 
   fill(255, 255, 255, 127);
   textSize(25);
   
   text("Cross hairs will destroy the anti-virus and reduce its durability.", RIGHT, 80);
   
   fill(255);
   text("Durability MUST stay above 70%", RIGHT, 110);
   
   textSize(18);
   fill(255, 255, 255, 127);
   text("...Our survival depends on it, Dr. " + userName+ ".", RIGHT, 130); 
  }
}

void drawReport(){
  
    background(0);
    
    drawTitle();
    
    textSize(25);
    
    if (round((counter/efficiency) * 100) > 70){
       
      fill(255);
      text("You've done it, Dr. " + userName, RIGHT, 110);
   
      text("We may come out of this  alive yet.", RIGHT, 130);  //TODO fade this over time
       
    }
    
    else if(round((counter/efficiency) * 100) < 70){
      
      fill(255);
      
      text("You've  failed Dr. " + userName, RIGHT, 110);
   
      text("There are  no more resrouces available to recreate the cure.", RIGHT, 130);
      
      text("We are lost.", RIGHT, 175);      
      text("...we will die like dogs", RIGHT, 200);
      
    } 
}
