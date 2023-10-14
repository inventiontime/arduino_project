const int rxPin = A0;
const int lightPin = 3;
const int txPin = 2;
boolean prevR = LOW;
boolean r = LOW;
boolean delayA = false;
int val = 0;
int threshVal = 35;
int delayT = 2000;

void setup() {
  // put your setup code here, to run once:
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  pinMode(lightPin, OUTPUT);
  Serial.begin(9600);
  digitalWrite(txPin, HIGH);

}

void loop() {
  // put your main code here, to run repeatedly:
  val = analogRead(rxPin);
  if(val < threshVal){
    analogWrite(lightPin, 20);
    prevR = r;
    r = HIGH;
    Serial.println(LOW);
  }else{
    analogWrite(lightPin, 0);
    prevR = r;
    r = LOW;
    Serial.println(HIGH);
  }

  if(prevR == HIGH && r == LOW){
    analogWrite(lightPin, 20);
    if(delayA)
      delay(delayT);
  }
}
