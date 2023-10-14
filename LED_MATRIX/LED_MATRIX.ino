#include <LedControl.h>
#include <Snake.h>

/////////////////////////////////////////////////////////     PINS
int dataPin = 12;
int clockPin = 11;
int csPin /*loadPin*/ = 10;

int horizontalPin = A1;
int verticalPin = A2;

/////////////////////////////////////////////////////////     INPUT
enum Direction { UP, DOWN, LEFT, RIGHT, NONE };
Direction horizontal;
Direction vertical;

/////////////////////////////////////////////////////////     MATRIX
LedControl matrix = LedControl(dataPin, clockPin, csPin, 1);
Snake snake = Snake(matrix);

void setup() {
  Serial.begin(9600);
  
  matrix.shutdown(0, false);
  matrix.setIntensity(0, 5);
  
  snake.setup();
}

void loop()
{
  readInput();
  snake.loop();
}

void readInput()
{
  int horizontalRead = analogRead(horizontalPin);
  int verticalRead = analogRead(verticalPin);

  if (horizontalRead > 750)
    horizontal = RIGHT;
  else if (horizontalRead > 250)
    horizontal = LEFT;
  else
    horizontal = NONE;

  if (verticalRead > 750)
    vertical = UP;
  else if (verticalRead > 250)
    vertical = DOWN;
  else
    vertical = NONE;
}