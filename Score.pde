/*

score class to calculate scores
 
 */
class Score {
  int score; //field to store score
  Score() {
    score = 0;
  }
  //update score by the amount of inc
  void update (int inc) {
    score += inc;
  }
  void drawScore() {
    //set its color to cyan
    pushMatrix();
    fill( 255, 125, 0);
    //draw score near the top right edge of the window
    text ("KILLED: " + score, 90, 40);
    popMatrix();
  }
}
