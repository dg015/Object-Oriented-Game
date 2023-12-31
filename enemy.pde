class Enemy
{
  int health = 3;
  PVector location;
  boolean attacking;
  Float placeX, placeY;

  Enemy()
  {
    // generate in random locaion
    location = new PVector(random(0, 1080), random(0, 650));
    health = 3;
  }

  void model()
  {
    //println(placeX, placeY);
    rectMode(CENTER);
    ellipse(location.x, location.y, 20, 40);
    image(enemy, location.x -65, location.y-75, 130, 150);// draws image
    rectMode(CORNER);
  }


  int dead(int points)
  {
    //if enemy is dead
    if ( health <=0)
    {
      DroneDestroy.play();
      // teleport to random location
      location = new PVector(random(0, 1080), random(0, 650));
      // set health to full
      health = 5;
      //add one point
      return points + 1;
    }
    return points;
  }

  void teleport(PVector Plocation) //skill inventory 24
  {
    float dist; //skill inventory 9
    //gets distance from player to enemy
    dist = PVector.dist(location, Plocation);
    // println(dist);
    //if close enough
    if ( dist < 300) //skill invetory 12
    {
      // teleport away to random location
      location.x = random( 0, 1000);
      location.y = random (450, 650);
      println("close"); // skill inventory 11
    }
  }
}
