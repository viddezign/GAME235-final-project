/* TODO BIG BUBBLE/SWARM classs <--run everything through a for each function 
 for movement <-- hmm might not go in this direction
*/

class Bubble{
  
  PVector position;
  PVector velocity;
  float mass;
  color bubColor;
  float radius;
  
  Bubble(){
    
    position = new PVector(mouseX,mouseY);
    //velocity = new PVector(0,0); //hmm might be 0 so pick a different range
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    bubColor = color(255, 255, 255, 67);
    //radius = random(10, 25); //add in render for cool continuous effect
    mass = random(0.002, 0.02);
    radius = mass*1500;
    
  }
  
 void update(){
   render();
   move();
   collisionCheck();
   
 }
 
 void render(){
   
   fill(bubColor);
   noStroke();
   ellipse(position.x, position.y, radius, radius);   
 }
 
 void move(){
   
   position.x += velocity.x;
   position.y += velocity.y;
   
 }
 
 //TODO: move to functions tab and remove bub if it goes outside
 void collisionCheck(){
   
     if (position.x > width - radius || position.x < radius){
      
      velocity.x *= -1;
    }
    
    if (position.y > height - radius || position.y < radius){
      
      velocity.y *= -1;
    }
 }  
}

//for intro animation, same base, different behavior for intro
class Intro_Bubble extends Bubble{
  
  
  
  
  
}
