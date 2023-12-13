import processing.sound.*;

Timer t;
Follower f;
player p;

PImage servitor;
PImage player;
PImage shooting;
PImage moving1;
PImage enemy;
PImage back;
PImage deathScreen;
PImage startScreen;

SoundFile shootSound;
SoundFile death;
SoundFile droneShoot;
SoundFile hurt;
SoundFile DroneDestroy;

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
  //loading images
  servitor = loadImage("Servitor.png"); //taken out of https://www.reddit.com/r/Warhammer40k/comments/rp8u3d/a_servoskull_pixel_art_gif_i_made_impressed_by/
  player = loadImage("Player.png");//take out of https://www.dakkadakka.com/dakkaforum/posts/list/793890.page?userfilterid=115122
  moving1 = loadImage("moving.png");//take out of https://www.dakkadakka.com/dakkaforum/posts/list/793890.page?userfilterid=115122
  shooting = loadImage("shooting.png"); //take out of https://www.dakkadakka.com/dakkaforum/posts/list/793890.page?userfilterid=115122
  enemy = loadImage("Enemy.png"); //taken out of https://www.artstation.com/artwork/rx5qL
  back = loadImage("background.png"); // taken out of https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/2adda209-260d-4e88-9767-e43eea79ff2b/df3ih2h-bcf852f9-d037-499b-b6bf-161c4958ce9a.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzJhZGRhMjA5LTI2MGQtNGU4OC05NzY3LWU0M2VlYTc5ZmYyYlwvZGYzaWgyaC1iY2Y4NTJmOS1kMDM3LTQ5OWItYjZiZi0xNjFjNDk1OGNlOWEucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.dgSzNM9VGZHOKSMk4YaVflDFzAE6PR9dqWD2e2KVT0E
  deathScreen = loadImage("Death.png"); // taken out of https://petitspixels.com/blg/wp-content/uploads/2017/11/8-bit-skulls-and-bones-pattern-red-petitspixels.png
  startScreen = loadImage("start.jpg"); // taken out of https://cdna.artstation.com/p/assets/images/images/033/285/444/large/tom-parke-screen-shot-2020-12-27-at-10-53-34-pm.jpg?1609074582


  //setting up sounds
  shootSound = new SoundFile(this, "shootSound.mp3"); //taken out of https://www.youtube.com/watch?v=wYLhnIrDrNU
  death = new SoundFile(this, "Death.mp3");// taken out of https://www.youtube.com/watch?v=wYLhnIrDrNU
  hurt = new SoundFile(this, "Hurt.mp3");// taken out of https://www.youtube.com/watch?v=wYLhnIrDrNU
  droneShoot = new SoundFile(this, "DroneShooting.mp3"); //taken out of https://www.youtube.com/watch?v=J4Sa8D8nF6w
  DroneDestroy = new SoundFile(this, "DroneExplode.mp3"); //taken out of https://www.youtube.com/watch?v=bFcaED35iB4
  //set screen size
  size ( 1080, 750);
  //set background color to black
  background(back);
  // create player object
  p = new player();
  //set PVector to player location
  PlayerLocation = p.location;
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
}


void UI()
{
  //draws UI 
  fill(0, 0, 0, 100);
  textSize(80);
  text("HP: " + health, 15, 80);
  text("SCORE: " + score, 200, 80);
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
    image(startScreen, 0, 0);
    fill(255);
    textSize(80);
    text("Press B to start", width/2-270, height/2+ 150);
    fill(0);
  }
  if ( dead == true)
  {
    //check if player is dead
    //if so draw this
    fill(0);
    rect(0, 0, 1080, 1080);
    image(deathScreen, 0, 0);
    fill(255);
    textSize(128);
    text("score", width/2-165, height/2- 100);
    text(score, width/2-50, height/2);
    textSize(80);
    text("Press R to restart", width/2-220, height/2+ 150);
    fill(0);
  } else if (pressed == true)
  {
    // if player has started the game
    background (back); //Put image as background image, inventory skill 5

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
      // skill inventory 40 find direction and distance between player and enemy

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

      for (int j =0; j< enemyList.length; j++)// skill inventory 17
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
    for ( int i = smokeList.size() -1; i>= 0; i--) // skill inventory 16
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
    UI();// draws UI
  }

  if (millis() - timer < 200)
    p.state = 4;
  //if (millis() - timer < 200)
  //  p.state = 5;
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
    death.play();
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
  p.isFacingLeft = false;
    shootSound.play();
    p.state = 4;
    timer = millis();
    direction = new PVector(1, 0); //skill inventory 38: using PVector class
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break; //skill inventory 18 break used
  case UP:
    shootSound.play();
    p.state = 4;
    timer = millis();
    direction = new PVector(0, -1);
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break;
  case LEFT:
  p.isFacingLeft = true;
    shootSound.play();
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
      death.play();
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
