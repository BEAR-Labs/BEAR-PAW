 /*Pediatric Prosthetic Hand Control 
 * Right Hand Control
 * Author: Marcus A. Battraw
 * Date: 09-02-2020
 * Arduino Pro Mini (8MHz / 3.3V)
 * Pin Layout Schematic
 * |----FTDI-Header----|
 * |GND GND VCC RX1 TX0|
 * |TX0             RAW|
 * |RX1 Arduino Pro GND|
 * |RST     Mini    RST|
 * |GND             VCC|
 * |D2              A3 |
 * |D3              A2 |
 * |D4              A1 |
 * |D5              A0 |
 * |D6              D13|
 * |D7              D12|
 * |D8    Reset     D11|
 * |D9    Button    D10|
 * |-------------------|
 */
 /* The software of the BEAR PAW is released under the GNU General Public License v3. */
  
#include <Servo.h>
#include <SoftwareSerial.h>

//Define servo object to control each of the servos
Servo servo_6;
Servo servo_5;
Servo servo_4;
Servo servo_3;
Servo servo_2;
Servo servo_1;

//LED for testing
int LED = 13; //LED on pin 13

//PWM Pin Assigenment
int PWM_1 = 9;  //Thumb: S6
int PWM_2 = 10; //Thumb Opposition: S5
int PWM_3 = 11; //Index: S4
int PWM_4 = 6;  //Middle: s3
int PWM_5 = 5;  //Ring: S2
int PWM_6 = 3;  //Little: S1

//On-Off Control
int D2 = 2; //Solid State Relay Control

//Individual Motion ID Numbers
int M_1 = 253; //Thumb
int M_2 = 252; //Thumb Opposition
int M_3 = 251; //Index
int M_4 = 250; //Middle
int M_5 = 249; //Ring
int M_6 = 248; //Little

//Grasp Motion ID Numbers
int G_1  = 247; //Grasp 1
int G_2  = 246; //Grasp 2
int G_3  = 245; //Grasp 3
int G_4  = 244; //Grasp 4
int G_5  = 243; //Grasp 5
int G_6  = 242; //Grasp 6
int G_7  = 241; //Grasp 7
int G_8  = 240; //Grasp 8
int G_9  = 239; //Grasp 9
int G_10 = 238; //Grasp 10
int D_1  = 237; //Demo  1
 
void setup() 
{
  pinMode(LED, OUTPUT);   //Set LED (pin 13) as an Output
  digitalWrite(LED, LOW); //Set LED to start off LOW

  pinMode(D2, OUTPUT);   //Set Solid State Relay (pin D2) as an Output
  digitalWrite(D2, LOW); //Set D2 to start off LOW
  
//Setup the servo PWM (SIG) wire attachement corresponding to the board pins
  servo_6.attach(PWM_1, 1000, 2000); //(pin, min, max) min,max of servo 1000, 2000 us, from data sheet
  servo_6.write(180);                //set each position to zero position upon turning on (this motor is fliped)
  servo_5.attach(PWM_2, 1000, 2000);
  servo_5.write(0); 
  servo_4.attach(PWM_3, 1000, 2000);
  servo_4.write(0);                  //This motor is fliped
  servo_3.attach(PWM_4, 1000, 2000);
  servo_3.write(180);                //This motor is fliped
  servo_2.attach(PWM_5, 1000, 2000);
  servo_2.write(180);                //This motor is fliped
  servo_1.attach(PWM_6, 1000, 2000);
  servo_1.write(180);                //This motor is fliped
  
  Serial.begin(9600);

}

void loop() 
{
if(Serial.available()> 0){            //Check if their is data available to read
  
  digitalWrite(D2, HIGH);             //Close the Solid State Relay to allow for motor movement

  unsigned char val = Serial.read();  //Read the data
  
  //Blue LED On
  if(val == 255){                     //Check first Char
        digitalWrite(LED, HIGH);      //LED on, for testing and debuging the circuit
  }

  //Blue LED Off
  if(val == 254){ 
        digitalWrite(LED, LOW);        //LED off
  }

//Servo Knob Control
//Servo 6: Thumb
  if(val == M_1){
    delay(15);
    unsigned char val = Serial.read();
      if(val<= 180){
       int m = map(val, 0, 180, 180, 0);
       servo_6.write(m);
    }
  }

//Servo 2: Thumb Opposition
 if(val == M_2){
   delay(15);
   unsigned char val = Serial.read();
     if(val<= 180){
      servo_5.write(val);
    }
  }

//Servo 3: Index
  if(val == M_3){
    delay(15);
    unsigned char val = Serial.read();
      if(val<= 180){
       servo_4.write(val);
    }
  }

//Servo 4: Middle
  if(val == M_4){
    delay(15);
    unsigned char val = Serial.read();
      if(val<= 180){
       int m = map(val, 0, 180, 180, 0);
       servo_3.write(m);
    }
  }

//Servo 5: Ring
  if(val == M_5){
    delay(15);
    unsigned char val = Serial.read();
      if(val<= 180){
       int m = map(val, 0, 180, 180, 0);
       servo_2.write(m);
    }
  }

//Servo 6: Little
  if(val == M_6){
    delay(15);
    unsigned char val = Serial.read();
      if(val<= 180){
       int m = map(val, 0, 180, 180, 0);
       servo_1.write(m);
    }
  }    

//Grasp Control

//Grasp 1: Resting Position // Platfrom 
if(val == G_1){
  //Define the value for each servo to preform the specified grasp
  int val_1 = 180; //Thumb
  int val_2 = 0;   //Thumb Opposition
  int val_3 = 0;   //Index
  int val_4 = 180; //Middle
  int val_5 = 180; //Ring
  int val_6 = 180; //Little
  //Write the values to each servo
  servo_6.write(val_1);
  servo_5.write(val_2);
  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  }    

//Grasp 2: Medium Wrap // Cylindrical Grip
if(val == G_2){ // This is the same thing, it's redundant
  int val_1 = 30;  //Thumb //int val_1 = 110;  //Thumb
  int val_2 = 180;  //Thumb Opposition
  int val_3 = 180; //Index
  int val_4 = 0;   //Middle
  int val_5 = 0;   //Ring
  int val_6 = 0;   //Little

  servo_5.write(val_2);
  delay(1000);
  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  delay(10);
  servo_6.write(val_1);

  }  

  //Grasp 3: Lateral Pinch
if(val == G_3){
  int val_1 = 0;  //Thumb
  int val_2 = 130; //Thumb Opposition
  int val_3 = 180; //Index
  int val_4 = 0;   //Middle
  int val_5 = 0;   //Ring
  int val_6 = 0;   //Little

  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  delay(1000);
  servo_5.write(val_2);
  delay(1000);
  servo_6.write(val_1);

  }  

//Grasp 4: Spherical Grip
if(val == G_4){ // This is the same thing, it's redundant
  int val_1 = 70;  //Thumb //int val_1 = 110;  //Thumb
  int val_2 = 180;  //Thumb Opposition
  int val_3 = 180-50; //Index
  int val_4 = 0+50;   //Middle
  int val_5 = 0+70;   //Ring
  int val_6 = 0+70;   //Little

  servo_5.write(val_2);
  delay(1000);
  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  delay(10);
  servo_6.write(val_1);

  }  
  
  //Grasp 5 : Tripod
if(val == G_5){
  int val_1 = 30; //Thumb
  int val_2 = 130; //Thumb Opposition
  int val_3 = 150;  //Index
  int val_4 = 0;  //Middle
  int val_5 = 0;   //Ring
  int val_6 = 0;   //Little
  
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  delay(1000);
  servo_6.write(val_1);
  servo_5.write(val_2);
  servo_4.write(val_3);
  }  

  //Grasp 6: Hook
if(val == G_6){
  int val_1 = 30;  //Thumb
  int val_2 = 180;  //Thumb Opposition
  int val_3 = 180; //Index
  int val_4 = 0;   //Middle
  int val_5 = 0;   //Ring
  int val_6 = 0;   //Little

 
  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  delay(1000);
  servo_5.write(val_2);
  delay(1000);
  servo_6.write(val_1);

  } 
    
  //Grasp 7: Extension Grip
if(val == G_7){
  int val_1 = 30;  //Thumb
  int val_2 = 180;  //Thumb Opposition
  int val_3 = 30; //Index   // 30 deg
  int val_4 = 130;   //Middle // 30 deg
  int val_5 = 150;   //Ring   // 30 deg
  int val_6 = 150;   //Little // 30 deg


  servo_5.write(val_2);
  delay(1000);
  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  delay(10);
  servo_6.write(val_1);

  } 

  //Grasp 8: Diagonal Volar Grip // Not the correct grip
if(val == G_8){
  int val_1 = 20;  //Thumb //int val_1 = 110;  //Thumb
  int val_2 = 180;  //Thumb Opposition
  int val_3 = 180; //Index
  int val_4 = 0;   //Middle
  int val_5 = 0;   //Ring
  int val_6 = 0;   //Little

  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  servo_5.write(val_2);
  delay(1000);
  servo_6.write(val_1);
  } 

  //Grasp 9: Pulp Pinch
if(val == G_9){
  //Define the value for each servo to preform the specified grasp
  int val_1 = 20; //Thumb
  int val_2 = 160;   //Thumb Opposition
  int val_3 = 180;   //Index
  int val_4 = 180; //Middle
  int val_5 = 180; //Ring
  int val_6 = 180; //Little
  //Write the values to each servo

 
  servo_5.write(val_2);
  delay(1000);
  servo_6.write(val_1);
  //delay(1000);
  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  } 

    
  //Grasp 10: Point
if(val == G_10){
  int val_1 = 60;   //Thumb
  int val_2 = 180; //Thumb Opposition
  int val_3 = 0;   //Index
  int val_4 = 0;   //Middle
  int val_5 = 0;   //Ring
  int val_6 = 0;   //Little

  servo_6.write(val_1);
  servo_5.write(val_2);
  servo_4.write(val_3);
  servo_3.write(val_4);
  servo_2.write(val_5);
  servo_1.write(val_6);
  }  


  //Demo
if(val == D_1){
    servo_1.write(90);
    delay(100);
    servo_2.write(90);
    delay(100);
    servo_1.write(180);
    servo_3.write(90);
    delay(100);
    servo_2.write(180);
    servo_4.write(90);
    delay(150);
    servo_3.write(180);
    servo_1.write(90);//added
    delay(50);
    servo_4.write(0);
    delay(50);        //added
    servo_2.write(90);//added
    delay(100);
    servo_1.write(180);
    servo_3.write(90);
    delay(100);
    servo_2.write(180);
    servo_4.write(90);
    delay(150);
    servo_3.write(180);
    servo_1.write(90);//added
    delay(50);
    servo_4.write(0);
    delay(50);        //added
    servo_2.write(90);//added
    delay(100);
    servo_1.write(180);
    servo_3.write(90);
    delay(100);
    servo_2.write(180);
    servo_4.write(90);
    delay(150);
    servo_3.write(180);
    servo_1.write(90);//added
    delay(50);
    servo_4.write(0);
    delay(50);        //added
    servo_2.write(90);//added
    delay(100);
    servo_1.write(180);
    servo_3.write(90);
    delay(100);
    servo_2.write(180);
    servo_4.write(90);
    delay(150);
    servo_3.write(180);
    delay(50);
    servo_4.write(0);
  }  

 
 }

}
