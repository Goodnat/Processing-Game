/* Enemy3 class to create the boss enemies
 
 - Boss has 100 health, it appear from top of screen
 - It also has dead animation and live animation.
 
 */
class Enemy3 extends Enemy {
  PImage[]DeadAnimation = new PImage[7];
  int timer = 100;//to count down the dying animation
  Enemy3(PVector pos, PVector vel) {
    super(pos, vel);
    size=250;//image size
    health = 100;//boss health
    coolingTime = int(random(60));//coculate the bullets time
    Dead = false;
    for (int i = 0; i< walking.length; i++) {
      walking[i] = loadImage("data/enemy3" + i + ".png");
    }
    DeadAnimationImg = loadImage("enemy3Dying0.png");
    for (int i = 0; i< DeadAnimation.length; i++) {
      DeadAnimation[i] = loadImage("enemy3Dying" + i + ".png");
    }
  }
  void drawMe() {
    //dying animation
    if (DeadAnimationTrigger == true) {
      helicopter.pause();
      timer--;
      vel.x=0;
      vel.y=0;
      if (timer>0) {
        //boss dying animation
        pushMatrix();
        translate(pos.x, pos.y);
        PImage DeadAnimationImg = DeadAnimation[currentDyingFrame];
        image(DeadAnimationImg, -DeadAnimationImg.width/2, -DeadAnimationImg.height/2); 
        popMatrix();
      }
      //If dying animation done enemy dead and game win
      if (timer<0) {
        Dead=true;
        enemyMgun.pause();
        gameState = WON;
        win.rewind();
        win.play();
        bgm.pause();
        army.pause();
        bossfight.pause();
      }
    } else {
      //boss animation
      pushMatrix();
      translate(pos.x, pos.y);
      PImage img = walking[currentFrame];
      image(img, -img.width/2, -img.height/2);
      popMatrix();
    }
  }
  void checkWalls() {
    //boss move 
    if (pos.x - size / 2  < 0) vel.x=-vel.x;
    else if (pos.x + size / 2  > width) vel.x=-vel.x;
  }

  void checkBullets() {
    for (int i = 0; i <  player.playerBullets.size(); i++) {
      Bullet pb= player.playerBullets.get(i);
      if ((pos.x - size / 2 <= pb.pos.x && pb.pos.x <= pos.x + size / 2)
        && (pos.y - size / 2 <= pb.pos.y && pb.pos.y <= pos.y + size / 2)) {   
        decreaseHealth(1);//each player bullet decrease boss 1 health
        pb.enemyBullets = true;
        if (health==0) {
          DeadAnimationTrigger = true;
        }
        break;
      }
    }
  }

  void update() {
    drawMe();
    //boss move
    pos.add(vel);

    checkWalls();
    //walk anmimation
    if (frameCount % 6 == 0) {
      currentFrame++;
    }
    if (currentFrame == walking.length) {
      currentFrame = 0;
    }
    //Dying anmimation
    if (frameCount % 20 == 0) {
      currentDyingFrame++;
    }
    if (currentDyingFrame == DeadAnimation.length) {
      currentDyingFrame = 0;
    }

    //if Boss not dead health over 50
    if (Dead==false && health>50) {
      coolingTime++;
      if (coolingTime >= 30) {
        enemyBullets.add(new Bullet(this, new PVector(pos.x, pos.y), new PVector(0, 4)));
        enemyMgun.rewind();
        enemyMgun.play();
        coolingTime = 0;
      }
    }
    //if Boss not dead health less than 50
    if (Dead==false&&health<=50) {
      vel.x*=1.001;
      coolingTime++;
      if (coolingTime >= 15) {
        enemyBullets.add(new Bullet(this, new PVector(pos.x, pos.y), new PVector(0, 4)));
        enemyMgun.rewind();
        enemyMgun.play();
        coolingTime = 0;
      }
    }

    checkBullets();

    //If boss get to the bottom, game LOST
    if (pos.y>height-size/2-70) {
      switch (gameState) {
      case LEVEL_THREE:
        gameState = LOST;
        helicopter.pause();
        bossfight.pause();
        army.pause();
        setGame();
        break;
      case WON:
        gameWin("You Win!");
        break;    
      case LOST:
        gameOver("Game Over");
        break;
      }
    }
  }
}
