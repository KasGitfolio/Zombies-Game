class EnemyB extends Enemy {
  EnemyB(int x, float y) {
    super(x, y);

    // give it basic movement & images so it behaves safely
    speedX = 2;
    speedY = 2;

    enemyImg = loadImage("birdfly1.png");
    deathImg = loadImage("birdfly1.png");

    enemyImg.resize(size, size);
    deathImg.resize(size, size);
  }
}
