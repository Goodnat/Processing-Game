/*

 Character class is super class
 
 */

class Character {

  int currentFrame = 0;//for animation
  PVector pos;
  PVector vel;
  float size=25;//image size
  int coolingTime;//for bullets countdown
  int health;
  boolean Dead;
  PImage[]walking = new PImage[5];//walking animation array

  Character(PVector pos, PVector vel) {
    this.pos=pos;
    this.vel=vel;
    Dead=false;
  }

  void decreaseHealth(int dec) {
    health -= dec;
    if (health < 0) health = 0;
  }

  void drawMe() {

    rect(0, 0, 10, 10);
  }

  void dead() {
    vel.x= 0;
    vel.y= 0;
    Dead = true;
  }

  void update() {
    if (frameCount % 6 == 0) {
      currentFrame++;
    }
    if (currentFrame == walking.length) {
      currentFrame = 0;
    }
  }
}
