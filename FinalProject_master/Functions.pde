
void mousePressed(){
  
  if (gameState == TITLE){ //the typing input doesn't work in draw so, I'm switching the order of the states for a bit
   
   //remove the TITLE thing for now becuase it throws eveyrthing off *sigh*
      gameState = PHASE_1;
  }
  
  if (gameState == PHASE_1){ 
    
    if (bubbles.size() < 1200){
    
      counter++;
     bubbles.add(new Bubble());
    }
  }
}

void mouseDragged(){
  
  if (gameState == PHASE_1){
   
    if (bubbles.size() < 1200){
      
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

  fill(255);
  textSize(45);
  text("c u r e", width/2, height/2);
}

void drawHub(){
 fill(255);
 textSize(25);
 text("cure development: " + round((counter/efficiency) * 100) + "%", RIGHT, 50 ); 
 
 fill(255, 255, 255, 127);
 textSize(28);
 text("Click and drag to create the anti-virus' molecular structure", RIGHT, 75);
}
