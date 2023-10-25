#include <DS1302.h>

DS1302 rtc(2, 3, 4);

void setup()
{
  // Set the clock to run-mode, and enable the write protection
  rtc.writeProtect(true);
  Serial.begin(9600);
}

void loop()
{
  Serial.println(rtc.getTimeStr());
  delay(200);
}