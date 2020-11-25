/* 
 
- AddBlood class to create the blood bag
- super class 
 
 */
class AddBlood {
  PVector pos;
  PVector vel;
  String type;
  float w;
  float h;
  PImage img;
  boolean death;
  float size;

  AddBlood(PVector pos, PVector vel, String type, float w, float h) {
    this.pos = pos;
    this.vel = vel;
    this.type = type;
    this.w = w;
    this.h = h;
    size = 25;
    img=loadImage("HP.png");//I used bloodbag img
  }

  void drawMe() {

    pushMatrix();
    translate(pos.x, pos.y);
    if (type.equals("blood")) {
      image(img, 0, 0);
    }    
    popMatrix();
  }

  void move() {

    pos.add(vel);
  }

  void update() {

    move();
    drawMe();
  }

  void detecWall() {
    if (pos.x + size/ 2 < 0 || pos.x -  size/ 2 > width || pos.y + size / 2 < 0 || pos.y -  size / 2 > height) 
      death = true;
  }
}
