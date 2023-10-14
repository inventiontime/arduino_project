#ifndef Snake_h
#define Snake_h

#include <LedControl.h>

class Snake 
{
  public:
    Snake(LedControl);
    
    void setup();
    void loop();
  
  
  private:
    LedControl _matrix;
    
    long snakeTickLength = 1000;
    
    long prevTime;
    int snakePoints[70][2];
    int applePoint[2];
    int snakeLength;
    Direction snakeDirection = RIGHT;
    
    void moveInDirection();
    void display();
    void getNextPoint(int* nextPoint, int* snakePoint);
};

#endif