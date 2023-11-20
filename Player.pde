class Player
{
  boolean up, down, left, right;
  PVector location, velocity;

  float speed = 5;
  Player()
  {
    location = new PVector( width/2, height/2);
    velocity = new PVector(25, 25);
  }

  void colision()
  {


    if (location.y<145)
    {
      location.y = 145;
    }


    if (location.x< 0)
    {
      location.x = 0;
    }
    if (location.x > 1000)
    {
      location.x = 1000;
    }
  }

  void move()
  {

    velocity = new PVector(0, 0);
    // println(location);

    if (down)
    {
      velocity.y += speed;
    }
    if (left)
    {
      velocity.x -= speed ;
    }
    if (right)
    {
      velocity.x += speed;
    }
    location.add(velocity);
  }
  
  //draws player model
  void model()
  {
    
    rectMode(CENTER);// skill invetory 3
    rect(location.x, location.y, 48, 48);//skill inventory 1
    rectMode(CORNER);
  }
}
