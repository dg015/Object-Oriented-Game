class player
{
  boolean up, down, left, right;
  PVector location, velocity;
  
  float gravity = 9.1f; //skill invetory 10: global variable created

  float speed = 5;
  player()
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

  
  void applyGravity() //skill inventory 20 used, new function created with no paramenters and no return type
  {
    //pulls player downwards at all times
    velocity.y += gravity; // skill inventory 8 used: += used
    location.add(velocity); // skill inventory 39 used: calculating gravity velocity 
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
