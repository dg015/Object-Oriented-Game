

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

  void damage(PVector player, int health)
  {

    if  (player.x > location.x  && player.x  <location.x +48 && player.y > location.y && player.y < location.y + 24)
    {
      println("damage player");
      health = health - 1;
    }
  }

  boolean ready(float time )
  {
    time -= 1/frameRate;
    if (time == 0)
    {
      return true;
    } else
    {
      time = 2;
      return false;
    }
  }

  boolean colision(PVector player)
  {
    if  (player.x > location.x  && player.x  <location.x +48 && player.y > location.y && player.y < location.y + 24)
    {
      return true;
    }
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


  void model()
  {
    //draws model
    rect(location.x, location.y, 15, 7);
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
