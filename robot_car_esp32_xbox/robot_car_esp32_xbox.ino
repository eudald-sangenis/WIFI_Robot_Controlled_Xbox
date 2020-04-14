// UDP WIFI TRANSMISSION BETWEEN ARDUINO AND VISUAL STUDIO
// WIFI ROBOT CONTROLLED USING A XBOX CONTROLLER
// EUDALD SANGENÍS & GUILLEM CORNELLA

// Include all the libraries
#include <WiFiUdp.h>      // for programming UDP routines
#include <ESP32Servo.h>   // to control the servo motors
#include <WiFi.h>         // to connect to the WIFI module
#include <MapFloat.h>     // to be able to do Maps using float variables

// Define the pins of the motor shield module
#define enA 14     // enable the motor A
#define enB 32     // enable the motor B

// Pins that act as a switch, to control the direction of the motor:
#define in1 27      
#define in2 26     
#define in3 25     
#define in4 33     

// Define the speed of the motors, starting at 0
int motorSpeedA = 0;
int motorSpeedB = 0;

// Defining the servo motors
Servo servo_cam;            // The name of the servo that we are using for the camera control
Servo servo_steer;          // The name of the servo that we are using for robot steering

// Define the initial position degree of the servos
int initial_pos_cam = 90;   // The initial position of the camera will centered at 90 degrees
int initial_pos_steer =115; // The initial position of the servo steer will be at 115 degrees to have the robot straight

// Define the router 
const char* ssid = "EBG3808 2.4";     // The name of your WIFI router
const char* password = "ventana2.4";  // The password of your router

// Define variables of the incoming packets from the C# application
WiFiUDP udp;                      // Create a udp object
unsigned int udpPort = 2000;      // The port to listen to incoming packets
char packetBuffer[50];            // Set up a buffer for incoming packets (abans era[50])           

// Other definitions
#define LED 2                     // Defining a LED connected to the GPIO 2
bool led;                         // Define the variable "led" as a bool

// Write the code to initialize the board, create the SETUP
void setup() {
  
  Serial.begin(115200);     // Sets the data rate in bits per second (baud) for serial data transmission.
  delay(500);               // Wait for 500ms
  
  pinMode(enA, OUTPUT);     // Define the pins of the motor shield as outputs
  pinMode(enB, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);
  pinMode(LED, OUTPUT);     // Define the LED that will act as the robot's lights
 
  servo_cam.attach(4);                   // Attach the servo to the pin GPIO 4, the same as D2 for the ESP8266 module
  servo_steer.attach(5);                 // Attach the servo to the pin GPIO 5, the same as D1 for the ESP8266 module
  servo_cam.write(initial_pos_cam);      // Set the initial position to 0º
  servo_steer.write(initial_pos_steer);  // Set the initial position to 45º
  
  digitalWrite(LED, LOW);  // Turn off the Led On Board

  // Wifi configuration and connection:
  WiFi.begin(ssid, password);           // Connect to your WiFi router
  Serial.println("");                   // Print a blank space
  Serial.print("Connecting");           // Print "Connecting" to the Serial Monitor
  while (WiFi.status() != WL_CONNECTED) // Make the Led Flash while connecting to the wifi router
  {
    Serial.print(".");                  // Print a dot "." while trying to connect
    digitalWrite(LED, LOW);             // Turn off the LED on board
    delay(250);                         // Wait for 250ms
    digitalWrite(LED, HIGH);            // Turn on the LED on board
    delay(250);                         // Wait for 250ms
  }  
  // If successfully connected to the wifi router, the IP Address and port are displayed in the serial monitor
  Serial.println("");
  Serial.print("Successfully connected to : ");
  Serial.println(ssid);
  Serial.print("NodeMCU IP address : ");
  Serial.println(WiFi.localIP());
  udp.begin(udpPort);               // Once connection is established, you can start listening to incoming packets.
  Serial.print("Local Port : ");      
  Serial.println(udpPort);          // Print the number of the port that's going to be used
}

// Write the loop code to run the program
void loop() 
{
  receive_packet();
}

// Waiting to receive incoming UDP packets
void receive_packet() 
{
  int packetSize = udp.parsePacket();
  if (packetSize) {
    IPAddress remoteIp = udp.remoteIP();
    int len = udp.read(packetBuffer, 255); 
    if (len > 0) packetBuffer[len] = 0;

    String udp_packet_sent = packetBuffer;        // String that contains all the data sent by C#.         
         
    Serial.print("UDP packet sent by PC:"); 
    Serial.println(udp_packet_sent);       // Print in the serial monitor the long string containing all the information
        
// SERVO CAMERA MOVEMENT
    String val_tilt_camera = udp_packet_sent.substring(0,6);// Creating a substring from the packet sent to obtain information regarding the tilt value "jx0---"
    val_tilt_camera = val_tilt_camera.substring(3,6);       // Creating a substring again to obtain the numeric variables and removing the letters "jx0"
    float val_tilt_camera_f = val_tilt_camera.toFloat();    // Converting the String into a float variable 
    val_tilt_camera_f = val_tilt_camera_f - 0.5;            // Substracting 0.5 to the value so we can have 0 in the the center, -0.5 the minimum, and 0.5 the maximum
    Serial.println("val_tilt_camera_f:");                  
    Serial.println(val_tilt_camera_f);
    float servo_cam_angle = mapFloat(val_tilt_camera_f, -0.5, 0.5, 170.0, 10.0); // Maping the value obtained, -0.5 in the joystick equals 170º and 0.5 equals 10º
    Serial.println(servo_cam_angle);
    int servo_cam_angle_int = (int)servo_cam_angle;         // Converting the value in degrees into an <int> variable
    servo_cam.write(servo_cam_angle_int);                   // Move the servo according to the degrees maped
    Serial.println(servo_cam_angle_int);

// STEER OF THE ROBOT
    String val_steer = udp_packet_sent.substring(6,12);     // Creating a substring from the packet sent to obtain information regarding the steer value "jx1---"
    val_steer = val_steer.substring(3,6);                   // String sent by the PC to control the robot and go right and left
    float val_steer_f = val_steer.toFloat();                // Converting the String into a float variable
    val_steer_f = val_steer_f - 0.5;                        // Substracting 0.5 to the value so we can have 0 in the the center, -0.5 the minimum, and 0.5 the maximum
    Serial.println("val_steer_f:");
    Serial.println(val_steer_f);
    float servo_steer_angle = mapFloat(val_steer_f, -0.5, 0.5, 85.0, 145.0); // Maping the value obtained, -0.5 in the joystick equals 85º-left and 0.5 equals 145º-right.
    Serial.println(servo_steer_angle);
    int servo_steer_angle_int = (int)servo_steer_angle;     // Converting the value in degrees into an <int> variable
    servo_steer.write(servo_steer_angle_int);               // Move the servo according to the degrees maped
    Serial.println(servo_steer_angle_int);
  
// ROBOT FORWARD AND BACKWARDS
    String val_vel = udp_packet_sent.substring(12,18);      // Creating a substring from the packet sent to obtain information regarding the steer value "jy1---"
    val_vel = val_vel.substring(3,6);                       // String sent by the PC to control the robot and go forward and backwards
    float val_vel_f = val_vel.toFloat();                    // Converting the String into a float variable
    val_vel_f = val_vel_f - 0.5;                            // Substracting 0.5 to the value so we can have 0 in the the center, -0.5 the minimum, and 0.5 the maximum
    Serial.println("val_vel_f:");
    Serial.println(val_vel_f); 

//LEDS ON - LEDS OFF
    String light = udp_packet_sent.substring(18,22);        // Creating a substring from the packet sent to obtain information regarding the LED value "LED-"
    if (light=="LED1"){                                     // When the substring analyzed is "LED1" then light on the LED
      led = true;
      digitalWrite(LED,HIGH);
    } 
    else if (light=="LED2"){                                // When the substring analyzed is "LED2" then light off the LED
      led = false;                                          
      digitalWrite(LED, LOW);
    }
    else if (light=="LED0"){                                // When the substring analyzed is "LED0", if the LED was on, turn it off, and vice versa.
      digitalWrite(LED,LOW);
      if (led==true) digitalWrite(LED,HIGH);
      else digitalWrite(LED,LOW);
    }
    
// Y-axis used for forward and backward control
    // to go BACKWARDS
    if (val_vel_f < -0.1) {       
      // Set Motor A backward
      digitalWrite(in1, HIGH);
      digitalWrite(in2, LOW);
      // Set Motor B backward
      digitalWrite(in3, HIGH);
      digitalWrite(in4, LOW);
      // Convert the declining Y-axis readings for going backwards, -0.1 equals 400 and -0.5 equals 1000. The PWM signal is increasing the motor speed.
      float motorSpeedA_f = mapFloat(val_vel_f, -0.1, -0.5, 400.0, 1000.0);
      float motorSpeedB_f = mapFloat(val_vel_f, -0.1, -0.5, 400.0, 1000.0);
      motorSpeedA = (int)motorSpeedA_f;   // convert the float variable of the speed of the motor A to an int
      motorSpeedB = (int)motorSpeedB_f;   // convert the float variable of the speed of the motor B to an int    
    }
    // to go FORWARD
    else if (val_vel_f > 0.1) {
      // Set Motor A forward
      digitalWrite(in1, LOW);
      digitalWrite(in2, HIGH);
      // Set Motor B forward
      digitalWrite(in3, LOW);
      digitalWrite(in4, HIGH);
      // Convert the growing Y-axis readings for going forward, 0.1 equals 400 and 0.5 equals 1000. The PWM signal is increasing the motor speed.
      float motorSpeedA_f = mapFloat(val_vel_f, 0.1, 0.5, 400.0, 1000.0);
      float motorSpeedB_f = mapFloat(val_vel_f, 0.1, 0.5, 400.0, 1000.0);
      motorSpeedA = (int)motorSpeedA_f;    // convert the float variable of the speed of the motor A to an int
      motorSpeedB = (int)motorSpeedB_f;    // convert the float variable of the speed of the motor B to an int    
    }
    // If joystick stays in middle the motors are not moving (to avoid warming the motors)
    else {
      motorSpeedA = 0;
      motorSpeedB = 0;
    }
  }
  analogWrite(enA, motorSpeedA); // Send PWM signal to motor A
  analogWrite(enB, motorSpeedB); // Send PWM signal to motor B
}

// ARDUINO CODE by:
// gcornella15@gmail.com
// eudald.sangenis@gmail.com
