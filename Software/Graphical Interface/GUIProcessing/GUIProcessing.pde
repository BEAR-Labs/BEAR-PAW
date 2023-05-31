/*Pediatric Prosthetic Hand Control GUI 
 * Author: Marcus A. Battraw
 * Date: 09-02-2020
 *
 */

import controlP5.*; //import the control library
import processing.serial.*;

Serial port;

ControlP5 cp5;

boolean toggle = false;

Knob knob1;
Knob knob2;
Knob knob3;
Knob knob4;
Knob knob5;
Knob knob6;
//int knobOutlineColor = color(112, 128, 144);

//Knob parameters
float knobSensitivity = 0.01;
int knobNumberOfTicks = 20;
int knobTickMarkLength = 5;
float knobTickMarkWeight = 1;
int knobNumberColor = color(255, 255, 255);
int knobTickColor = color(65, 240, 200);
int knobColor = color(60, 60, 60);

int toggleBackgroundColor =  color(90, 90, 90);
int toggleActiveColor = knobTickColor;

//Define font
PFont font1;
PFont font2;
PFont font3;
PFont font4;
PFont font5;

  
void setup(){
  
  size(1100, 530); // window size
 //Comunication Port Setup 
       //Uncomment to control via bluetooth
       printArray(Serial.list()); // prints all available serial ports
       port = new Serial(this, "COM5", 9600); //Select the USB port the SAMD is connected to

  cp5 = new ControlP5(this);
  
  //Select fonts
  font1 = createFont("consolas", 32);
  font2 = createFont("impact", 20);
  font3 = createFont("consolas", 16);
  font4 = createFont("consolas", 12);
  font5 = createFont("consolas", 40);
  
  cp5.addButton("blue") // blue is the name of the button
  .setLabel("On")
  .setPosition(50, 480) // x, y cordinates
  .setSize(50, 30) // width, height
  .setColorBackground(knobColor)
  .setColorForeground(knobTickColor)
  .setFont(font2)
  ;
  
  cp5.addButton("off") 
  .setLabel("Off")
  .setPosition(200, 480)
  .setSize(50, 30) 
  .setColorBackground(knobColor)
  .setColorForeground(knobTickColor)
  .setFont(font2)
  ;
  
  cp5.addToggle("Grasp1")
     .setLabel("Platform") //.setLabel(" Grasp 1")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(300,280)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
  
  cp5.addToggle("Grasp2")
     .setLabel("Cylindrical Grip") //.setLabel(" Grasp 2")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(450,280)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp3")
     .setLabel("Lateral Pinch") //.setLabel(" Grasp 3")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(600, 280)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp4")
     .setLabel("Spherical Grip") //.setLabel(" Grasp 4")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(750, 280)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp5")
     .setLabel("Tripod Pinch") //.setLabel(" Grasp 5")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(900,280)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp6")
     .setLabel("Hook") //.setLabel(" Grasp 6")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(300, 380) //.setPosition(300,380)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp7")
     .setLabel("Extension Grip") //.setLabel(" Grasp 7")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(450, 380)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp8")
     .setLabel("Diagonal Volar Grip") // .setLabel(" Grasp 8")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(600, 380)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp9")
     .setLabel("Pulp Pinch") //.setLabel(" Grasp 9")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(750, 380)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Grasp10")
     .setLabel("Index Point") //.setLabel(" Grasp 10")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(900, 380)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;
     
  cp5.addToggle("Demo")
     .setLabel("Demo")
     .setColorBackground(toggleBackgroundColor)
     .setColorActive(toggleActiveColor)
     .setPosition(450, 480)
     .setSize(60,25)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(font4)
     ;   
     
  knob1 = cp5.addKnob("Knob1")
               .setLabel("Knob 1: Thumb")
               .setRange(0,200)
               .setValue(0)
               .setPosition(100,90)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setScrollSensitivity(knobSensitivity)
               .setNumberOfTickMarks(knobNumberOfTicks)
               .setTickMarkLength(knobTickMarkLength) 
               .setTickMarkWeight(knobTickMarkWeight) 
               .setColorValue(knobNumberColor)
               .setColorForeground(knobTickColor)
               .setColorBackground(knobColor)
               .setFont(font4)
               ;
               
  knob2 = cp5.addKnob("Knob2")
               .setLabel("Knob 2: Index")
               .setRange(0,200)
               .setValue(0)
               .setPosition(300,90)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setScrollSensitivity(knobSensitivity)
               .setNumberOfTickMarks(knobNumberOfTicks)
               .setTickMarkLength(knobTickMarkLength) 
               .setTickMarkWeight(knobTickMarkWeight) 
               .setColorValue(knobNumberColor)
               .setColorForeground(knobTickColor)
               .setColorBackground(knobColor)
               .setFont(font4)
               ;
                     
  knob3 = cp5.addKnob("Knob3")
               .setLabel("Knob 3: Middle")
               .setRange(0,200)
               .setValue(0)
               .setPosition(500,90)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setScrollSensitivity(knobSensitivity)
               .setNumberOfTickMarks(knobNumberOfTicks)
               .setTickMarkLength(knobTickMarkLength) 
               .setTickMarkWeight(knobTickMarkWeight) 
               .setColorValue(knobNumberColor)
               .setColorForeground(knobTickColor)
               .setColorBackground(knobColor)
               .setFont(font4)
               ;
                      
  knob4 = cp5.addKnob("Knob4")
               .setLabel("Knob 4: Ring")
               .setRange(0,200)
               .setValue(0)
               .setPosition(700,90)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setScrollSensitivity(knobSensitivity)
               .setNumberOfTickMarks(knobNumberOfTicks)
               .setTickMarkLength(knobTickMarkLength) 
               .setTickMarkWeight(knobTickMarkWeight) 
               .setColorValue(knobNumberColor)
               .setColorForeground(knobTickColor)
               .setColorBackground(knobColor)
               .setFont(font4)
               ;
               
  knob5 = cp5.addKnob("Knob5")
               .setLabel("Knob 5: Little")
               .setRange(0,200)
               .setValue(0)
               .setPosition(900,90)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setScrollSensitivity(knobSensitivity)
               .setNumberOfTickMarks(knobNumberOfTicks)
               .setTickMarkLength(knobTickMarkLength) 
               .setTickMarkWeight(knobTickMarkWeight) 
               .setColorValue(knobNumberColor)
               .setColorForeground(knobTickColor)
               .setColorBackground(knobColor)
               .setFont(font4)
               ;
               
  knob6 = cp5.addKnob("Knob6")
               .setLabel("Knob 6: Thumb Opposition")
               .setRange(0,200)
               .setValue(0)
               .setPosition(100,290)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setScrollSensitivity(knobSensitivity)
               .setNumberOfTickMarks(knobNumberOfTicks)
               .setTickMarkLength(knobTickMarkLength) 
               .setTickMarkWeight(knobTickMarkWeight) 
               .setColorValue(knobNumberColor)
               .setColorForeground(knobTickColor)
               .setColorBackground(knobColor)
               .setFont(font4)
               ;
}

void draw(){
 background(0, 0, 0); //window color r, g, b
 fill(255, 255, 255); //text color
 textFont(font1);
 text("BEAR PAW", 480, 40); // text, x, y coordinates
 
 fill(65, 240, 200); //text color
 textFont(font3);
 text("Graphical user interface to control the pediatric prosthetic hand.", 270, 60); // text, x, y coordinates
 
 fill(65, 240, 200); //text color
 textFont(font5);
 text("BEAR", 718, 500); // text, x, y coordinates

 
 fill(65, 240, 200);
 textFont(font3);
 text("Bionic Engineering and Assistive Robotics", 720, 520); // text, x, y coordinates

}

//Predefined Grasp Section
void Grasp1(int theValue){ //Resting Position // Platform 
  if(theValue == 0){
    char val = char(247);
    port.write(val);
  }
}

void Grasp2(int theValue){ // Meduim Wrap
  if(theValue == 0){
    char val = char(246);
    port.write(val);
  }
}

void Grasp3(int theValue){ // Lateral
  if(theValue == 0){
    char val = char(245);
    port.write(val);
  }
}

void Grasp4(int theValue){ //Spherical Grip //Lateral Tripod
  if(theValue == 0){
    char val = char(244); //char val = char(244); if you want a unique grasp but for the test the sphere is the same as wrap
    port.write(val);
  }
}

void Grasp5(int theValue){ //Tripod
  if(theValue == 0){
    char val = char(243);
    port.write(val);
  }
}

void Grasp6(int theValue){ //Hook 
  if(theValue == 0){
    char val = char(242);
    port.write(val);
  }
}

void Grasp7(int theValue){ //Extension Grip
  if(theValue == 0){
    char val = char(241);
    port.write(val);
  }
}

void Grasp8(int theValue){ //Diagonal Volar Grip
  if(theValue == 0){
    char val = char(240);
    port.write(val);
  }
}

void Grasp9(int theValue){ //Pulp Pinch 
  if(theValue == 0){
    char val = char(239);
    port.write(val);
  }
}

void Grasp10(int theValue){ //Index Point
  if(theValue == 0){
    char val = char(238);
    port.write(val);
  }
}

void Demo(int theValue){ //Index Point
  if(theValue == 0){
    char val = char(237);
    port.write(val);
  }
}

//Light On Off Section - This was for trouble shooting
void blue(){
 char val_1 = char(255); //255
// char val_2 = char(254);
 port.write(val_1);
// port.write(val_2);
}

void off(){
  char val_1 = char(254); //254
//  char val_2 = char(255);
 port.write(val_1);
// port.write(val_2);
// print(val_1);
// print(val_2);
}

//Knob Control Seciton
void Knob1(int theValue){ //Thumb
  println("Knob 1 event " + theValue);
  char id = char(253);                     //Knob id number that arduino will use for identification
  float m = map(theValue, 0, 200, 0, 180); //Map the knob values 0-200 to 0-180 that the servo reads
  int g = int(m);                          //Change float from mapping to an integer
  char val = char(g);                      //Now we convert the integer to a character to send it over the serial port
  port.write(id);     //write the knob id
  port.write(val);    //write the knob value
}

void Knob2(int theValue){ //Index
  println("Knob 2 event " + theValue);
  char id = char(251);
  float m = map(theValue, 0, 200, 0, 180);
  int g = int(m);
  char val = char(g);
  port.write(id);
  port.write(val);
}

void Knob3(int theValue){ //Middle
  println("Knob 3 event " + theValue);
  char id = char(250);
  float m = map(theValue, 0, 200, 0, 180);
  int g = int(m);
  char val = char(g);
  port.write(id);
  port.write(val);
}

void Knob4(int theValue){ //Ring
  println("Knob 4 event " + theValue);
  char id = char(249);
  float m = map(theValue, 0, 200, 0, 180);
  int g = int(m);
  char val = char(g);
  port.write(id);
  port.write(val);
}

void Knob5(int theValue){ //Little
  println("Knob 5 event " + theValue);
  char id = char(248);
  float m = map(theValue, 0, 200, 0, 180);
  int g = int(m);
  char val = char(g);
  port.write(id);
  port.write(val);
}

void Knob6(int theValue){ //Thumb Opposition
  println("Knob 6 event " + theValue);
  char id = char(252);
  float m = map(theValue, 0, 200, 0, 180);
  int g = int(m);
  char val = char(g);
  port.write(id);
  port.write(val);
}
