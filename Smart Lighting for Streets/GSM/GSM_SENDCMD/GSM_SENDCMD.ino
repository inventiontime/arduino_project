#include <SoftwareSerial.h>
SoftwareSerial GPRS(12, 13);

unsigned char buffer[64];
int count = 0;

void setup() {
  GPRS.begin(9600);
  Serial.begin(9600);
  
  SendMsg("HI HOW");
}

void loop() {
  while (GPRS.available()){
    buffer[count++] = GPRS.read();
    if (count == 64) break;
  }

  Serial.write(buffer, count);
  clearBufferArray();
  count = 0;
  
  //if(Serial.available()){
  //  byte b = Serial.read();
  //  if (b == '*')
  //    GPRS.write(0x1a);                 // ASCII CTRL+Z
  //  else
  //    GPRS.write(b);
  //}
}

void clearBufferArray() {
  for (int i = 0; i < count; i++) {
    buffer[i] = NULL;
  }
}

void SendMsg(String text1) {
  GPRS.println("AT+CMGF=1");                  // AT command to set module in SMS mode
  delay(500);
  GPRS.println("AT+CMGS=\"+919618944678\"");                      // AT command for sending SMS
  delay(500);
  GPRS.println(text1 + (char)26);                         // The SMS text to be sent
  //delay(500);
  //GPRS.println((char)26);                     // ASCII code of CTRL+Z
  delay(5000);
}