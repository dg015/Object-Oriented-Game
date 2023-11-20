class Enemy
{
  int health = 3;
  PVector location;
  boolean attacking;

  Enemy()
  {
  }
  void attack(PVector Ploc)
  {
    if (Ploc.x > location.x  && Ploc.x  <location.x +48 && Ploc.y > location.y && Ploc.y < location.y + 48)
    {
      attacking = true;
    } else
    {
      attacking = false;
    }
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
