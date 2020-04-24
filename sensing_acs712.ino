// This is a program designed to analyze the current that the DC motors drew using the ACS712 current sensor
// The variables will be declared firstly and then the void loop will obtain analog 
// values from the analogic A0 input and will convert them into current in mA.
 
const int currentPin = A0;
int sensitivity = 100; //it is a 20A type sensor
int adcValue= 0;
int offsetVoltage = 2500;
double adcVoltage = 0;
double currentValue = 0;
 
void setup() 
{
  Serial.begin(4800);
  delay(2000);
}
 
void loop()
{
  adcValue = analogRead(currentPin);
  adcVoltage = (adcValue / 1024.0) * 5000;
  currentValue = ((adcVoltage - offsetVoltage) / (sensitivity/1000));
  Serial.println(currentValue);
}


// Code written by Guillem Cornella & Eudald Sangenís
