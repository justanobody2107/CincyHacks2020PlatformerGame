import processing.sound.*;
SoundFile gametheme, gameover;
String[] imFiles = {"Ground.png", "TulipRun1.png", "TulipRun2.png", "TulipRun3.png", "TulipStill.png", "TulipDead.png", "TulipJump.png", "BgWithTrees.png", "MeanPlant1.png"};
PImage[] im = new PImage[9];
void setup() {
  size(1080, 720);
  for (int i = 0; i < 9; i = i + 1) {
    im[i] = loadImage(imFiles[i]);
  }
  gametheme = new SoundFile(this, "GameTheme.wav");
  gameover = new SoundFile(this, "GameOver.wav");
  gametheme.play();
}
 
int DIM = 50;
int SPD = 4;
int BOLD = 4;
int FLOOR = 600;
int dir;
int gx = 980;
float y = FLOOR;
float x = 0;
float px = 0;
int loop = 0;
float JUMP = height + y - 300;
boolean walking;
int anim = 1;
int frame = 0;
boolean started = false;
boolean help = false;

void draw() {
  background(0);
  textAlign(CENTER);
  textSize(40);
  text("Welcome to Leafs and Bounds", width / 2, height / 2);
  textSize(20);
  text("Created by the Plastic Bags 2.0", width / 2, height / 2 - 50);
  text("Press ENTER to start!", width / 2, height / 2 + 50);
  text("Press H for help!", width / 2, height / 2 + 100);
  if (help == true){
    background(0);
    textSize(20);
    text("Press enter to start game", width / 2, height / 2 - 100);
    text("Left and right arrow keys to move left and right", width / 2, height / 2 - 50);
    text("Up key to jump", width / 2, height / 2);
    text("Jump over the obstacles to stay alive (score coming soon in v0.0.2)", width / 2, height / 2 + 50);
    text("Game ends when you hit an obstacle", width / 2, height / 2 + 100);
  }  
  if (started == true){
    image(im[7], 0, 0);
    if (dir != 0){
      move();
    }
    if (walking == true){
      if (anim >= 4){
        anim = 1;
        frame = 0;
      }
      if (frame <= 6 && frame > 5){
        anim = anim + 1;
      }
      if (frame <= 12 && frame > 11){
        anim = anim + 1;
      }
      if (frame <= 26 && frame > 25){
        anim = anim + 1;
      }
    }
    if (gx <= 0){
      px = random(20, 150);
    }
    if (gx >= 980){
      px = random(20, 150);
    }
  
    if (width / 2 + 50 > gx && width / 2 - 50 < gx + 50){
      if ( y + 100 > 720 - px){
        anim = 5;
        noLoop();
        background(0);
        textAlign(CENTER);
        textSize(40);
        text("Game Over", width / 2, height / 2);
        gametheme.stop();
        gameover.play();
        keyPressed();
      }
    }
  
    image(im[anim], width / 2 - 50, y - x);
    image(im[0], gx-1236, 700);
    image(im[0], gx-980, 700);
    image(im[0], gx-724, 700);
    image(im[0], gx-468, 700);
    image(im[0], gx-212, 700);
    image(im[0], gx+44, 700);
    image(im[0], gx+300, 700);
    image(im[0], gx+556, 700);
    image(im[0], gx+812, 700);
    image(im[0], gx+1068, 700);
    image(im[8], gx, 720-px);
    walking = false;
  }
}

void keyPressed() {
  if (keyCode == UP){
    if (dir == 0)  dir = -SPD;
    anim = 6;
  }
  if (keyCode == LEFT){
    walking = true;
    gx = gx + 5;
    frame = frame + 1;
  }
  if (keyCode == RIGHT){
    walking = true;
    gx = gx - 5;
    frame = frame + 1;
  }
  if (key == ENTER) {
    started = true;
  }
  if (keyCode == 72) {
    help = true;
  }
  if (gx <= -44){
    gx = 980;
  }
  if (gx >= 1024){
    gx = 0;
  }
}
 
void move() {
  keyPressed();
  if ((y += dir) < JUMP) {
    dir *= -1;
    anim = 6;
    }
  else if (y > FLOOR) {
    dir = 0;
    y = FLOOR;
    anim = 1;
    frame = 0;
  }
}
 
