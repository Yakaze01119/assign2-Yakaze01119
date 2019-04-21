final int gameStart = 0;
final int gameRun = 1;
final int gameLose = 2;
final int idle = 3;
final int down = 4;
final int left = 5;
final int right = 6;
final int startHp = 2;
int state = gameStart;
int groundhogMove = idle;
int playerHealth = 2;

PImage bg, gameOver, title, soil;
PImage cabbage, soldier, life;
PImage restartHovered, restartNormal;
PImage startHovered, startNormal;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;

float buttonX = 248;
float buttonY = 360;
float buttonWidth = 144;
float buttonHeight = 60;

float groundhogX = 320;
float groundhogY = 80;
float box = 80;
float speed = box/16;
float timer = 0;

float soldierX = -80;
float soldierY = 160;
float cabbageX = 0;
float cabbageY = 160;

int lifeX = 10;
int lifeY = 10;

boolean downPressed, leftPressed, rightPressed;

void setup() {
	size(640, 480);

	// IMAGE
  bg = loadImage("img/bg.jpg");
  gameOver = loadImage("img/gameover.jpg");
  title = loadImage("img/title.jpg");
  soil = loadImage("img/soil.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  life = loadImage("img/life.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
  // Sansu
  soldierY = soldierY + 80 * floor(random(0,4));
  cabbageX = 80 * floor(random(0,8));
  cabbageY = cabbageY + 80 * floor(random(0,4));
}

void draw() {
	switch(state){
  
		case gameStart:
      background(title);
      image(startNormal, buttonX, buttonY);
      
      // StartPressed
      if(mouseX > buttonX && mouseX < buttonX+buttonWidth &&
      mouseY > buttonY && mouseY < buttonY+buttonHeight){
        image(startHovered, buttonX, buttonY);
        if(mousePressed){
          if(mouseButton == LEFT){
            state = gameRun;
          }
        }
      }

      break;
      
		case gameRun:
      imageMode(CORNERS);
      background(bg);
      colorMode(RGB);
      
      // Sun
      strokeWeight(5);
      stroke(255,255,0);
      fill(253,184,19);
      ellipse(590,50,120,120);
      
      // Soil
      image(soil, 0,160);
      noStroke();
      fill(124,204,25);
      rect(0,145,640,15);
      
      // Cabbage
      image(cabbage, cabbageX, cabbageY);
      if(groundhogX+box > cabbageX && groundhogX < cabbageX+box &&
      groundhogY+box > cabbageY && groundhogY < cabbageY+box){
        playerHealth ++;
        cabbageX = width + box;
        cabbageY = height + box;
      }
      
      // Solaier
      image(soldier, soldierX, soldierY);
      soldierX += 4;
      if(soldierX > 720){
        soldierX = -80;
      }
      
      // Control Groundhog
      switch(groundhogMove){
        
        case idle:
          image(groundhogIdle,groundhogX,groundhogY);
          timer = 0;
          if(downPressed){
            groundhogMove = down;
          }else if(leftPressed){
            groundhogMove = left;
          }else if(rightPressed){
            groundhogMove = right;
          }
          break;
        case down:
          image(groundhogDown,groundhogX,groundhogY);
          groundhogY += speed;
          timer ++;
          if(timer == 16){
            downPressed = false;
            groundhogMove = idle;
          }
          if(groundhogY > height-box){
            groundhogY = height-box;
            downPressed = false;
            groundhogMove = idle;
          }
          break;
        case left:
          image(groundhogLeft,groundhogX,groundhogY);
          groundhogX -= speed;
          timer ++;
          if(timer == 16){
            leftPressed = false;
            groundhogMove = idle;
          }
          if(groundhogX < 0){
            groundhogX = 0;
            leftPressed = false;
            groundhogMove = idle;
          }
          break;
        case right:
          image(groundhogRight,groundhogX,groundhogY);
          groundhogX += speed;
          timer ++;
          if(timer == 16){
            rightPressed = false;
            groundhogMove = idle;
          }
          if(groundhogX > width-box){
            groundhogX = width-box;
            rightPressed = false;
            groundhogMove = idle;
          }
          break;
          
      }
      
      if(groundhogX+box > soldierX && groundhogX < soldierX+box &&
      groundhogY+box > soldierY && groundhogY < soldierY+box){
        groundhogX = 320;
        groundhogY = 80;
        groundhogMove = idle;
        downPressed = false;
        leftPressed = false;
        rightPressed = false;
        playerHealth --;
      }
      
      // Life
      if(playerHealth == 5){
      for(int i = 0; i<5; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 4){
      for(int i = 0; i<4; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 3){
      for(int i = 0; i<3; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 2){
      for(int i = 0; i<2; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 1){
      for(int i = 0; i<1; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 0){
      state = gameLose;
      }else{
      playerHealth = 5;
    }

      break;
      
		case gameLose:
      background(gameOver);
      image(restartNormal, buttonX, buttonY);
      
      // RestartPressed
      if(mouseX > buttonX && mouseX < buttonX+buttonWidth &&
      mouseY > buttonY && mouseY < buttonY+buttonHeight){
        image(restartHovered, buttonX, buttonY);
        if(mousePressed){
          if(mouseButton == LEFT){
            playerHealth = startHp;
            soldierY = 160 + 80 * floor(random(0,4));
            cabbageX = 80 * floor(random(0,8));
            cabbageY = 160 + 80 * floor(random(0,4));
            state = gameRun;
          }
        }
      }
  }
}

void keyPressed(){
  switch(keyCode){
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
  }
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
  }
}
