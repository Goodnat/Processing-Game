/*

 I used one class but have two type of bullets.
 
 */
class Bullet {

  PVector pos;
  PVector vel;
  boolean playerBullets;
  boolean enemyBullets;
  boolean enemy2Bullets;
  PImage pBulletsImg;
  PImage eBulletsImg;
  boolean death;
  Bullet( PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    //vel = -10;
    playerBullets = true;
    pBulletsImg=loadImage("pBulletsImg.png");//load player bullets img
    pBulletsImg.resize(5, 20);
  }

  Bullet(Enemy enemy, PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    //vel = 4;
    playerBullets = false;
    eBulletsImg=loadImage("e2BulletsImg.png");//load enemies bullets img
    eBulletsImg.resize(5, 20);
  }


  void drawBullet() {
    if (playerBullets) {
      image(pBulletsImg, pos.x, pos.y-20);//player bullets
    } else {
      image(eBulletsImg, pos.x-5, pos.y);//enemies bullets
    }
  }

  void update() {
    pos.add(vel);// bullets movement
    if ((vel.y > 0 && pos.y > height) || (vel.y < 0 && pos.y < 0)) {
      enemyBullets = true;
    }
    if ((vel.y > 0 && pos.y > height) || (vel.y < 0 && pos.y < 0)) {
      enemy2Bullets = true;
    }
  }
}
