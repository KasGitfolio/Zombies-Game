class EnemyA extends Enemy{
  private PImage enemyImg2;
  private PImage enemyImg3;
  private PImage enemyImg4;
  private PImage enemyImg5;
  EnemyA(int x, float y){  
    super(x,y);
    speedX = 1;
    speedY = 1;
    enemyImg = loadImage("Ogre1.png");
    enemyImg2 = loadImage("Ogre2.png");
    enemyImg3 = loadImage("Ogre3.png");
    enemyImg4 = loadImage("Ogre4.png");
    deathImg = loadImage("Ogre5.png");
    
    enemyImg.resize(size,size);
    enemyImg2.resize(size,size);
    enemyImg3.resize(size,size);
    enemyImg4.resize(size,size);
    deathImg.resize(size,size);
    this.imgCounter=0;
  }
  
  
  
  
  @Override
  void display(){
    if (dying){
      image(deathImg, x,y);
      return;
    }
    //animation
    imgCounter++;
    if (imgCounter <20 ){
      image(enemyImg, x, y);
    }
    else if(imgCounter < 40){
      image(enemyImg2, x, y);
    }
    else if(imgCounter < 60){
      image(enemyImg3, x, y);
    }
    else{
       image(enemyImg4, x, y);
    }
    if (imgCounter == 80)
      imgCounter=0;
    
    
  }
  //enemy death image
  void death(){
    image(enemyImg5, x, y);
  }
}
