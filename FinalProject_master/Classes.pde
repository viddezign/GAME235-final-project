/* TODO BIG BUBBLE/SWARM classs <--run everything through a for each function 
 for movement <-- hmm might not go in this direction
 */

abstract class Entity {

  abstract void update();
  abstract void render();
}

class Bubble extends Entity {

  PVector position;
  PVector velocity;
  float mass;
  color bubColor;
  float radius;

  Bubble() {

    position = new PVector(mouseX, mouseY);
    //velocity = new PVector(0,0); //hmm might be 0 so pick a different range
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    bubColor = color(255, 255, 255, 67);
    //radius = random(10, 25); //add in render for cool continuous effect
    mass = random(0.002, 0.02);
    radius = mass*1500;
  }

  void update() {
    render();
    move();
    collisionCheck();
    destroy(bubbles);
    spawn(fft);
  }

  void render() {

    fill(bubColor);
    noStroke();
    ellipse(position.x, position.y, radius, radius);
  }

  void move() {

    position.x += velocity.x;
    position.y += velocity.y;
  }

  void collisionCheck() {

    if (position.x > width - radius || position.x < radius) {

      velocity.x *= -1;
    }

    if (position.y > height - radius || position.y < radius) {

      velocity.y *= -1;
    }
  }  

  //empty method for child  inheritence
  void destroy(ArrayList<Bubble> targets) {
  }
}

//for intro animation, same base, different behavior for intro  <--LAST
class Intro_Bubble extends Bubble {
}

//NOTE: anti-virus will move toward the  moving crosshairs
class Crosshair extends Bubble {

  int opacity;
  boolean dying;

  Crosshair() {
    
    dying = false;

    bubColor = color(255, 0, 0); //red
    radius = 60;
    position = new PVector(random(radius, width - radius), random(radius, height - radius));
    opacity = 0;
  }


  void render(){
    
    dying = false;

    fill(bubColor, opacity);
    noStroke();
    ellipse(position.x, position.y, radius, radius); 

    stroke(bubColor, opacity);
    line(0, position.y, width, position.y);
    line(position.x, 0, position.x, height);
    
    opacity += oCounter;
    }

  

  void destroy(ArrayList<Bubble> targets) {


    if (opacity > 350) {//gameplay wasn't as challenging when I removed the crosshairs at max opacity
    
      oCounter = -1;
      dying = true; 
    }
      
   
      if(opacity > 255){
        
        for (int i = targets.size()-1; i > 0; i--) {

          Bubble tempBub = targets.get(i);

          PVector tempPos = tempBub.position;

          if (dist(position.x, position.y, tempPos.x, tempPos.y) < radius) {

            targets.remove(tempBub);
            counter--;
        }
      }
     }
  
     
       if(dying == true && opacity == 0){
         
         crosshairs.remove(this);
         limit--;
         oCounter = 1;
       }
  }
}
