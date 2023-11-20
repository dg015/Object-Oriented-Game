class Timer
{

  //timer
  float time;

  //class time
  Timer (float set)
  {
    time = set;
  }
  //gets time
  float getTime()
  {
    return(time);
  }
  //funtion to set the time
  void setTime(float set )
  {
    time = set;
  }
  //increase timer by second
  void countUp()
  {
    time += 0.001/frameRate;
  }
  //descreases timer by second
  void countDown()
  {
    time -= 0.001/frameRate;
  }
}
