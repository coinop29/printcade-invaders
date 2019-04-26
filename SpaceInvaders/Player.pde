class Player {
  float xpos; float ypos;
  color playerColor = color(255);
  boolean killed = false;
  int deathAnimationCounter = -1;
  int deathAnimationFrames = 50;
  
  PImage explosionImage;
  
  Player(){
    xpos = SCREENX/2;
    ypos = SCREENY - MARGIN;
    explosionImage = loadImage("exploding.GIF");
  }
  
  //Move the player
  void move() {
    if (!killed) {
      if(movingLeft1 == true && xpos>=PLAYER_WIDTH/2+SCREEN_BORDER){
        if(currentPowerUp == 1){ 
          xpos-= 12;
        }
        else{
          xpos-=12;
        }
      }
      if(movingRight1 == true && xpos<= SCREENX-PLAYER_WIDTH/2-SCREEN_BORDER){
        if(currentPowerUp == 1){
          xpos+=12;
        }
        else{
          xpos+=12;
        }
      }
    }
  }
  
  //Draw the player
  void draw(){
    if (killed == false) {
      // Draw the player
      fill(playerColor);
      noStroke();
      ellipse(xpos,SCREENY-MARGIN,PLAYER_WIDTH/2,PLAYER_HEIGHT/2);
      rect(xpos-PLAYER_WIDTH/2,ypos,PLAYER_WIDTH,PLAYER_HEIGHT/2);
      rect(xpos-PLAYER_WIDTH/8,ypos-PLAYER_WIDTH/2,PLAYER_WIDTH/4,PLAYER_HEIGHT);
    } else {
      // Was killed
      
      // Draw the dead player
      image(explosionImage, xpos-explosionImage.width/2, ypos-explosionImage.height/2);
      
      // Decrement the animation counter
      deathAnimationCounter--;
      
      // Check if the death animation should end
      if (deathAnimationCounter <= 0) {
        // Time to continue the game
        killed = false;
        deathAnimationCounter = -1;
        bottomHit = true;
        gameSetup = true;
      }
 
      
    }
  }
  
  //See if the player has been shot
  void explode(Projectile invaderProjectile){
    if(invaderProjectile.xpos <= xpos+PLAYER_WIDTH/2 && invaderProjectile.xpos >= xpos-PLAYER_WIDTH/2 && invaderProjectile.ypos>= ypos-PLAYER_HEIGHT  && invaderProjectile.ypos <= ypos+PLAYER_HEIGHT){
      // Mark the player as killed, and start the death animation
      killed = true;
      deathAnimationCounter = deathAnimationFrames;
    }
  }
}
