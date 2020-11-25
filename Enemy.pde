/* Enemy class to create the first kind of enemies
 
 - enemies has two health speed is 0.7, they appear from top of screen
 - they have dead animation and live animation.
 
 */
class Enemy extends Character {

  PImage DeadAnimationImg;//for dying animation
  int currentDyingFrame = 0;
  int timer = 60;//enemies dying time 1s
  PImage[]DeadAnimation = new PImage[5];//dying animation array
  boolean DeadAnimationTrigger = false;
  Enemy(PVector pos, PVector vel) {
    super(pos, vel);
    health = 2;
    coolingTime = int(random(120));
    //for walking animation
    for (int i = 0; i< walking.length; i++) {
      walking[i] = loadImage("data/enemy" + i + ".png");
    }
    //for dying animation
    DeadAnimationImg = loadImage("enemyDying0.png");
    for (int i = 0; i< DeadAnimation.length; i++) {
      DeadAnimation[i] = loadImage("enemyDying" + i + ".png");
    }
  }



  void drawMe() {

    if (DeadAnimationTrigger == true) {
      timer--;
      vel.y=0;
      if (timer>0) {
        pushMatrix();
        translate(pos.x, pos.y);
        PImage DeadAnimationImg = DeadAnimation[currentDyingFrame];//dying animation
        image(DeadAnimationImg, -DeadAnimationImg.width/2, -DeadAnimationImg.height/2); 
        popMatrix();
      }
      if (timer<0) {
        dead();//animation finished score++
        score.update(1);
      }
    } else {
      pushMatrix();
      translate(pos.x, pos.y);
      PImage img = walking[currentFrame];//waling animation
      image(img, -img.width/2, -img.height/2);
      popMatrix();
    }
  }

  void checkBullets() {
    for (int i = 0; i < player.playerBullets.size(); i++) {
      Bullet pb=player.playerBullets.get(i);
      if ((pos.x - size / 2 <= pb.pos.x && pb.pos.x <= pos.x + size / 2)
        && (pos.y - size / 2 <= pb.pos.y && pb.pos.y <= pos.y + size / 2)) {   
        oh.rewind();//each player bullet hit enemies play audio.
        oh.play();
        decreaseHealth(1);
        pb.enemyBullets = true;
        if (health==0) {
          DeadAnimationTrigger = true;
        }
        break;
      }
    }    
  }

  void update() {
    pos.y += vel.y;//move from top to bottom
    super.update();
    if (frameCount % 13 == 0) {
      currentDyingFrame++;
    }
    if (currentDyingFrame == DeadAnimation.length) {
      currentDyingFrame = 0;
    } 
    //if enemies get to the bottom, player health lose.
    if (pos.y > height-70) { 
      player.healthLoss-=hit;
      dead();
    }
    coolingTime++;
    //every 2 second add one enemies bullet
    if (coolingTime >= 120) {
      enemyBullets.add(new Bullet(this, new PVector(pos.x, pos.y), new PVector(0, 4)));
      enemyshot.rewind();
      enemyshot.play();
      coolingTime = 0;
    }
    checkBullets();
  }
}
