int ledPins[8] = {3, 5, 6, 9, 10, 11, 2, 2};
int sensorPins[6] = {A0, A1, A2, A3, A4, A5};
int sensedObject[6];
int ir;

void setup() {
  pinMode(13, OUTPUT);
  for(int i = 0; i < 6; i++){
    pinMode(ledPins[i], OUTPUT);
    pinMode(sensorPins[i], INPUT);
  }
  digitalWrite(13, HIGH);
}

void loop() {
  for(int i = 0; i < 6; i++){
    ir = analogRead(sensorPins[i]);
    if(ir < 10){
      sensedObject[i] = HIGH;
    }else{
      sensedObject[i] = LOW;
    }
  }

  for(int i = 0; i < 6; i++){
    analogWrite(ledPins[i], 0);
  }
  
  for(int i = 0; i < 6; i++){
    if(sensedObject[i] == HIGH){
      digitalWrite(ledPins[i], HIGH);
      digitalWrite(ledPins[i + 1], HIGH);
      digitalWrite(ledPins[i + 2], HIGH);
    }else{
      
    }
  }
}
