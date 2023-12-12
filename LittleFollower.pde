class Follower
{
  PVector out;
  
  PVector location;
  Follower( PVector Ploc) // skill inventory 30
  {
    location = new PVector( Ploc.x- 15,Ploc.y-15);
  }


  void follow(PVector Ploc)
  {
    location.lerp(Ploc.x, Ploc.y, 0.0, 0.1);// skill inventory 43 used by using lerp function
  }
  void model()
  {
    out = PVector.random2D();// random 2d vector used  41
    image(servitor,location.x + out.x,location.y+ out.y,100,100);
    
    //rect(location.x, location.y, 20, 20);
  }
}
