Hero h1;
Castle c1;
//global objects and variables
int delEnemy; //to keep track of enemy that touches the player
ArrayList<Enemy> enemies = new ArrayList<Enemy>(); //stores all enemies in game
int enemyHit = 0; //enemy cooldown to hit enemy
String lifeMessage = ""; //lifes lost message initialisation
int lifeMessageTimer = 0; //lifes lost timer initialisation
PImage bg; //background initialisation
int highScore = 0; //high score initialisation from file
int gameState = 0; //0 = info screen, 1 = game running

void setup()
{
  size(800, 400);
  bg = loadImage("background.png");
  for (int i = 0; i < 5; i++) //adds 5 enemies when game is started
  {
    enemies.add(addEnemy());
  }
  //e1 = new Enemy(0, randY); //starts enemy from random point on y axis
  h1 = new Hero(width-250, height/2, 15); //initialises hero near castle
  c1 = new Castle(width-100, 0); //initialises castle at right side of screen
  String[] data = loadStrings("highscore.txt"); //loads high score file
  if (data != null) {
    highScore = int(data[0]);
  }
}

void draw()
{
  if (gameState == 0) { //shows info screen at start
    showInfoScreen();
    return; //stop the rest of draw() running
  }

  image(bg, 0, 0, width, height); //background image

  if (enemyHit > 0) enemyHit--; //decreases timer of enemy hit hero

  //updates and displays game objects
  c1.display(); 
  h1.display(); 
  h1.update(); 
  livesCheck(); 
  h1.pScore();

  //updates and displays all enemies
  for (int i = 0; i<enemies.size(); i++)
  {
    enemies.get(i).update();
    enemies.get(i).display();
  }

  if (c1.lives > 0) { //adds and removes enemies as long as player has above 0 lives
    if (h1.enemyCrash(enemies))
    {
      Enemy enemy = enemies.get(delEnemy);
      //runs if enemyB collides with hero
      if (!enemy.dying) {
        if (enemy instanceof EnemyB && enemyHit == 0) {
          c1.lives -= 1; //life lost
          enemyHit = 30; // cooldown timer initialised
          lifeMessage = "Life lost!";
          lifeMessageTimer = 120; //displays for 2 seconds
        }
        enemy.die();
      }
    }
    //displays life lost message
    if (lifeMessageTimer > 0) {
      fill(255, 0, 0); //red
      textAlign(CENTER);
      textSize(16);
      text(lifeMessage, width/2, 50);
      lifeMessageTimer--;
    }
  } else { //if no lives are left then game ends
    enemies.clear(); //removes all enemies
    textSize(60);
    textAlign(CENTER);
    text("Game over\n Press Q to restart\n Your score is: "+ h1.score, width/2, height/2-70);
    //updates high score if player score is higher than high score
    if (h1.score > highScore) {
      saveStrings("highscore.txt", new String[] {str(h1.score)});
    }
  }
  //removes enemies after death animation and adds new enemy
  for (int i = enemies.size() - 1; i>= 0; i--)
  {
    if (enemies.get(i).removeDeath())
    {
      enemies.remove(i);
      enemies.add(addEnemy());
      h1.score();
    }
  }
}

void mousePressed()
{
  h1.NewLoc(mouseX, mouseY); //moves hero to mouse click

  for (int i = 0; i < enemies.size(); i++) //removes enemy if mouse clicked on them
  {
    Enemy enemy = enemies.get(i);
    if (!enemy.dying && dist(mouseX, mouseY, enemy.x, enemy.y) < enemy.size/2)
    {
      enemy.die();
    }
  }
}
void keyPressed() {
  if (key == 'q' || key == 'Q') {
    restartGame(); //restart game if q is pressed
  }
  if (gameState == 0 && key == ' ') {
    gameState = 1; //starts game if space bar is pressed
  }
}


void livesCheck() { //displays lives
  c1.displayLives(); //if enemy touches castle, reemoves enemy and adds a new one
  if (c1.crashCheck(enemies))
  {
    enemies.remove(delEnemy);
    enemies.add(addEnemy());
  }
}
Enemy addEnemy() { //initialises enemy coordinates when generated
  int x = int(random(0, 200));
  float y = random(50, 350);
  int randEnemy = int(random(1, 4)); // random number between 1 and 3
  Enemy enemy;

  if (randEnemy == 1 || randEnemy ==2) { //adds enemyA if random number is 1 or 2
    enemy = new EnemyA(x, y);
  } else {
    enemy = new EnemyB(x, y); //else adds enemyB if random number is 3
  }
  return enemy;
}
//game reset
void restartGame() {
  enemies.clear();

  for (int i = 0; i < 5; i++) {
    enemies.add(addEnemy());
  }

  c1.lives = 6;
  h1.score = 0;
  enemyHit = 0;

  lifeMessage = "";
  lifeMessageTimer = 0;
  h1.resetHeroPos(); //hero new position
}
//game start screen
void showInfoScreen() {
  background(200);

  fill(0);
  textAlign(CENTER);
  textSize(32);
  text("Castle Defender", width/2, 80);
  
  textSize(20);
  text("DONT LET THE OGRES HIT THE CASTLE!", width/2, 115);

  textSize(16);
  text("Click to move the hero", width/2, 150);
  text("Click on ogres to defeat them", width/2, 180);
  text("Bird removes a life on contact", width/2, 210);
  text("Press Q to restart the game", width/2, 240);

  textSize(14);
  text("Press SPACE to start", width/2, 300);
}
