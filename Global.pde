/*
Global variables and functions
 */

AudioPlayer bgm, powerup, applause, bossfight, button, heal, oh, win, gameOver, shot, helicopter, enemyMgun, enemyshot, army;
Button play, playAgain, back, background;

//SET LEVEL 
final int START = 0;
final int LEVEL_ONE=1;
final int LEVEL_TWO=2;
final int LEVEL_THREE=3;
final int WON=4;
final int LOST=5;
final int INTRO=6;

Player player;
Enemy enemy;
Enemy enemy2;
Enemy3 enemy3;
Score score;
AddBlood firstAid;
AddBlood secondAid;
PowerUp AidPower;

int gameState = START; //first state is START
int powerTimer=240; //player powerup time 4 s
int maxHealth=100;// player has 100 health
int hit = 5;// each enemy bullet hit player, player lose 5 health
PImage img;
PImage welImg;
PImage frontImg;
PImage introImg;
PFont font;
String state;
int LevelScore; 

ArrayList<Enemy> enemies;
ArrayList<Enemy> enemies2;
ArrayList<Bullet> enemyBullets;
ArrayList<Bullet> enemy2Bullets;
ArrayList<Bullet> enemy3Bullets;

void setGame() {
  img=loadImage("background.png");
  score = new Score(); 
  //blood Bag
  firstAid = new AddBlood (new PVector(random(100, 400), 0), new PVector(0, random(0.7, 1.4)), "blood", 50, 30);
  secondAid = new AddBlood (new PVector(random(100, 400), 0), new PVector(0, random(0.7, 1.4)), "blood", 50, 30);
  //PowerUp bag
  AidPower = new PowerUp (new PVector(random(125, 475), 0), new PVector(0, random(0.7, 1.4)), "power", 50, 30);
  welImg=loadImage("welcome.png");
  introImg=loadImage("intro.png");
  frontImg=loadImage("wel.png");
  //load font
  font = loadFont("04b30-30.vlw");
  player = new Player(new PVector(width / 2, height - 20), new PVector(0, 0));
  enemies = new ArrayList<Enemy>();
  enemies2 = new ArrayList<Enemy>();
  enemyBullets = new ArrayList<Bullet>(); 
  enemy2Bullets = new ArrayList<Bullet>();
  enemy3Bullets = new ArrayList<Bullet>();
  PVector pos = new PVector(random(125, width-125), 100);
  PVector vel = new PVector(random(-3, 3), 0.15);
  enemy3=new Enemy3(pos, vel);
}

void loadMusic() {
  bgm = minim.loadFile("data/BGM.mp3");
  army = minim.loadFile("data/army.mp3");
  button = minim.loadFile("data/PLAYBUTTON.mp3");
  applause = minim.loadFile("data/APPLAUSE.mp3");
  bossfight = minim.loadFile("data/bossfight.mp3");
  powerup = minim.loadFile("data/powerup.mp3");
  heal = minim.loadFile("data/HEAL.mp3");
  win = minim.loadFile("data/WIN.mp3");
  oh = minim.loadFile("data/OH.mp3");
  shot = minim.loadFile("data/SHOT.mp3");
  enemyMgun = minim.loadFile("data/enemyMgun.mp3");
  enemyshot = minim.loadFile("data/enemyshot.mp3");
  helicopter = minim.loadFile("data/helicopter.mp3");
  gameOver = minim.loadFile("data/GAMEOVER.mp3");
}

void loadButtoms() {
  play = controlP5.addButton("Play", 0, width/2-100, height-210, 200, 60);
  playAgain = controlP5.addButton("Play Again", 0, width/2-100, height-210, 200, 60);
  back = controlP5.addButton("Back", 0, width/2-100, height-120, 200, 60);
  background = controlP5.addButton("Background", 0, width/2-100, height-120, 200, 60);
  playLabel();
  playAgainLabel();
  backLabel();
  backgroundLabel();
}

// "PLAY" button properties
void playLabel() {  
  PFont button = createFont("Retron2000", 20, true); 
  play.getCaptionLabel().setFont(button);
  play.setColorLabel(color(255));
  play.setColorBackground(color(109, 93, 48));
  play.setColorForeground(color(171, 146, 75));
  play.setColorActive (color(200, 130, 50));
}

// "PLAY AGAIN" button properties
void playAgainLabel() {
  PFont button = createFont("Retron2000", 20, true); 
  playAgain.getCaptionLabel().setFont(button);
  playAgain.setColorLabel(color(255));
  playAgain.setColorBackground(color(109, 93, 48));
  playAgain.setColorForeground(color(171, 146, 75));
  playAgain.setColorActive (color(200, 130, 50));
}
// "back" button properties
void backLabel() {  
  PFont button = createFont("Retron2000", 20, true); 
  back.getCaptionLabel().setFont(button);
  back.setColorLabel(color(255));
  back.setColorBackground(color(109, 93, 48));
  back.setColorForeground(color(171, 146, 75));
  back.setColorActive (color(200, 130, 50));
}
// "background" button properties
void backgroundLabel() {  
  PFont button = createFont("Retron2000", 20, true); 
  background.getCaptionLabel().setFont(button);
  background.setColorLabel(color(255));
  background.setColorBackground(color(109, 93, 48));
  background.setColorForeground(color(171, 146, 75));
  background.setColorActive (color(200, 130, 50) );
}

void gameStart() {
  image(frontImg, 0, 0);
  controlP5.getController("Play").show();
  controlP5.getController("Background").show();  
  controlP5.getController("Back").hide();
  controlP5.getController("Play Again").hide();
  textAlign(CENTER, CENTER);
}

void gameIntro() {
  image(introImg, 0, 0);
  controlP5.getController("Play").show();
  controlP5.getController("Background").hide();
  controlP5.getController("Back").show();
  controlP5.getController("Play Again").hide();
}

void gameOver (String str) {
  image(welImg, 0, 0);
  controlP5.getController("Play Again").show();
  controlP5.getController("Play").hide();
  controlP5.getController("Background").hide();
  controlP5.getController("Back").hide();
  textAlign(CENTER, CENTER);
  //load font
  font = loadFont("04b30-30.vlw");
  textFont(font, 40);
  fill(255, 0, 0);
  text(str, width / 2, height / 2);
}

void gameWin (String str) {
  image(welImg, 0, 0);
  controlP5.getController("Play Again").show();
  controlP5.getController("Play").hide();
  controlP5.getController("Background").hide();
  controlP5.getController("Back").hide();

  textAlign(CENTER, CENTER);
  //load font
  font = loadFont("04b30-30.vlw");
  textFont(font, 40);
  fill(255, 0, 0);
  text(str, width / 2, height / 2);
}

//Level 1 enemies
void level1NextEnemy() {
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).drawMe();
  }
  //Add new enemies
  ArrayList<Enemy> nextEnemies = new ArrayList<Enemy>();
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).update();
    if (enemies.get(i).Dead==false) {
      nextEnemies.add(enemies.get(i));
    }
  }  
  enemies = nextEnemies;
  //respown enemies
  if (random(1) < 0.008) {
    enemies.add(new Enemy(new PVector(random(25 / 2, width - 25 / 2), -25 / 2), new PVector(0, 0.7)));
  }
}

//Level 1 enemiesBullets
void level1EnemyFire() {
  for (int i = 0; i < enemyBullets.size(); i++) {
    enemyBullets.get(i).drawBullet();
  }
  //Add new enemies bullets
  ArrayList<Bullet> nextEneBullets = new ArrayList<Bullet>();
  for (int i = 0; i < enemyBullets.size(); i++) {
    enemyBullets.get(i).update();
    if (enemyBullets.get(i).death == true)enemyBullets.remove(i);
    if (enemyBullets.get(i).enemyBullets==false) {
      nextEneBullets.add(enemyBullets.get(i));
    }
  }
  enemyBullets = nextEneBullets;
}

//Level 2 enemies
void level2NextEnemy() {
  //draw enemies and add enemies bullets
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).drawMe();
  }
  for (int i = 0; i < enemies2.size(); i++) {
    enemies2.get(i).drawMe();
  }
  //Add new enemies
  ArrayList<Enemy> nextEnemies = new ArrayList<Enemy>();
  ArrayList<Enemy> nextEnemies2 = new ArrayList<Enemy>();
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).update();
    if (enemies.get(i).Dead==false) {
      nextEnemies.add(enemies.get(i));
    }
  }
  for (int i = 0; i < enemies2.size(); i++) {
    enemies2.get(i).update();
    if (enemies2.get(i).Dead==false) {
      nextEnemies2.add(enemies2.get(i));
    }
  }
  enemies = nextEnemies;
  enemies2 = nextEnemies2;

  //respown enemies
  if (random(1) < 0.01) {
    enemies.add(new Enemy(new PVector(random(25 / 2, width - 25 / 2), -25 / 2), new PVector(0, 0.7)));
  }
  if (random(1) < 0.008) {
    enemies2.add(new Enemy2(new PVector(random(25 / 2, width - 25 / 2), -25 / 2), new PVector(0, 0.4)));
  }
}
//Level 2 enemiesBullets
void level2EnemyFire() {
  for (int i = 0; i < enemyBullets.size(); i++) {
    enemyBullets.get(i).drawBullet();
  }
  //Add new enemies bullets
  ArrayList<Bullet> nextEneBullets = new ArrayList<Bullet>();
  ArrayList<Bullet> nextEne2Bullets = new ArrayList<Bullet>();
  for (int i = 0; i < enemyBullets.size(); i++) {
    enemyBullets.get(i).update();
    if (enemyBullets.get(i).death == true)enemyBullets.remove(i);
    if (enemyBullets.get(i).enemyBullets==false) {
      nextEneBullets.add(enemyBullets.get(i));
    }
  }
  for (int i = 0; i < enemy2Bullets.size(); i++) {
    enemy2Bullets.get(i).update();
    if (enemy2Bullets.get(i).death == true)enemy2Bullets.remove(i);
    if (enemy2Bullets.get(i).enemy2Bullets==false) {
      nextEne2Bullets.add(enemy2Bullets.get(i));
    }
  }  
  enemyBullets = nextEneBullets;
  enemy2Bullets = nextEne2Bullets;
}

//Level 3 enemy
void level3NextEnemy() {
  //Add Boss

  enemy3.update();
  //respown enemies
  if (random(1) < 0.005) {
    enemies.add(new Enemy(new PVector(random(25 / 2, width - 25 / 2), -25 / 2), new PVector(0, 0.7)));
  }
  if (random(1) < 0.003) {
    enemies2.add(new Enemy2(new PVector(random(25 / 2, width - 25 / 2), -25 / 2), new PVector(0, 0.4)));
  }
}
//Level3 enemyBullets
void level3EnemyFire() {

  for (int i = 0; i < enemyBullets.size(); i++) {
    enemyBullets.get(i).drawBullet();
  }
  //Add new enemies bullets
  ArrayList<Bullet> nextEneBullets = new ArrayList<Bullet>();

  for (int i = 0; i < enemyBullets.size(); i++) {
    enemyBullets.get(i).update();
    if (enemyBullets.get(i).enemyBullets==false) {
      nextEneBullets.add(enemyBullets.get(i));
    }
  }  

  enemyBullets = nextEneBullets;
}

/* 
 - click PLAY to level 1
 - click PLAY AGAIN to level 1
 - click BACK to START
 - click BACKGROUND to INTRO
 */
void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName() =="Play") {
    button.rewind();
    button.play();
    gameState = LEVEL_ONE;
    army.loop();
    setGame();
  }
  if (theEvent.getController().getName() =="Play Again") {
    button.rewind();
    button.play();
    gameState = START;
    bgm.rewind();
    bgm.play();
    setGame();
  }
  if (theEvent.getController().getName() =="Back") {
    button.rewind();
    button.play();
    gameState = START;
    setGame();
  }
  if (theEvent.getController().getName() =="Background") {
    button.rewind();
    button.play();
    gameState = INTRO;
    setGame();
  }
}
