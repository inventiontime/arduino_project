const int buttonPin = 2;
const int ledPin = 9;
int switchState = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  switchState = digitalRead(buttonPin);
  
  if(switchState == HIGH){
    digitalWrite(ledPin, HIGH);
    Serial.print("H");
  }else{
    digitalWrite(ledPin, LOW);
    Serial.print("L");
  }
}
