abstract class Enemy {
  //initialise variables
  float x; //enemy position
  float y; //enemy position
  float speedX; //speed of enenmy x axis
  float speedY; //speed of enemy y axis
  int size = 60; //enemy size
  PImage enemyImg; //initialisation of enemy image
  PImage deathImg; //initialisation of enemy death image
  int imgCounter = 0; //for animated enemy
  //death animation initalising
  boolean dying = false; //tracks to see if enemy is dying
  int deathTimer = 0;
  int deathDuration = 30; //for 30 frames it shows death image

  // Constructor
  Enemy(int x, float y) { //creates enemy at x, y position
    this.x = x;
    this.y = y;
  }
  // updates image and movement of enemy object
  void update(){
    if(dying)
    {
      deathTimer++;
    }
    else{
      move(); //moves enemy if still alive
    }
  }
  //display enemy
  void display() { //initialises enemy display but not called specific image, this will be in sub classes
    deathImg.resize(size, size);
    if(dying) //displays enemy death image if true
    {
      image(deathImg, x,y);
    }
    else{
      image(enemyImg, x, y);
    }
  }
  
  void die() //updates state of enemy when hero touches enemy
  {
    dying = true;
    speedX = 0; //stops movement
    speedY = 0;
    deathTimer = 0; //resets death timer
  }
  
  boolean removeDeath() //returns true when animation has finished
  {
    return dying && deathTimer > deathDuration;
  }
  //movement of enemy
  void move() {
    this.x += this.speedX;
    this.y += this.speedY;

    // bounce off walls and top/bottom of the screen
    if (this.x <= 0 || this.x > width) {
      this.speedX = -this.speedX;
    }

    if (this.y < 0 || this.y > height - 30) {
      this.speedY = -this.speedY;
    }
  }
}
