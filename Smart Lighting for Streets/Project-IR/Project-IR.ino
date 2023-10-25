boolean r = false;
int ir = 0;
int pin = A0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(2, OUTPUT);
  pinMode(pin, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  ir = analogRead(pin);
  if(ir < 120){
    r = false;
    digitalWrite(2, LOW);
  }else{
    r = true;
    digitalWrite(2, HIGH);
  }
  Serial.println(r);
}
