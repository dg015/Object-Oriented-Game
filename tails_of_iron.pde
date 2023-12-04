Timer t;
Follower f;
player p;


PVector flagP;

ArrayList<Bullets> bulletList = new ArrayList<Bullets>();// skill inventory 24: intialize array
ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
ArrayList<EBullets> EBulletList = new ArrayList<EBullets>();

PVector PlayerLocation;
PVector EnemyLocation;
boolean dead;
int enemyHealth;
int lives = 12;
int score;
PVector direction;

int cont = 0;

int health = 25;

Enemy[] enemyList = new Enemy[5]; // skill inventory 33 initialize array

void setup()
{
  t = new Timer(1);
  p = new player();
  PlayerLocation = p.location;
  size ( 1080, 750);
  
   flagP = new PVector (random(100, 150), random(240, 450));// set random 2dVector location location to flag to spawn
   //skill inventory 41
  f = new Follower(PlayerLocation);// skill inventory 29 used
  for (int i =0; i< enemyList.length; i++)
  {

    enemyList[i] = new Enemy();
    enemyList[i].model();
  }
}

void flag()
{

  rect( flagP.x, flagP.y, 50, 50);
}

void enemyFunctions()
{

  while ( cont< enemyList.length -1 ) // skill inventory 16 while loop
  {
    cont++;
    enemyList[cont] = new Enemy(); // skill inventory 33 populate array
  }


  for (int i = 0; i< enemyList.length; i++)
  {


     enemyList[i].model();
     enemyList[i].teleport(PlayerLocation);
    //println(enemyList[i].location);

    for (int j = 0; j<EBulletList.size(); j ++)// skill inventory 17 nested loop
    {

      EBullets eb = EBulletList.get(j);
      //draws bullets
      eb.model();
      //makes bullet travel
      eb.travel();
      //deal damage to player()
      eb.damage(p.location, health);
      //check colision
      eb.ready(2);


      if (eb.colision(p.location) == true)
      {

        EBulletList.remove(eb);
      }
    }
  }
  // runts trough array and calls all fucnctions for the enemy
}

boolean Checkstart() //skill inventory 21 declaring function that returns
{
  if (key == 'b' || key == 'B') // skill inventory 13 and 14
  {
    //println("yay");
    return true;
  } else
  {
    return false;
  }
}

void draw()
{
  if ( dead == true)
  {
    //death screen
  } else
  {

    background (255); //paint background white inventory skill 5
    enemyFunctions();
    scenario();
    p.model();
    p.colision();
    p.move();
    p.applyGravity();
    
    flag();
    /* for ( int i = 1; i < enemyList.length; i++)
     {
     
     //calls function model to draw enemy
     
     enemyList[i].attack( PlayerLocation);
     
     t.time = 2;
     t.countDown();
     if (enemyList[i].health <= 0)
     {
     //if ded destroy enemy object
     score= score + 1 ;
     //recover 1 health
     lives = lives + 1;
     
     //delete enemy object
     
     }
     
     //create timer to shoot
    /*if (t.time < 0)
     {
     //after 2 seconds restart the timer
     t.time =2;
     //run trought array, get location of enemies, subtract the location vector with the player location vector to get diretcion
     // spawn bullet near enemy to shoot the player
     PVector direction = new PVector(PlayerLocation.x, PlayerLocation.y).sub(enemyList[i].location.x, enemyList[i].location.y);
     EBulletList.add(new EBullets(enemyList[i].location, direction.normalize()));
     }
     } */

    for ( int i = smokeList.size() -1; i>= 0; i--)
    {
      Smoke s = smokeList.get(i);
      s.model();
      s.move();
      if (s.colision() == true)
      {
        smokeList.remove(s);
      }
    }
  }
}

void scenario()
{
  //draws scenario
  fill(0); // skill inventory 2: used to draw scenario
  rect(0, 700, 1090, 45);
  rect (50, 550, 150, 45);
  rect (750, 550, 150, 45);
}


void healthSystem()
{
  //check if players has died
  if ( lives < 0)
  {
    // if died print ded and end game
    dead = true;
  }
}

void mousePressed() // skill inventory 7
{

  smokeList.add(new Smoke(p.location));
}

void shooting()
{

  switch (keyCode) { //skill inventory 15
  case RIGHT:
    direction = new PVector(1, 0); //skill inventory 38: using PVector class
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break; //skill inventory 18 break used
  case UP:
    direction = new PVector(0, -1);
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break;
  case LEFT:
    direction = new PVector(-1, 0);
    //skill inventory 34: populating array
    bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
    break;
  }
  /*
  //depending what arrow key you press that`s the direction you will shoot
   if (keyCode== RIGHT)
   {
   //SHOOTING
   direction = new PVector(1, 0); //skill inventory 38: using PVector class
   //skill inventory 34: populating array
   bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
   }
   if (keyCode == UP)
   {
   direction = new PVector(0, -1);
   bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
   }
   if (keyCode == DOWN )
   {
   //work on this later
   }
   if (keyCode == LEFT)
   {
   direction = new PVector(-1, 0);
   bulletList.add(new Bullets(PlayerLocation.x, PlayerLocation.y, direction));
   }*/
}

//Makes player walk
void keyPressed()
{

  Checkstart(); // skill inventory 21, calling function
  //IS FROM OLD CONTROLLER

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
  //check for shooting
  shooting();
}


void keyReleased()
{
  //IS FROM OLD CONTROLLER
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
