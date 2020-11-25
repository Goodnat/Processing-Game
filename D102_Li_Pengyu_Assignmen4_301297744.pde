/* D102 Pengyu Li 301297744 Assignment 4
 
 New feature
 1. I add two new buttons, which are "BACKGROUND" and "BACK".
 
 2. I also made the background interface.
 
 3. Before get into next level, I made the content to notice player.
 
 */

//import minim library
import ddf.minim.*;
Minim minim;
//import controlP5 library
import controlP5.*; 
ControlP5 controlP5;

void setup() {
  size(500, 800);
  setGame();
  controlP5 = new ControlP5(this);
  loadButtoms(); // load buttom 
  minim=new Minim(this);
  loadMusic(); // load music 
  bgm.rewind(); // starting background music
  bgm.loop(); // loop background music
}

//use switch to built 3 levels
void draw() {
  switch (gameState) {
  case START:
    gameStart();
    break;
  case LEVEL_ONE:
    gamePlay1();
    break;
  case LEVEL_TWO:
    gamePlay2();
    break;
  case LEVEL_THREE:
    gamePlay3();
    break;
  case WON:
    gameWin("You Win!");
    break;    
  case LOST:
    gameOver("Game Over");
    break;
  case INTRO:
    gameIntro();
    break;
  }
}

/* level one setting:
 - enemies appear in this method "(random(1) < 0.008)"
 - each enemy has 2 health
 - just one bloodbag
 */
void gamePlay1() {
  image(img, 0, 0);
  //hide all buttons
  controlP5.getController("Play").hide();
  controlP5.getController("Play Again").hide();
  controlP5.getController("Background").hide();
  controlP5.getController("Back").hide();  
  //drwa player healthbar and player
  drawHealthBar();  
  player.drawMe();//draw player

  //draw score
  textFont(font, 30);
  score.drawScore();
  pushMatrix();
  font = loadFont("FasterOne-Regular-48.vlw");
  fill(255);
  text("LEVEL 1", 100, 70);//level 1 at top left corner
  popMatrix();
  player.update(); 
  player.shot(); //player normal shot

  //Blood Bag, each bag can heal player 50 health
  if (firstAid != null) {
    firstAid.update();

    if (firstAid.death==true) {
      firstAid=null;
    }
    if (player.pickupBlood(firstAid)) {
      player.healthLoss+=50;
      heal.rewind();
      heal.play();
      firstAid=null;
    }
  }
  //respown bloodBag
  if (firstAid==null) {
    if (random(1) < 0.2) {
      firstAid = new AddBlood (new PVector(random(100, 400), 0), new PVector(0, random(0.6, 1.2)), "blood", 50, 30);
    }
  }
  level1NextEnemy();//call enemies
  level1EnemyFire();//enemies can shot
  player.fire();//player add bullet
}

/* level two setting:
 - I have two kinds of enemies, the first kind of enemies is as same as levels. However enemies appear in this methods (random(1) < 0.01)
 - The second kind of enemies has 3 health. They are appearing in this method(random(1)< 0.008);
 - Two bloodbags and One PowerUp bag
 */
void gamePlay2() {
  image(img, 0, 0);
  //hide all buttons
  controlP5.getController("Play").hide();
  controlP5.getController("Play Again").hide();
  controlP5.getController("Background").hide();
  controlP5.getController("Back").hide();
  drawHealthBar();  
  player.drawMe();//draw player
  textFont(font, 30);
  score.drawScore();//score at top left corner
  pushMatrix();
  font = loadFont("FasterOne-Regular-48.vlw");
  fill(255);
  text("LEVEL 2", 100, 70);//level2 at top left corner
  popMatrix();
  player.update();

  //Blood Bag
  if (firstAid != null) {
    firstAid.update();

    if (firstAid.death==true) {
      firstAid=null;
    }
    if (player.pickupBlood(firstAid)) {
      player.healthLoss+=50;
      heal.rewind();
      heal.play();
      firstAid=null;
    }
  }
  //second blood bag
  if (secondAid != null) {
    secondAid.update();

    if (secondAid.death==true) {
      secondAid=null;
    }
    if (player.pickupBlood(secondAid)) {
      player.healthLoss+=50;
      heal.rewind();
      heal.play();
      secondAid=null;
    }
  }
  //PowerUp bag make player to have more Bullets 
  if (AidPower != null) {
    AidPower.update();

    if (AidPower.death==true) {
      AidPower=null;
    }
    if (player.pickupPower(AidPower)) {
      powerup.rewind();
      powerup.play();
      AidPower=null;
    }
  }
  player.shot();//normal shot
  //powerup shot only has 4s.
  if (AidPower==null&&powerTimer>0) { 
    player.PowerShot();
    powerTimer--;
  }
  //respown bloodBag
  if (firstAid==null) {
    if (random(1) < 0.04) {
      firstAid = new AddBlood (new PVector(random(100, 400), 0), new PVector(0, random(0.5, 1)), "blood", 50, 30);
    }
  }
  if (secondAid==null) {
    if (random(1) < 0.02) {
      secondAid = new AddBlood (new PVector(random(100, 400), 0), new PVector(0, random(0.8, 2)), "blood", 50, 30);
    }
  }

  level2NextEnemy();//draw enemies
  level2EnemyFire();//enemies can shot
  player.fire();
}

/* level three setting:
 - This is boss level, Boss has 100 blood.
 - I alse have other two kinds of enemies, the first kind of enemies is as same as levels. However enemies appear in this methods (random(1) < 0.005)
 - The second kind of enemies has 3 health. They are appearing in this method(random(1)< 0.003);
 - Two bloodbags and One PowerUp bag
 */
void gamePlay3() {
  image(img, 0, 0);
  //hide all buttons
  controlP5.getController("Play").hide();
  controlP5.getController("Play Again").hide();
  controlP5.getController("Background").hide();
  controlP5.getController("Back").hide();
  bgm.pause();//stop main bgm, change to bossfight bgm
  drawHealthBar();  
  player.drawMe(); //draw player
  textFont(font, 30);
  pushMatrix();
  font = loadFont("FasterOne-Regular-48.vlw");
  textFont(font, 30);
  fill(255);
  text("BOSS FIGHTING", 180, 70);
  popMatrix();
  player.update();  

  //Blood Bag
  if (firstAid != null) {
    firstAid.update();

    if (firstAid.death==true) {
      firstAid=null;
    }
    if (player.pickupBlood(firstAid)) {
      player.healthLoss+=50;
      heal.rewind();
      heal.play();
      firstAid=null;
    }
  }
  if (secondAid != null) {
    secondAid.update();

    if (secondAid.death==true) {
      secondAid=null;
    }
    if (player.pickupBlood(secondAid)) {
      player.healthLoss+=50;
      heal.rewind();
      heal.play();
      secondAid=null;
    }
  }

  //PowerUp bag make player to have more Bullets 
  if (AidPower != null) {
    AidPower.update();

    if (AidPower.death==true) {
      AidPower=null;
    }
    if (player.pickupPower(AidPower)) {
      powerup.rewind();
      powerup.play();
      AidPower=null;
    }
  }
  player.shot();
  //However only has 4s.
  if (AidPower==null&&powerTimer>0) { 
    player.PowerShot();
    powerTimer--;
  }
  //respown bloodBag
  if (firstAid==null) {
    if (random(1) < 0.04) {
      firstAid = new AddBlood (new PVector(random(100, 400), 0), new PVector(0, random(0.5, 1)), "blood", 50, 30);
    }
  }
  if (secondAid==null) {
    if (random(1) < 0.04) {
      secondAid = new AddBlood (new PVector(random(100, 400), 0), new PVector(0, random(0.8, 1.4)), "blood", 50, 30);
    }
  }

  level2NextEnemy();
  level3NextEnemy();
  level3EnemyFire();
  player.fire();
  drawBossHealthBar();
}
