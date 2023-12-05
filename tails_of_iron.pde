Timer t;
Follower f;
player p;


PVector flagP;

ArrayList<Bullets> bulletList = new ArrayList<Bullets>();// skill inventory 24: intialize array
ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
ArrayList<EBullets> EBulletList = new ArrayList<EBullets>();

PVector PlayerLocation;
PVector EnemyLocation;
PVector playerLast;

boolean dead = false;
int score;

PVector direction;

int cont = 0;

int health = 5;

boolean started;

Enemy[] enemyList = new Enemy[5]; // skill inventory 33 initialize array

void setup()
{
  size ( 1080, 750);
  background(255);

  p = new player();
  PlayerLocation = p.location;
  //skill inventory 41
  f = new Follower(PlayerLocation);// skill inventory 29 used
  for (int i =0; i< enemyList.length; i++)
  {

    enemyList[i] = new Enemy();
    enemyList[i].model();
  }

  t = new Timer(1);
  flagP = new PVector (random(100, 150), random(240, 450));// set random 2dVector location location to flag to spawn
  playerLast = PlayerLocation;
  t.time = 2;
}

void flag()
{

  rect( flagP.x, flagP.y, 50, 50);
}

void enemyFunctions()
{

  while ( cont< enemyList.length -1 )
  {
    cont++;
    enemyList[cont] = new Enemy();
  }


  for (int i = 0; i< enemyList.length; i++)
  {


    enemyList[i].model();
    enemyList[i].teleport(PlayerLocation);
    enemyList[i].dead(score);
    //println(enemyList[i].location);
    // old code
    //if code to populate ebullet array is outside it works
  }

  for (int j = EBulletList.size() - 1; j > 0; j--)
  {

    EBullets eb = EBulletList.get(j);
    //draws bullets
    eb.model();
    //makes bullet travel
    eb.travel();
    //deal damage to player()
    health = eb.damage(p.location, health);
    //check colision
    eb.ready(2);


    if (eb.colision(p.location) == true)
    {
      EBulletList.remove(j);
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
  if (started == false)
  {
    fill(0);
    rect(0, 0, 1080, 1080);
    fill(255);
    textSize(128);
    text("score", width/2-125, height/2- 100);
    text(score, width/2-100, height/2);
    textSize(80);
    text("Press R to restart", width/2-220, height/2+ 150);
    fill(0);
  }
  if ( dead == true)
  {
    fill(0);
    rect(0, 0, 1080, 1080);
    fill(255);
    textSize(128);
    text("score", width/2-125, height/2- 100);
    text(score, width/2-100, height/2);
    textSize(80);
    text("Press R to restart", width/2-220, height/2+ 150);
    fill(0);
  } else if (started == true)
  {

    background (255); //paint background white inventory skill 5
    println(health);
    scenario();
    p.model();// draw player model
    p.colision();//player colision
    p.move();// make player walk
    p.applyGravity();
    healthSystem(30); //skill inventory 23
    flag();
    if ( frameCount%90 == 0 )
    {

      PVector Ploc = PlayerLocation.copy();
      int enemyNum = int(random(enemyList.length -1));


      PVector dir = Ploc.sub(enemyList[enemyNum].location.x, enemyList[enemyNum].location.y).copy();
      // skill inventory find direction and distance between player and enemy 40
      stroke(255, 0, 0);


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
        b.damage(enemyList[j]);
        score = enemyList[j].dead(score);
      }
      if (b.colision() == true)
      {
        //fix this ( crashes after shooting)
        bulletList.remove(b);
      }
    }
    enemyFunctions();
    for ( int i = smokeList.size() -1; i>= 0; i--)
    {
      Smoke s = smokeList.get(i);// skill inventory 36
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


void healthSystem(int max)
{

  //check if players has died
  if ( health <= 0)
  {
    println("ded");
    dead = true;
    started = false;
  }

  if (health > max)
  {
    health = max;
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
  if (( key == 'r') || (key == 'R'))
  {
    started = true;

    if ( dead == true)
    {
      
      dead = false;
      health = 5;
      score = 0;
    }
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
