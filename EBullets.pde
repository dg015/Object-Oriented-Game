

class EBullets
{
  PVector location, velocity;
  boolean shootUp, shootRight, shootLeft;
  int direction;
  float traveling = 0.1;
  PVector dir;
  float time = 2;
  EBullets(PVector enemy, PVector direction)
  {
    //create bullet velocity
    //initalize bullet vector
    this.location = enemy;
    this.velocity = direction.copy().mult(5);
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

  int damage(PVector player, int health)
  {

    //if  (player.x >= location.x  && player.x  <=location.x +48 && player.y >= location.y && player.y <= location.y + 24)
    if (player.dist(location) < 10)
    {
      println("damage player");
      health = health - 1;
    }
    
    return health;
  }
  void travel()
  {

    location.add(velocity);
  }


  boolean colision(PVector player)
  {
    //if  (player.x >= location.x  && player.x  <=location.x +48 && player.y >= location.y && player.y <= location.y + 24)
    if (player.dist(location) < 10) //skill inventory 6.
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
}
