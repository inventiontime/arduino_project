int sensor = A0;        // connecting sensor to analog port
int currentVal;         // variable to store the corresponding analog value

void setup()
{
  pinMode(sensor, INPUT);       // setting the sensor as input
  Serial.begin(9600);           // setting the Baud rate for serial monitor
}

void loop()
{
  currentVal = analogRead(sensor);      // reading the sensor value
  Serial.println((currentVal - 510) * 10);           // printing the analog value
  delay(1000);                          // waits till the delay for the next reading
}
