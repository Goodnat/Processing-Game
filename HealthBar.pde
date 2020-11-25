// display player health bar on screen
void drawHealthBar() {
  pushMatrix();
  translate(0, 0);
  fill(220, 90, 50);
  //if bullets hit player the health bar lose length.
  int totalHealth = maxHealth+player.healthLoss;
  rect(2, 778, totalHealth, 20);
  noFill();
  strokeWeight(2);
  stroke(0);
  rect(2, 778, maxHealth, 20);
  popMatrix();  
  //game over state
  if (totalHealth==0) { 
    gameState = LOST;
    gameOver.rewind();
    gameOver.play();
    bgm.pause();
  }
}

// display boss health bar on screen
void drawBossHealthBar() {
  pushMatrix();
  translate(0, 0);
  fill(220, 100, 70);
  int totalBossHealth = enemy3.health*5;
  rect(2, 2, totalBossHealth, 30);
  noFill();
  strokeWeight(2);
  stroke(0);
  rect(2, 2, 500, 30);
  popMatrix();
}
