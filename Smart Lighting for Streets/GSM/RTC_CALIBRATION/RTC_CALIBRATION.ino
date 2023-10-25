#include <DS1302.h>

DS1302 rtc(2, 3, 4);

void setup()
{
  // Set the clock to run-mode, and disable the write protection
  rtc.halt(false);
  rtc.writeProtect(false);
  

  Serial.begin(9600);
  rtc.setDOW(SATURDAY);        // Set Day-of-Week to FRIDAY
  rtc.setTime(8, 50, 10);     // Set the time to 12:00:00 (24hr format)
  rtc.setDate(2, 3, 2018);   // Set the date to August 6th, 2010
}

void loop()
{
  Serial.println(rtc.getTimeStr());
  delay(200);
}