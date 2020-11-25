/* Enemy2 class to create the second kind of enemies
 
 - enemies has three health speed is 0.4, they appear from top of screen
 - they have dead animation and live animation.
 
 */
class Enemy2 extends Enemy {
  Enemy2(PVector pos, PVector vel) {
    super(pos, vel);
    health = 3;
    coolingTime = int(random(60));
    Dead = false;
    for (int i = 0; i< walking.length; i++) {
      walking[i] = loadImage("data/enemy2" + i + ".png");
    }
  }
  void drawMe() {

    if (DeadAnimationTrigger == true) {
      timer--;
      vel.y=0;
      if (timer>0) {
        //dying animation
        pushMatrix();
        translate(pos.x, pos.y);
        PImage DeadAnimationImg = DeadAnimation[currentDyingFrame];
        image(DeadAnimationImg, -DeadAnimationImg.width/2, -DeadAnimationImg.height/2); 
        popMatrix();
      }
      if (timer<0) {
        dead();
        score.update(1);
      }
    } else {
      //walking animation
      pushMatrix();
      translate(pos.x, pos.y);
      PImage img = walking[currentFrame];
      image(img, -img.width/2, -img.height/2);
      popMatrix();
    }
  }
}
