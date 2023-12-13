class player
{
  boolean up, down, left, right, isGrounded;
  PVector location, velocity;
  int state;

  float gravity = 9.1f; //skill invetory 10: global variable created

  float speed = 5;
  player()
  {
    location = new PVector( width/2, height/2);
    velocity = new PVector(25, 25);
  }

  void colision()
  {

    if ( location.x + 48 > 50
      && location.x < 50 + 150
      && location.y + 48 > 550
      && location.y < 550 + 45)
    {
      //player is on the ground so they can jump
      isGrounded = true;
      location.y= 500;
    }

    if ( location.x + 48 > 750
      && location.x < 750 + 150
      && location.y + 48 > 550
      && location.y < 550 + 45)
    {
      //player is on the ground so they can jump
      isGrounded = true;
      location.y= 500;
    }
    if (location.y<145)
    {
      location.y = 145;
    }
    if (location.y>630)
    {
      //player is on the ground so they can jump
      location.y = 630;
      isGrounded = true;
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
    if (up && isGrounded)
    {
      state =2;
      //makes player jump
      // make variable that check is player is on ground false
      isGrounded = false;
      // teleport him some pixels up ahead to give ilusion jumping
      location.y = location.y - 200;
    } else if (down)
    {
      state =2;
      velocity.y += speed;
    } else if (left)
    {
      state = 3;
      velocity.x -= speed ;
    } else if (right)
    {
      state =2;
      velocity.x += speed;
    } else
    {
      state =1;
    }
    location.add(velocity);
  }



  //draws player model
  void model()
  {

    rectMode(CENTER);// skill invetory 3
    rect(location.x, location.y, 48, 48);//skill inventory 1

    rectMode(CORNER);
    //depeding of the player state draw different animations
    if (state == 1)
    {
      image(player, location.x-50, location.y -60, 130, 150);
    } else if (state == 2 )
    {
      image(moving1, location.x-50, location.y -60, 130, 150);
    } else if (state == 3 )
    {
      println("ts");
      pushMatrix();
      translate(location.x, location.y);
      scale(-1, 1);
      image(moving1, -50, -60, 130, 150);
      popMatrix();
    } else if (state == 4)
    {
      image(shooting, location.x + 80, location.y+80, -130, -150); // draws image
    } 
  }
}
