/* Powerp class to create the powerup bag
 
 - extend from AddBlood class
 
 */

class PowerUp extends AddBlood {
  PowerUp(PVector pos, PVector vel, String type, float w, float h) {
    super(pos, vel, type, w, h);
    size = 25;
    img=loadImage("powerup.png");
  }

  void drawMe() {

    pushMatrix();
    translate(pos.x, pos.y);
    if (type.equals("power")) {
      image(img, 0, 0);
    }

    popMatrix();
  }
}
