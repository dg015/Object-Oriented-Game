class Enemy
{
  int health = 3;
  PVector location;
  boolean attacking;
  Float placeX, placeY;

  Enemy()
  {
    // generate in random locaion

    location = new PVector(random(0, 1080), random(0, 750));
    health = 3;
  }

  void model()
  {
    //println(placeX, placeY);
    rectMode(CENTER);
    ellipse(location.x, location.y, 20, 40);
    rectMode(CORNER);
  }


  int dead(int points)
  {
    if ( health <=0)
    {
      location = new PVector(random(0, 1080), random(0, 750));
      health = 5;
      return points + 1;
      
    }
    return points;
  }

  void teleport(PVector Plocation) //skill inventory 24
  {
    float dist; //skill inventory 9
    dist = PVector.dist(location, Plocation);
    // println(dist);
    if ( dist < 300) //skill invetory 12
    {
      location.x = random( 0, 1000);
      location.y = random (450, 750);
      println("close"); // skill inventory 11
    }
  }
}
