class Enemy
{
  int health = 3;
  PVector location;
  boolean attacking;
  Float placeX, placeY;
  Enemy()
  {
    // generate in random locaion
    placeX =  random( 0, 1080); // skill inventory 6
    placeY =  random( 0, 750); // skill inventory 6\
    location = new PVector(placeX, placeY);
  }

  void model()
  {
    //println(placeX, placeY);
    ellipse(location.x, location.y, 20, 40);
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
