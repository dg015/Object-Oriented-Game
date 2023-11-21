class Smoke
{
  PVector location, velocity;
  Smoke(PVector Ploc) // skill inventory: 28
  {
    location = new PVector(Ploc.x, Ploc.y);
    velocity = new PVector( 0, -2);
  }


  void model()
  {
    fill(211, 211, 211, 25);
    circle(location.x, location.y, 15);
  }
  void move()
  {

    location.add(velocity);
  }

  boolean colision()
  {
    if (location.y >750)
    {

      return true;
    }
    else
    {
      return false;
    }
  }
}
