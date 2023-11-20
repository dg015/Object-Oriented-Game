

class EBullets
{

  PVector location, velocity;
  int direction;
  EBullets(PVector enemy, PVector direction)
  {
    //create bullet velocity
    //initalize bullet vector
    this.location = new PVector (enemy.x, enemy.y);
    this.velocity = direction.copy().mult(25);
  }


  void travel()
  {

    location.add(velocity);
  }
  boolean colision()
  {
    if (location.x> 1080)
    {
      return true;
    }
    if ( location.x < 0)
    {
      return true;
    }

    if (location.y >750)
    {

      return true;
    }
    if (location.y < 0)
    {
      return true;
    } else
    {
      return false;
    }
  }
}
