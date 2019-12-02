String splats[] = {"splat1.png", "splat2.png", "splat3.png"};
class Cow {
  Cow(int inputX, int inputY) {
    hasMooed = false;
    hasSplatted = false;
    draw = true;     
    cWidth=151;
    cHeight=118;
    x=inputX;
    rotateSpeed = random(1, 20);
    speed = 0;
    if (inputY<850)
      y=850;
    else
      y=inputY;
    startY = y;
    pickNewTargets();
    dead = false;
    scared = false;
    String cow1Anim[]={"cow1.png", "cow1.1.png", "cow1.2.png"};
    String cow2Anim[]={"cow2.png", "cow2.1.png", "cow2.2.png"};
    float cow = int(random(0, 2));
    if (cow==1)
      image = loadImage(cow1Anim[0]);  
    else
      image = loadImage(cow2Anim[0]);
    dMooToPlay = int(random(0, dMoosSize));
  }
  void move(int addX, int addY) {
    x+=addX;
    y+=addY;
  }

  void moo() {
    if (!dead && !moos.get(mooToPlay).isPlaying() && !dMoos.get(dMooToPlay).isPlaying()) {
      moos.get(mooToPlay).play();
    }
  }

  void distressedMoo() {
    if (!dMoos.get(dMooToPlay).isPlaying() && hasMooed==false) {
      dMoos.get(dMooToPlay).play();
      dMooToPlay = int(random(0, dMoosSize));
    }
    scared = true;
    hasMooed = true;
  }


  void enter_ship() {
    enter_ship.play();
    dead = true;
    hasSplatted = true;
  }

  void splat() {
    if (!splatMP3s.get(splatToPlay).isPlaying() && hasSplatted==false) {
      splatMP3s.get(splatToPlay).play();
      hasSplatted = true;
    }
  }

  int startY() {
    return startY;
  }

  void pickNewTargets() {
    targetX = int(random(0+cWidth, width-cWidth));
    targetY = int(random(850, height-cWidth));
  }

  void drawCow() {
    imageMode(CENTER);
    if (spin) {
      counter++;
      pushMatrix();
      translate(x, y);
      rotate(counter*PI/(5*rotateSpeed));
      image(image, 0, 0, cWidth, cHeight);
      popMatrix();
    } else { 
      if (draw) {
        if (scared && !dead) {
          if (x < targetX) {
            x++;
          } else if ( x > targetX) {
            x--;
          }
          if (y<targetY) {
            y++;
          } else if ( y>targetY) {
            y--;
          }
          if (x==targetX && y==targetY) {
            pickNewTargets();
            scared = false;
          }
        }
        image(image, x, y, cWidth, cHeight);
      }
    }
    if (dead && !hasSplatted)
      if (y>200) {
        splatCount++;
        splat();
      } else {
        //Abduction noise
        enter_ship();
      }
    imageMode(CORNER);
  }


  void eating() {
    //Animation loop for eating
  }

  void abducted(int target) {
    if (!dead) {
      if (y>target + 8) {
        y-=8;
        spin = true;
        distressedMoo();
      } else {
        spin = false;
        draw = false;
        dead = true;
      }
    }
  }

  boolean inShip() {
    if (spin == false)
      return true;
    else 
    return false;
  }

  boolean inAir() {
    if (spin == true) {
      return true;
    } else 
    return false;
  }

  boolean dead() {
    return dead;
  }
  void fall() {
    if (y < startY) {
      speed = speed + gravity;
      y = y + int(speed);
    } else {
      if (speed>25) {
        int selection = int(random(0, 3));
        switch(selection) {
        case 0:
          cWidth = 476;
          cHeight =  117;
          break;
        case 1:
          cWidth = 403; 
          cHeight = 151;
          break;
        case 2:
          cWidth = 395;
          cHeight = 155;
          break;
        }
        cWidth = cWidth/3;
        cHeight = cHeight/3;
        y = y + 10;
        image = loadImage(splats[selection]);
        dead = true;
      }
      speed = 0;
      spin = false;
    }
  }

  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  int dMooToPlay;
  int mooToPlay = int(random(0, moosSize));
  int splatToPlay = int(random(0, 3));
  float counter;
  float rotateSpeed;
  float speed;
  int x;
  int y;
  int startY;
  int cWidth;
  int cHeight;
  int targetX;
  int targetY;
  boolean scared;
  boolean hasMooed;
  boolean dead;
  boolean hasSplatted;
  boolean draw;
  boolean isEating;
  boolean falling;
  boolean spin;
  PImage image;
  String imageName;
  String cow1Anim[];
  String cow2Anim[];
};
