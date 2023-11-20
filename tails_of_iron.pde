Timer t;

Player p;


PVector PlayerLocation;
PVector EnemyLocation;
boolean dead;
int enemyHealth;
int lives = 12;
int score;




void setup()
{
  t = new Timer(1);
  p = new Player();
}

void draw()
{
  if ( dead == true)
  {
    //death screen
  } else
  {
    for ( int i = 1; i < enemyList.length; i++)
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
       }*/
    }
  }
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


void keyPressed()
{
  //Makes player walk

  //IS FROM OLD CONTROLLER

  if (key == 'd' || (key == 'D'))
  {
    p.right = true;
  }
  if (key == 'w' || (key == 'W'))
  {
    
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
