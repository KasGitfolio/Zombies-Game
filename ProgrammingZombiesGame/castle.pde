class Castle
{
  int x; //position of castle x axis
  int y; //position of castle y axis
  int size; //size of castle
  int lives = 6; //player starts with 6 lifes
  PImage heart = loadImage("heart.png"); //initialises heart image for lifes
  PImage castle = loadImage("castle1.png"); //initialises castle image

  Castle(int x, int y) //constructor
  {
    this.x = x;
    this.y = y;
    size = 400;
  }
  void display() //displays castle
  {
    castle.resize(200, 400);
    image(castle, 600, 10);
  }
  void displayLives() { //displays lives
    heart.resize(20, 20);
    for (int i = 0; i<lives; i++) {
      image(heart, 10*(i+1), 10);
    }
  }

  boolean crashCheck(ArrayList<Enemy> enemies) {
    boolean t = false;

    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);

      if (this.x - 100 <= enemy.x) {

        //enemyB doesnt remove lives
        if (enemy instanceof EnemyB) {
          delEnemy = i;
          t = true; //still counts as a collision
          break;
        }

        //else removes life if its enemyA
        delEnemy = i;
        lives -= 1;
        t = true;
        break;
      }
    }
    return t;
  }
}
