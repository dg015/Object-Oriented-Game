

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
    this.velocity = direction.copy().mult(15);
    droneShoot.play();
  }


  int damage(PVector player, int health) // skill inventory 23
  {
    // check if player is in damage range and deals damage to player health
    if (player.dist(location) < 10)
    {
      hurt.play();
      health = health - 1;
    }

    return health;
  }
  void travel()
  {
    //add velocity to location so bullet can travel the screen
    location.add(velocity);
  }


  boolean colision(PVector player)
  {
    // if bullet is out of screen return true to destroy bullet
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
    rectMode(CENTER);
    rect(location.x, location.y, 15, 7);
    rectMode(CORNER);
  }
}
