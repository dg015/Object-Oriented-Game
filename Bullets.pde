

class Bullets
{
  PVector location, velocity;
  int direction;
  Bullets(float X, float Y, PVector direction)// skill inventory 30: constructor with parametrs
  {

    location = new PVector (X, Y);
    this.velocity = direction.copy().mult(25);
  }


  void model()
  {
    //draws model
    rect(location.x, location.y, 15, 7);
  }


  void damage(Enemy enemy)
  {
    //if  (player.x >= location.x  && player.x  <=location.x +48 && player.y >= location.y && player.y <= location.y + 24)
    if (enemy.location.dist(location) < 25)
    {
      println("damage enemy");
      enemy.health = enemy.health - 1;
    }
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
