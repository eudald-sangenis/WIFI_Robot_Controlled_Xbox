// This program is a test designed to obtain the current draw of 2 servomotors

#include <Servo.h>
Servo servo1;
Servo servo2;

// SERVO1
int servo1Control = 8;
int servo1Pin = 9;
int analogPin0= A0;
float mean1;
float voltageVal1=0;
float currentVal1=0;
float c1;
float servo1Position;

// SERVO 2
int servo2Control = 10;
int servo2Pin = 11;
int analogPin1= A1;
float mean2;
float voltageVal2=0;
float currentVal2=0;
float c2;
float servo2Position;

// OTHER VARIABLES
int timer=0;
float sum;

int t=0;

void setup() {

   Serial.begin(115200);
   pinMode(servo1Control, OUTPUT);
   pinMode(servo2Control, OUTPUT);
   pinMode(servo1Pin, OUTPUT);
   pinMode(servo2Pin, OUTPUT);
}

void loop() {
  // ON
  servo1.attach(servo1Pin);
  servo2.attach(servo2Pin);
  digitalWrite(servo1Control, HIGH);
  digitalWrite(servo2Control, HIGH);

  servo2Position=80;
  
  for (int servo1Position = 20; servo1Position < 160; servo1Position += 2) {
      t++;
      servo1.write(servo1Position);
      delay(200);
      voltageVal1 = analogRead(analogPin0);      
      currentVal1=((5.0*voltageVal1)/1023.0)*(4.0/10.0)*1000.0; 
      c1+=currentVal1; 
      mean1=c1/(t*2); 

      servo2Position+=1;
      
      servo2.write(servo2Position); 
      delay(200);
      voltageVal2 = analogRead(analogPin1);
      currentVal1=((5.0*voltageVal1)/1023.0)*(4.0/10.0)*1000.0;
      c2+=currentVal2;
      mean2=c2/t;
      
      sum=mean1+mean2;
      
      Serial.print("servo1_position:" + String(servo1Position, DEC));
      Serial.print(",");  
      Serial.print("servo2_position:" + String(servo2Position, DEC));
      Serial.print(",");  
      Serial.print("Current1_value:" + String(currentVal1, DEC));
      Serial.print(",");   
      // Serial.print("mean1:" + String(mean1, DEC));
      // Serial.print(","); 
      Serial.print("Current2_value:" + String(currentVal2, DEC));
      Serial.print(",");  
      // Serial.print("mean2:" + String(mean2, DEC));
      // Serial.print(",");  
      Serial.println("Mean_sum:" + String(sum, DEC));
  }
  c1=0; c2=0; t=0;
  delay(100);
  
  // OFF
  digitalWrite(servo1Control, LOW);
  digitalWrite(servo2Control, LOW);
  servo1.detach();
  servo2.detach();
      
    while(timer<50){
      timer++;
      delay(100);
      voltageVal1 = analogRead(analogPin0);
      voltageVal2 = analogRead(analogPin1);
      currentVal1=((5.0*voltageVal1)/1023.0)*(4.0/10.0)*1000.0; 
      currentVal2=((5.0*voltageVal2)/1023.0)*(4.0/10.0)*1000.0; 
      
      c1+=currentVal1; c2+=currentVal2;
      mean1=0; mean2=0;
      sum=mean1+mean2;
      
      Serial.print("servo1_position:" + String(160, DEC));
      Serial.print(",");  
      Serial.print("servo2_position:" + String(150, DEC));
      Serial.print(",");  
      Serial.print("Current1_value:" + String(currentVal1, DEC));
      Serial.print(",");   
      // Serial.print("mean1:" + String(mean1, DEC));
      // Serial.print(","); 
      Serial.print("Current2_value:" + String(currentVal2, DEC));
      Serial.print(",");  
      // Serial.print("mean2:" + String(mean2, DEC));
      // Serial.print(",");  
      Serial.println("Mean_sum:" + String(sum, DEC));
    }
    c1=0; c2=0;
    timer=0;
    
  // ON
  servo1.attach(servo1Pin);
  servo2.attach(servo2Pin);
  digitalWrite(servo1Control, HIGH);
  digitalWrite(servo2Control, HIGH);
  
  servo2Position=150;
  
  for (int servo1Position = 161; servo1Position > 20; servo1Position -= 2) {
      t++;
      servo1.write(servo1Position);
      delay(200);
      voltageVal1 = analogRead(analogPin0);      
      currentVal1=((5.0*voltageVal1)/1023.0)*(4.0/10.0)*1000.0; 
      c1+=currentVal1; 
      mean1=c1/(t*2); 

      servo2Position-=1;
      
      servo2.write(servo2Position); 
      delay(200);
      voltageVal2 = analogRead(analogPin1);
      currentVal1=((5.0*voltageVal1)/1023.0)*(4.0/10.0)*1000.0;
      c2+=currentVal2;
      mean2=c2/t;
      
      sum=mean1+mean2;
      
      Serial.print("servo1_position:" + String(servo1Position, DEC));
      Serial.print(",");  
      Serial.print("servo2_position:" + String(servo2Position, DEC));
      Serial.print(",");  
      Serial.print("Current1_value:" + String(currentVal1, DEC));
      Serial.print(",");   
      // Serial.print("mean1:" + String(mean1, DEC));
      // Serial.print(","); 
      Serial.print("Current2_value:" + String(currentVal2, DEC));
      Serial.print(",");  
      // Serial.print("mean2:" + String(mean2, DEC));
      // Serial.print(",");  
      Serial.println("Mean_sum:" + String(sum, DEC));
  }
    c1=0; c2=0;
    t=0;
    delay(100); 

// OFF
  digitalWrite(servo1Control, LOW);
  digitalWrite(servo2Control, LOW);
  servo1.detach();
  servo2.detach();
      
    while(timer<50){
      timer++;
      delay(100);
      voltageVal1 = analogRead(analogPin0);
      voltageVal2 = analogRead(analogPin1);
      currentVal1=((5.0*voltageVal1)/1023.0)*(4.0/10.0)*1000.0; 
      currentVal2=((5.0*voltageVal2)/1023.0)*(4.0/10.0)*1000.0; 
      
      c1+=currentVal1; c2+=currentVal2;
      mean1=0; mean2=0;
      sum=mean1+mean2;
      
      Serial.print("servo1_position:" + String(20, DEC));
      Serial.print(",");  
      Serial.print("servo2_position:" + String(80, DEC));
      Serial.print(",");  
      Serial.print("Current1_value:" + String(currentVal1, DEC));
      Serial.print(",");   
      // Serial.print("mean1:" + String(mean1, DEC));
      // Serial.print(","); 
      Serial.print("Current2_value:" + String(currentVal2, DEC));
      Serial.print(",");  
      // Serial.print("mean2:" + String(mean2, DEC));
      // Serial.print(",");  
      Serial.println("Mean_sum:" + String(sum, DEC));
    }
    c1=0; c2=0;
    timer=0;
}


// Code written by Guillem Cornella & Eudald Sangenís
