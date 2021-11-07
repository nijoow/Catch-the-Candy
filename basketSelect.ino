void setup() { 
  Serial.begin(9600); //프로세싱과 연결하기 위한 준비를 합니다.
}
void loop() {
  int value1 = analogRead(A0);
  int value2 = analogRead(A5);//들어온 수치값을 저장하고 
  Serial.println(String(value1) + "," + String(value2)); //시리얼을 통해 프로세싱에게 보내줍니다.
  delay(100);
}
