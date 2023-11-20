class Enemy
{
  int health = 3;
  PVector location;
  boolean attacking;

  Enemy()
  {
  }
  void attack(PVector Ploc)
  {
    if (Ploc.x > location.x  && Ploc.x  <location.x +48 && Ploc.y > location.y && Ploc.y < location.y + 48)
    {
      attacking = true;
    } else
    {
      attacking = false;
    }
  }
}
