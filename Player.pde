/* Player class to create the player
 
 - player has 100 health, every enemy bullet hit player, player lose 5 health.
 - player also has dead animation and live animation.
 
 */
class Player extends Character {
  ArrayList<Bullet> playerBullets;

  int healthLoss=0;
  PImage playerStand;
  int countDown=180;

  Player(PVector pos, PVector vel) {
    super(pos, vel);
    coolingTime = 0;
    Dead = false;
    for (int i = 0; i< walking.length; i++) {
      walking[i] = loadImage("data/player" + i + ".png");
    }
    playerStand = loadImage("player0.png");
    playerBullets= new ArrayList<Bullet>();
  }

  void drawMe() {
    if (Dead==false) {
      pushMatrix();
      translate(pos.x, pos.y);
      image( playerStand, -playerStand.width/2, -playerStand.height/2);
      //If musepressed the player gun has fire animation.
      if (mousePressed) {
        PImage img = walking[currentFrame];
        image(img, -img.width/2, -img.height/2);
      }
      popMatrix();
    }
  }
  void fire() {
    //Add player bullets
    for (int i = 0; i < player.playerBullets.size(); i++) {
      playerBullets.get(i).drawBullet();
    }
    ArrayList<Bullet> nextMyBullets = new ArrayList<Bullet>();
    for (int i = 0; i < playerBullets.size(); i++) {
      playerBullets.get(i).update();
      if (playerBullets.get(i).death == true)playerBullets.remove(i);
      if (playerBullets.get(i).enemyBullets==false) {
        nextMyBullets.add(playerBullets.get(i));
      }
    }
    playerBullets = nextMyBullets;
  }


  //blood bag
  Boolean pickupBlood(AddBlood other) {
    if (abs(pos.x-other.pos.x) < (25+other.size)/2 && abs(pos.y-other.pos.y) < (25+other.size)/2) { 
      return true;
    } else {
      return false;
    }
  }
  //powerUp bag
  Boolean pickupPower(PowerUp other) {
    if (abs(pos.x-other.pos.x) < (25+other.size)/2 && abs(pos.y-other.pos.y) < (25+other.size)/2) { 
      return true;
    } else {
      return false;
    }
  }

  // nornmal shot
  void shot() {
    coolingTime++;
    if (mousePressed && coolingTime >= 10) {
      playerBullets.add(new Bullet(new PVector(player.pos.x, player.pos.y), new PVector(0, -10)));
      shot.rewind();
      shot.play();
      coolingTime = 0;
    }
  }
  //after hit powerup bag
  void PowerShot() {
    coolingTime++;
    if (mousePressed && coolingTime >= 4) {
      playerBullets.add(new Bullet(new PVector(player.pos.x, player.pos.y), new PVector(0, -10)));
      enemyMgun.rewind();
      enemyMgun.play();
      coolingTime = 0;
    }
  }

  void update() {
    super.update();
    //move by mouse
    float dmx = mouseX - pos.x;
    dmx = constrain(dmx, -5, 5);
    pos.x += dmx;
    //enemies bullets hit player, player lose health
    for (int i = 0; i < enemyBullets.size(); i++) {
      Bullet eb=enemyBullets.get(i);
      if ((pos.x - size / 2 <= eb.pos.x && eb.pos.x <= pos.x + size / 2)
        && (pos.y - size / 2 <= eb.pos.y && eb.pos.y <= pos.y + size / 2)) {        
        healthLoss -= hit;
        oh.rewind();
        oh.play();
        eb.enemyBullets = true;
        break;
      }
    }
   
    //if killed over 10 level one get to level two
    if (score.score>=2) {
      switch (gameState) {
      case LEVEL_ONE:
        if (countDown>0) {
          countDown--;
          fill(255, 0, 0);
          text("NEXT WAVE", width/2, height/2);
          return;
        }
        gameState = LEVEL_TWO;
        setGame();
        break;
      }
    }
    //if killed over 20 level two get to level three
    if (score.score>=2) {
      switch (gameState) {
      case LEVEL_TWO:
        if (countDown>0) {
          countDown--;
          fill(255, 0, 0);
          text("WARNING", width/2, height/2);
          return;
        }
        gameState = LEVEL_THREE;
        helicopter.loop();
        bossfight.loop();
        setGame();
        break;
      }
    }
  }
}
