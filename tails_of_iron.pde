Timer t;
Follower f;
player p;

PImage servitor;
PImage player;
PImage shooting;
PImage moving1;
PImage enemy;
PImage back;


PVector flagP;

ArrayList<Bullets> bulletList = new ArrayList<Bullets>();// skill inventory 24: intialize array
ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
ArrayList<EBullets> EBulletList = new ArrayList<EBullets>();

PVector PlayerLocation;
PVector EnemyLocation;
PVector playerLast;

boolean pressed = false;


boolean dead = false;
int score;

PVector direction;

int cont = 0;

int health = 5;

boolean started;

Enemy[] enemyList = new Enemy[5]; // skill inventory 33 initialize array

void setup()
{
  servitor = loadImage("Servitor.png");
  player = loadImage("Player.png");
  moving1 = loadImage("moving.png");
  shooting = loadImage("shooting.png");
  enemy = loadImage("Enemy.png");
  back = loadImage("background.png");
 
  //set screen size
  size ( 1080, 750);
  //set background color to black
  background(back);
  // create player object
  p = new player();
  //set PVector to player location
  PlayerLocation = p.location;
  //skill inventory 41
  //create little follower object
  f = new Follower(PlayerLocation);// skill inventory 29 used
  //spawn enemies
  for (int i =0; i< enemyList.length; i++)
  {
    enemyList[i] = new Enemy();
    enemyList[i].model();
  }

  //set flag cordinates in random location

  flagP = new PVector (random(100, 150), random(240, 450));// set random 2dVector location location to flag to spawn
  //flagP = PVector.random2D();
}

void flag()
{
  //draw flag
  rect( flagP.x, flagP.y, 50, 50);
}

void enemyFunctions()
{
  //run trough enemy array
  for (int i = 0; i< enemyList.length; i++)
  {

    //draw model
    enemyList[i].model();
    //check if player is close, if so teleport
    enemyList[i].teleport(PlayerLocation);
    // if dead give player score
    enemyList[i].dead(score);
  }

  // run trough EBullet array
  for (int j = EBulletList.size() - 1; j > 0; j--)
  {
    // get and assign EBullet to eb
    EBullets eb = EBulletList.get(j);
    //draws bullets
    eb.model();
    //makes bullet travel
    eb.travel();
    //deal damage to player()
    health = eb.damage(p.location, health);
    //check colision
    if (eb.colision(p.location) == true)
    {
      EBulletList.remove(j);
    }
  }
}

//checks if player has pressed the start key
boolean Checkstart() //skill inventory 21 declaring function that returns
{
  if (key == 'b' || key == 'B') // skill inventory 13 and 14
  {
    return true;
  } else
  {
    return false;
  }
}

void draw()
{

  //check if player has started the game
  if (Checkstart() == true)
  {
    pressed = true;
  }
  if (pressed == false)
  {
    // if not draw this
    fill(0);
    rect(0, 0, 1080, 1080);
    fill(255);
    textSize(80);
    text("Press B to start", width/2-220, height/2+ 150);
    fill(0);
  }
  if ( dead == true)
  {
    //check if player is dead
    //if so draw this
    fill(0);
    rect(0, 0, 1080, 1080);
    fill(255);
    textSize(128);
    text("score", width/2-125, height/2- 100);
    text(score, width/2-100, height/2);
    textSize(80);
    text("Press R to restart", width/2-220, height/2+ 150);
    fill(0);
  } else if (pressed == true)
  {
    // if player has started the game
    background (back); //paint background white inventory skill 5
    println(health);
    scenario(); // draw scenario
    p.model();// draw player model
    p.colision();//player colision
    p.move();// make player walk
    p.applyGravity();// adds gravity to player
    f.model();// draws little follower model
    f.follow(p.location); // makes little folower follow player
    healthSystem(30); //skill inventory 23
    flag();
    if ( frameCount%90 == 0 )
    {
      //make so that an random enemy shoots the player every 3 seconds;
      PVector Ploc = PlayerLocation.copy();
      //get player location
      int enemyNum = int(random(enemyList.length -1));
      // choose random enemy

      PVector dir = Ploc.sub(enemyList[enemyNum].location.x, enemyList[enemyNum].location.y).copy();
      //get location
      // skill inventory find direction and distance between player and enemy 40

      //spawn bullet at enemy location
      EBulletList.add(new EBullets(enemyList[enemyNum].location.copy(), dir.normalize())); // skill inventory 35
    }

    //goes trought function to find all the bullets
    for (int i = bulletList.size() - 1; i>0; i-- )
    {
      Bullets b = bulletList.get(i);
      //draws bullets
      b.model();
      //makes bullet travel
      b.travel();
      //check colision

      for (int j =0; j< enemyList.length; j++)
      {
        //runs trough enemy array
        //checks if enemy has taken damage
        b.damage(enemyList[j]);
        //check if enemy is dead and add score
        score = enemyList[j].dead(score);
      }
      if (b.colision() == true)
      {
        // bulet is destroyed if out of the screen
        bulletList.remove(b);
      }
    }
    //most of enemy functions are here
    enemyFunctions();
    //run trough smoke array
    for ( int i = smokeList.size() -1; i>= 0; i--)
    {
      //assign smoke object from array to s
      Smoke s = smokeList.get(i);// skill inventory 36
      //draw smoke
      s.model();
      //make smoke move
      s.move();
      //check if smoke has left the screen
      if (s.colision() == true)
      {
        //if so destroy it
        smokeList.remove(s);
      }
    }
  }

  if (millis() - timer < 200)
    p.state = 4;
}

void scenario()
{
  //draws scenario
  fill(0); // skill inventory 2: used to draw scenario
  rect(0, 700, 1090, 45);
  rect (50, 550, 150, 45);
  rect (750, 550, 150, 45);
}


void healthSystem(int max)
{

  //check if players has died
  if ( health <= 0)
  {
    println("ded");
    dead = true;
    started = false;
  }
  //makes sure the player cannot go above max health
  if (health > max)
  {
    health = max;
  }
}

void mousePressed() // skill inventory 7
{
  // adds smoke object to araylist
  smokeList.add(new Smoke(p.location));
}

int timer;

void shooting()
{
  switch (keyCode) { //skill inventory 15
    // checks in which direction the player is shooting and shoots a bullet in that direction
  case RIGHT:
    p.state = 4;
    timer = millis();
    direction = new PVector(1, 0); //skill inventory 38: using PVector class
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break; //skill inventory 18 break used
  case UP:
    p.state = 4;
    timer = millis();
    direction = new PVector(0, -1);
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break;
  case LEFT:
    p.state = 4;
    timer = millis();
    direction = new PVector(-1, 0);
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break;
  }
}

//Makes player walk
void keyPressed()
{
  // check if player has pressed start key
  Checkstart(); // skill inventory 21, calling function
  //IS FROM OLD CONTROLLER
  //makes player walk
  if (key == 'd' || (key == 'D'))
  {

    p.right = true;
  }
  if (key == 'w' || (key == 'W') && p.isGrounded)
  {
    p.isGrounded = false;
    p.up = true;
  }
  if (key == 's' || (key == 'S'))
  {
    p.down = true;
  }
  if (key == 'a' || (key == 'A'))
  {
    p.left = true;
  }
  //checks if player wants to restart
  if (( key == 'r') || (key == 'R'))
  {
    started = true;
    if ( dead == true)
    {
      // sets health to max and score to 0
      dead = false;
      health = 5;
      score = 0;
      for (int j =0; j< enemyList.length; j++)
      {
        //runs trough enemy array
        //checks if enemy has taken damage
        enemyList[j].location.y = random(450, 650);
        enemyList[j].location.x = random(0, 1000);
        //check if enemy is dead and add score
      }
    }
  }

  //check for shooting
  shooting();
}


void keyReleased()
{
  //IS FROM OLD CONTROLLER
  //used to make player walk
  if (key == 'd' || (key == 'D'))
  {
    p.right = false;
  }
  if (key == 'w' || (key == 'W'))
  {
    p.up = false;
  }
  if (key == 's' || (key == 'S'))
  {
    p.down = false;
  }
  if (key == 'a' || (key == 'A'))
  {
    p.left = false;
  }
}
