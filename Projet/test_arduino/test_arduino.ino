void setup() {
  pinMode(13, OUTPUT); // configure la broche 13 en sortie
}

void loop() {
  digitalWrite(13, HIGH); 
  delay(1000); 
  digitalWrite(13, LOW); 
  delay(1000); 
}