class House {
  House() {
    light1On = false;
    light2On = false;
    light3On = false;
    light4On = false;
    image = loadImage("house.png");
    audioPlayed = false;
  }
  void drawH() {
    fill(255, 211, 0);
    noStroke();
    if (light3On) {
      rect(1260, 700, 100, 50);
    }
    if (light2On) {
      rect(1400, 700, 75, 50);
    }
    if (light1On) {
      rect(1345, 630, 75, 50);
    }
    if (light4On) {
      rect(1345, 700, 75, 50);
    }
    image(image, 1250, 600, 250, 195);
  }

  void angry_farmer() {
    if (!angry_farmer.isPlaying() && !audioPlayed) {
      angry_farmer.play();
      audioPlayed = true;
    }
  }

  void addLight() {
    if (!light1On) {
      light1On = true;
    } else if (!light2On) {
      light2On = true;
    } else if (!light3On) {
      light3On = true;
    } else if (!light4On) {
      light4On = true;
    } else {
      angry_farmer();
    }
  }
  boolean audioPlayed;
  boolean light1On;
  boolean light2On;
  boolean light3On;
  boolean light4On;
  PImage image;
}
