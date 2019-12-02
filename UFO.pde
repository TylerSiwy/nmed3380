import processing.sound.*;

class UFO {
  UFO() {
    SoundFile beam_const;
    SoundFile beam_up;
    x = 0;
    y = 0;
    targetYCoord = 100;
    bY = y+ 50;
    bWidth = 0;
    ufoHeight = 1; //102;
    ufoWidth = 347; //347;
    ship = loadImage("ship.png");
    beam = loadImage("beam.png");
    beamExtended = false;
    finishedIntro = false;
    eHeight = height / 2;
    introSound = true;
  }

  void move(int addX, int addY) {
    x+=addX;
    y+=addY;
  }

  void beamDown(int targetDistance) {
    if (!beam_down.isPlaying()) {
      beam_down.play();
    }
    if (bHeight < targetDistance+ bY) {
      bHeight+=10;
    } else {
      beamExtended = true;
    }
  }

  void beamUp() {
    if (beam_const.isPlaying()) {
      beam_const.stop();
    }
    if (!beam_up.isPlaying()) {
      beam_up.play();
    }
    if (bHeight > 0) {
      bHeight-=10;
    } else if ( bHeight <= 0) {
      beamExtended = false;
    }
  }

  boolean isBeamExtended() {
    return beamExtended;
  }

  int getX() {
    return x;
  }
  int getY() {
    return y;
  }


  int beamX() {
    return bX;
  }
  int beamWidth() {
    return bWidth;
  }

  int beamHeight() {
    return bHeight;
  }

  void drawEnergyMarker() {
    pushMatrix();
    stroke(155);
    noFill();
    rect(10, 9, 20, (height/2)+1);
    image(beam, 10, 10, 20, eHeight);  
    popMatrix();
  }

  int eHeight() { 
    return eHeight;
  }

  void drawBeam() { 
    bX = x-42;
    if (finishedIntro) bY = y + 50;
    image(beam, bX, bY+5*(sin(millis()*PI/480)), bWidth, bHeight-5*(sin(millis()*PI/480)));
  }

  void drawShip() {
    imageMode(CENTER);
    image(ship, x, y+5*(sin(millis()*PI/480)), ufoWidth, ufoHeight);
    imageMode(CORNER);
    drawBeam();
    if (beamExtended && !beam_const.isPlaying()) beam_const.play();
    if (beamExtended && eHeight > 0 ) {
      eHeight-=2;
    } else {
      if (eHeight < height/2) {
        eHeight++;
      }
    }
    drawEnergyMarker();
    if (introSound && !engine_intro.isPlaying()) {
      engine_intro.play();
      introSound = false;
    } else if (!engine_intro.isPlaying() && !engine_hum.isPlaying()) {
      engine_hum.play();
    }
  }

  void moveToStartPos() {
    if (!finishedIntro) {
      int targetCoord = width/2;
      bY = y - ufoHeight ;
      if (bWidth<84) {
        bWidth++;
      }  
      if (ufoHeight < 102) {
        ufoHeight++;
        ufoWidth = int(ufoHeight*3.40);
      }
      if (y < targetYCoord) {
        y++;
      }
      if ( x < targetCoord) { 
        x+=8;
      } else {
        finishedIntro = true;
      }
    }
  }

  //location of ship on screen
  int x;
  int y;
  int bX;
  int bY;
  int bWidth;
  int bHeight;
  int eHeight;
  int ufoHeight;
  int ufoWidth;
  int targetYCoord;
  boolean finishedIntro;
  boolean introSound;
  boolean beamExtended;
  PImage ship;
  PImage beam;
};
