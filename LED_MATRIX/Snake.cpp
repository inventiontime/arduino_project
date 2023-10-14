#include <Snake.h>
#include <LedControl.h>

Snake::Snake(LedControl matrix)
{
  _matrix = matrix;
}


void Snake::setup()
{
  snakePoints[0][0] = 0; snakePoints[0][1] = 7;
  snakePoints[1][0] = 1; snakePoints[1][1] = 7;
  snakePoints[2][0] = 2; snakePoints[2][1] = 7;
  
  snakeLength = 3;
  
  display();
}

void Snake::loop()
{
  if(millis() - prevTime >= snakeTickLength)
  {
    moveInDirection();
    display();
    
    prevTime = millis();
  }
}

void Snake::moveInDirection()
{
  int nextPoint[2];
  getNextPoint(nextPoint, snakePoints[snakeLength-1]);
  
  if(nextPoint[0] == applePoint[0] && nextPoint[1] == applePoint[1]) 
  {
    snakeLength++;
  }
  
  for(int i = 0; i < snakeLength-1; i++) 
  {
    snakePoints[i][0] = snakePoints[i+1][0];
    snakePoints[i][1] = snakePoints[i+1][1];
  }

  snakePoints[snakeLength-1][0] = nextPoint[0];
  snakePoints[snakeLength-1][1] = nextPoint[1];
}

void Snake::display() 
{
  _matrix.clearDisplay(0);
  
  for(int i = 0; i < snakeLength; i++)
    _matrix.setLed(0, snakePoints[i][0], snakePoints[i][1], true);
}

void Snake::getNextPoint(int* nextPoint, int* snakePoint) {
  nextPoint[0] = snakePoints[0];
  nextPoint[1] = snakePoints[1];
  
  switch(snakeDirection) {
    case LEFT:
      nextPoint[0]--;
      break;
  
    case RIGHT:
      nextPoint[0]++;
      break;
      
    case UP:
      nextPoint[1]++;
      break;
    
    case DOWN:
      nextPoint[1]--;
      break;
  }
  
  if(nextPoint[0] == -1)
    nextPoint[0] = 7;
  else if(nextPoint[0] == 8)
    nextPoint[0] = 0;

  if(nextPoint[1] == -1)
    nextPoint[1] = 7;
  else if(nextPoint[1] == 8)
    nextPoint[1] = 0;
}