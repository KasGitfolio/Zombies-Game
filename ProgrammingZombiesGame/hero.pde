class Hero
{ //initialisation of variables and objects
  float x; //position of hero
  float y;
  float speed; //speed of hero
  int size = 60; //size of hero
  float targetX, targetY; //target of hero
  boolean moving = false; //tracks if hero is moving
  int score; // player score
  PImage heroImg; //hero image initialisation
  boolean facingRight = false; //used to flip hero

  //constructors
  Hero(int x, int y, float speed)
  {
    this.x = x;
    this.y = y;
    this.targetX = x;
    this.targetY = y;
    this.speed = speed;
    this.moving = false;
    heroImg = loadImage("hero.png");
    heroImg.resize(size, size);
  }
  void resetHeroPos(){ //new starting position if game is restarted
    x = width-250;
    y = height/2;
    
  }

  void display()
  {
    pushMatrix(); //saves hero coordinates
    translate(x, y); //displays hero at its x,y position

    if (!facingRight) {
      scale(-1, 1); //flips hero horizontally
    }
    imageMode(CENTER);
    image(heroImg, 0, 0);
    imageMode(CORNER);
    popMatrix(); //restores original coordinates
  }

  void update()
  {
    if (moving)
    { //calculates distance to move to
      float dx = targetX - x;
      float dy = targetY - y;
      float distance = dist(x, y, targetX, targetY);
      //moves to target at varibale speed
      if (distance > speed)
      {
        float angle = atan2(dy, dx);
        x += cos(angle) * speed;
        y += sin(angle) * speed;
      }
    }
  }
  //}
  //new location target where mouse is clicked
  void NewLoc(float tx, float ty)
  {
    targetX = tx;
    targetY = ty;
    moving = true;
    facingRight = (tx >= x); //decides hero facing direction
  }
  //player score
  void pScore()
  {
    fill(0);
    textSize(15);
    text("Score: " + score, 150, 25);
  }
  //increases player score
  void score()
  {
    score +=1;
  }
  //checks for collision between hero and enemy
  boolean enemyCrash(ArrayList<Enemy> enemies) {
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      //stores index of enemy if distance between enemy is less than hero size
      if (dist(this.x, this.y, enemy.x, enemy.y) < enemy.size) {
        delEnemy = i;
        return true; //returns true if collision is detected
      }
    }
    return false; //returns false if theres no collision
  }
}
