UFO ship;
PImage farmGround;
boolean firstSceneDone;
boolean beamToggle;
boolean cowCaught;
float gravity;
House h;
int shipXMovement;
ArrayList<Cow> cows = new ArrayList<Cow>();
SoundFile beam_down;
SoundFile beam_const;
SoundFile beam_up;
SoundFile enter_ship;
SoundFile engine_intro;
SoundFile engine_hum;
SoundFile angry_farmer;
ArrayList<SoundFile> moos = new ArrayList<SoundFile>();
int moosSize;
ArrayList<SoundFile> dMoos = new ArrayList<SoundFile>();
int dMoosSize;
ArrayList<SoundFile> splatMP3s = new ArrayList<SoundFile>();
int splatsSize;
int mooTime;
int splatCount;
int prevSplatCount;
void setup() {
  mooTime = int(random(1, 5000));
  moosSize = 7;
  dMoosSize = 5;
  splatsSize = 4;
  gravity = 0.75;
  prevSplatCount = 0;
  frameRate(120);
  size(1920, 1080);
  ship = new UFO();
  h = new House();
  beamToggle = false;
  cowCaught = false;
  firstSceneDone = false;
  farmGround = loadImage("farmGround.png");
  background(0);
  for (int i=0; i < 10; i++) {
    cows.add(new Cow(int(random(50, width-50)), int(random(850, height-50))));
  }
  shipXMovement = 0;
  beam_down = new SoundFile(this, "beam_down.mp3");
  beam_const = new SoundFile(this, "beam_const.mp3");
  enter_ship = new SoundFile(this, "enter_ship.mp3");
  engine_hum = new SoundFile(this, "engine_hum.mp3");
  engine_intro = new SoundFile(this, "engine_intro.mp3");
  beam_up = new SoundFile(this, "beam_up.mp3");
  angry_farmer = new SoundFile(this, "angry_farmer.mp3");
  for (int i =0; i < moosSize; i++) {
    String fName = "moo" + (i+1) + ".mp3";
    moos.add(new SoundFile(this, fName));
  }
  for (int i =0; i < dMoosSize; i++) {
    String fName = "dMoo" + (i+1) + ".mp3";
    dMoos.add(new SoundFile(this, fName));
  }
  for (int i =0; i < splatsSize; i++) {
    String fName = "splat" + (i+1) + ".mp3";
    splatMP3s.add(new SoundFile(this, fName));
  }
}

void draw() {
  scene1();
}

void scene1() {
  image(farmGround, 0, 0, width, height);
  h.drawH();
  ship.moveToStartPos();
  if (millis() % mooTime==0) {
    int mooSelect = int(random(0, 10));
    cows.get(mooSelect).moo();
  }
  for (int i=0; i<10; i++)
    cows.get(i).drawCow();
  beamToggleAtmp();

  ship.drawShip();
}

void beamToggleAtmp() {
  if (ship.eHeight()<0) beamToggle = false;
  if (ship.isBeamExtended() && !beamToggle) ship.beamUp();
  else if (!ship.isBeamExtended() && beamToggle) ship.beamDown(700);

  for (int i=0; i<10; i++) {
    if (ship.isBeamExtended()) {
      // If cow is inside the beam
      if (cows.get(i).getX() > ship.beamX() && cows.get(i).getX() < ship.beamX() + ship.beamWidth() && cows.get(i).getY() <= (ship.beamHeight()+ship.getY()+100) && beamToggle) {
        cowCaught = true;
        cows.get(i).abducted(ship.getY());
      } else if (cows.get(i).inAir()) {
        cows.get(i).fall();
        cowCaught = false;
      }
    } else if (cows.get(i).inAir()) {
      cows.get(i).fall();
    }
  }
  if(prevSplatCount < splatCount){
    h.addLight();
    prevSplatCount = splatCount;
  }println(splatCount);
}

void keyPressed() {
  switch (keyCode) {
  case +'A':
  case LEFT:
    shipXMovement = -7;
    ship.move(shipXMovement, 0);
    break;
  case +'D':
  case RIGHT:
    shipXMovement = 7;
    ship.move(shipXMovement, 0);
    break;
  case ' ':
    beamToggle = !beamToggle;
    break;
  case 'L':
    h.addLight();
    break;
  }
}
