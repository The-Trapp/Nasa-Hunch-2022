import controlP5.*;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;   
import controlP5.*; //import ControlP5 library
import processing.serial.*;

Serial port;
//int delay=10;
int x;
ControlP5 cp5; //create ControlP5 object
PFont font;
int time; 
int date;
String portdata;
String portdatawritelight;
String portdatawritemotor;
Button tempbutton;
Button o2button;
Button co2button;
Button humiditybutton;
Button motorbutton;
Button camerabutton;
Button lightbutton;
Button backbutton;
Button temphighlimitbutton;
Button tempsettings;
Button temponoff;
Button reglight;
Button coollight;
Textfield temphighlimitinput;
Textfield templowlimitinput;
Textfield tempdays;
Textfield temphours;
Textfield tempminutes;
Textfield tempseconds;
Button motorsettings;
Button camerasettings;
Button lightsettings;
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd, HH:mm:ss");  
LocalDateTime now = LocalDateTime.now();  

Textarea tempdata;   //Temparature variables
Textarea tempError;
String tempString;
int temp =25;
boolean tempon=false;
int tempslot;
String temphighlimitstring = "";
String templowlimitstring = "";
int temphighlimit;
int templowlimit;
int tempdatainterval =2;
Chart tempchart;
String tempinfo;
boolean tempscreenon = false;


 
Textarea humiditydata;   //Humidity variables
Textarea humidityError;
String  humidity;
boolean humidityon;
int humidityslot;
int humiditydatainterval =2;
Chart humiditychart;
String humidityinfo;
boolean humidityscreenon = false;


Textarea co2data;   //CO2 variables
Textarea co2Error;
String  co2;
boolean co2on;
int co2slot;
Chart co2chart;
String co2info;
boolean co2screenon = false;

Textarea o2data;   //O2 variables
Textarea o2Error;
String  o2;
boolean o2on;
int o2slot;
Chart o2chart;
String o2info;
boolean o2screenon = false;

Textarea cameradata;   //Camera variables
boolean camerascreenon = false;
String camerainfo;


Textarea motordata;   //Motor variables
Textfield motorstart;
Textfield motorstop;
Textfield motorspeed;
boolean motorscreenon = false;
String motorinfo;

Textarea lightdata;  //Light variables
Textfield lightstart;
Textfield lightstop;
Textfield lightbright;
Textfield lightrgb;
boolean lightscreenon = false;
String lightinfo;

void setup(){ //same as arduino program

  size(800, 800);    //window size, (width, height)

  printArray(Serial.list());   //prints all available serial ports
  
  port = new Serial(this, "COM5", 9600); 

  //lets add buton to empty window
  
  cp5 = new ControlP5(this);
  font = createFont("Franklin Gothic Demi Cond", 20);    // custom fonts for buttons and title
  
  tempbutton=cp5.addButton("Temp")   
    .setPosition(50, 50)
    .setSize(100, 100)     
    .setFont(font)
    .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setColorLabel(color(0,0,0))
  
  ;   
  o2button=cp5.addButton("O2")    
    .setPosition(150, 150) 
    .setSize(100, 100)
    .setFont(font)
    .setColorBackground(color(217, 217, 217))
    .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setColorLabel(color(0,0,0))
    
  ;
  co2button=cp5.addButton("CO2")   
    .setPosition(250, 250) 
    .setSize(100, 100)   
    .setFont(font)
    .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setColorLabel(color(0,0,0))
  ;
  humiditybutton=cp5.addButton("Humidity")
    .setPosition(350, 350)
    .setSize(100, 100)   
    .setFont(font)
    .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setColorLabel(color(0,0,0))
  ;
  motorbutton=cp5.addButton("Motor")   
    .setPosition(450, 450)
    .setSize(100, 100)  
    .setFont(font)
    .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setColorLabel(color(0,0,0))
    ;
  camerabutton=cp5.addButton("Camera")  
    .setPosition(550, 550)
    .setSize(100, 100)   
    .setFont(font)
    .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setColorLabel(color(0,0,0))
    ;
    lightbutton=cp5.addButton("Light")   
    .setPosition(650, 650 )
    .setSize(100, 100)   
    .setFont(font)
    .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setColorLabel(color(0,0,0))
   ;
   backbutton=cp5.addButton("Back")   
    .setPosition(650, 700)
    .setSize(100, 50)     
    .setFont(font)
        .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
        .setColorLabel(color(0,0,0))
    .hide()
    ;
   tempsettings=cp5.addButton("TempSettings")   
    .setPosition(650, 600)
    .setSize(100, 50)     
    .setLabel("ADVANCED")
    .setColorLabel(color(0,0,0))
    .setFont(font)
        .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .hide()
    ;
    temponoff=cp5.addButton("ON")
    .setPosition(650, 500)
    .setValue(0)
    .setSize(100, 50) 
    .setColorLabel(color(0,0,0))
    .setFont(font)
    .hide()
    ;
    reglight=cp5.addButton("RegLight")
    .setPosition(70, 550)
    .setValue(0)
    .setSize(100, 50) 
    .setLabel("Light")
    .setColorLabel(color(0,0,0))
            .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setFont(font)
    .hide()
    ;
    coollight=cp5.addButton("PartyMode")
    .setPosition(70, 650)
    .setValue(0)
    .setSize(100, 50) 
    .setColorLabel(color(0,0,0))
            .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .setFont(font)
    .hide()
    ;
     tempdays=cp5.addTextfield("    Days")
     .setPosition(200,400)
     .setSize(70,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     .hide();
     ;
     temphours=cp5.addTextfield("   Hours")
     .setPosition(300,400)
     .setSize(70,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     .hide();
     ;
     tempminutes=cp5.addTextfield("   Mins")
     .setPosition(400,400)
     .setSize(70,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     .hide();
     ;
     tempseconds=cp5.addTextfield("  Secs")
     .setPosition(500,400)
     .setSize(70,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     .hide()
     ;
     motorsettings=cp5.addButton("MotorSettings")   
    .setPosition(650, 600)
    .setSize(100, 50)     
    .setLabel("ADVANCED")
    .setColorLabel(color(0,0,0))
    .setFont(font)
        .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .hide()
    ;
    camerasettings=cp5.addButton("CameraSettings")   
    .setPosition(650, 600)
    .setSize(100, 50)     
    .setLabel("ADVANCED")
    .setColorLabel(color(0,0,0))
    .setFont(font)
        .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .hide()
    ;
    lightsettings=cp5.addButton("LightSettings")   
    .setPosition(650, 600)
    .setSize(100, 50)     
    .setLabel("ADVANCED")
    .setColorLabel(color(0,0,0))
    .setFont(font)
        .setColorBackground(color(217, 217, 217))
        .setColorActive(color(255,153,0))
    .setColorForeground(color(255,153,0))
    .hide()
    ;

}

void draw(){  //same as loop in arduino

  background(239, 239 , 239); // background color of window (r, g, b) or (0 to 255)
  
  //lets give title to our window
  fill(0, 0, 0);               //text color (r, g, b)
  textFont(font);
  text("AGRICULTURE LAB", 325, 40);  // ("text", x coordinate, y coordinat)





if ( port.available() > 0) 
  portdata = port.readStringUntil('\n'); 
  // read it and store it in val
println(portdata);
}



//lets add some functions to our buttons
//so when you press any button, it sends perticular char over serial port

void Temp(){
  port.write('t');
  if(tempon==true)
  {
temponoff.setLabel("On");
temponoff.setColorBackground(color(0,255,0));
temponoff.setColorForeground(color(0,255,0));
temponoff.setColorActive(color(0,255,0));
  }
  else
  {
  temponoff.setLabel("Off");
temponoff.setColorBackground(color(255,0,0));
temponoff.setColorForeground(color(255,0,0));
temponoff.setColorActive(color(255,0,0));
  }
tempbutton.hide();
o2button.hide();
co2button.hide();
humiditybutton.hide();
motorbutton.hide();
camerabutton.hide();
lightbutton.hide();
backbutton.show();
tempsettings.show();
temponoff.show();
tempscreenon = true;

     tempdata = cp5.addTextarea("DATA")             
                  .setPosition(70,100)
                  .setSize(300,400)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(128))
    .setColorBackground(color(217, 217, 217))
                  .showScrollbar()
                  .setScrollActive(5)
                  ;
 //if(delay<=0)
//else
//delay--;
   tempinfo =  dtf.format(now) +", Slot: " + tempslot +", "+ portdata  + "\n" ;

  tempdata.setText(tempinfo);
     
  tempchart = cp5.addChart("dataflow")
               .setPosition(400, 100)
               .setSize(250, 250)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(239,239,239))
                   .setColorBackground(color(217, 217, 217));

  tempchart.addDataSet("Temp");
  tempchart.setData("Temp", new float[100]); 

    tempError= cp5.addTextarea("Error")
                  .setPosition(70,530)
                  .setSize(300,200)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(255,0,0))
    .setColorBackground(color(217, 217, 217))
                  ;
                  tempError.setText("High Temp\nLow Temp");


}
void O2(){
  port.write('o');
    if(tempon==true)
  {
temponoff.setLabel("On");
temponoff.setColorBackground(color(0,255,0));
temponoff.setColorForeground(color(0,255,0));
temponoff.setColorActive(color(0,255,0));
  }
  else
  {
  temponoff.setLabel("Off");
temponoff.setColorBackground(color(255,0,0));
temponoff.setColorForeground(color(255,0,0));
temponoff.setColorActive(color(255,0,0));
  }
tempbutton.hide();
o2button.hide();
co2button.hide();
humiditybutton.hide();
motorbutton.hide();
camerabutton.hide();
lightbutton.hide();
tempsettings.show();
backbutton.show();
temponoff.show();

o2screenon = true;


o2data = cp5.addTextarea("DATA")             
                  .setPosition(70,100)
                  .setSize(300,400)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(128))
    .setColorBackground(color(217, 217, 217))
                  .showScrollbar()
                  .setScrollActive(5)
                  ;
// if(delay<=0)
//o2=portdata.substring(18,19);
//else
//delay--;

 
  o2info =  dtf.format(now) +", Slot:" + o2slot +", "+ portdata + "\n" ;

  o2data.setText(o2info);
     
  o2chart = cp5.addChart("dataflow")
               .setPosition(400, 100)
               .setSize(250, 250)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
                   .setColorBackground(color(217, 217, 217))
               .setColorCaptionLabel(color(239,239,239))  ;

  o2chart.addDataSet("O2");
  o2chart.setData("O2", new float[100]); 
  
  o2Error= cp5.addTextarea("Error")
                  .setPosition(70,550)
                  .setSize(300,200)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(255,0,0))
    .setColorBackground(color(217, 217, 217))
                  ;
o2Error.setText("High O2\nLow O2");


}

void CO2(){
  port.write('c');
    if(tempon==true)
  {
temponoff.setLabel("On");
temponoff.setColorBackground(color(0,255,0));
temponoff.setColorForeground(color(0,255,0));
temponoff.setColorActive(color(0,255,0));
  }
  else
  {
  temponoff.setLabel("Off");
temponoff.setColorBackground(color(255,0,0));
temponoff.setColorForeground(color(255,0,0));
temponoff.setColorActive(color(255,0,0));
  }
tempbutton.hide();
o2button.hide();
co2button.hide();
humiditybutton.hide();
motorbutton.hide();
camerabutton.hide();
lightbutton.hide();
tempsettings.show();
backbutton.show();
temponoff.show();

co2screenon = true;


co2data = cp5.addTextarea("DATA")             
                  .setPosition(70,100)
                  .setSize(300,400)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(128))
    .setColorBackground(color(217, 217, 217))
                  .showScrollbar()
                  .setScrollActive(5)
                  ;
// if(delay<=0)
//co2=portdata.substring(4,6);
//else
//delay--;
 
  co2info =  dtf.format(now) +", Slot:" + co2slot +", " +portdata+ "\n" ;

  co2data.setText(co2info);
     
  co2chart = cp5.addChart("dataflow")
               .setPosition(400, 100)
               .setSize(250, 250)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(239,239,239))  
                   .setColorBackground(color(217, 217, 217));

  co2chart.addDataSet("CO2");
  co2chart.setData("CO2", new float[100]); 
  
    co2Error= cp5.addTextarea("Error")
                  .setPosition(70,550)
                  .setSize(300,200)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(255,0,0))
    .setColorBackground(color(217, 217, 217))
                  ;
co2Error.setText("High CO2\nLow CO2");
}

void Motor(){
  tempbutton.hide();
o2button.hide();
co2button.hide();
humiditybutton.hide();
motorbutton.hide();
camerabutton.hide();
lightbutton.hide();
motorsettings.show();
backbutton.show();

motorscreenon=true;
motordata = cp5.addTextarea("DATA")             
                  .setPosition(70,100)
                  .setSize(300,400)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(128))
    .setColorBackground(color(217, 217, 217))
                  .showScrollbar()
                  .setScrollActive(5)
;
  motorinfo =  dtf.format(now) +", Slot:" + co2slot +", " +"\nMotor On/Off at    "+ "\n" ;

  motordata.setText(motorinfo);
  
if(portdatawritemotor=="m")
{
  port.write('z');
  portdatawritemotor="z";
}
else
{
  port.write('m');
  portdatawritemotor="m";
}
}

void Humidity(){
  port.write('h');
    if(tempon==true)
  {
temponoff.setLabel("On");
temponoff.setColorBackground(color(0,255,0));
temponoff.setColorForeground(color(0,255,0));
temponoff.setColorActive(color(0,255,0));
  }
  else
  {
  temponoff.setLabel("Off");
temponoff.setColorBackground(color(255,0,0));
temponoff.setColorForeground(color(255,0,0));
temponoff.setColorActive(color(255,0,0));
  }
tempbutton.hide();
o2button.hide();
co2button.hide();
humiditybutton.hide();
motorbutton.hide();
camerabutton.hide();
lightbutton.hide();
tempsettings.show();
backbutton.show();
temponoff.show();
humidityscreenon=true;

humiditydata = cp5.addTextarea("DATA")             
                  .setPosition(70,100)
                  .setSize(300,400)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(128))
    .setColorBackground(color(217, 217, 217))
                  .showScrollbar()
                  .setScrollActive(5)
                  ;
 
  humidityinfo = dtf.format(now) +", Slot:" + humidityslot +", " + portdata + "\n";
  humiditydata.setText(humidityinfo);
     
  humiditychart = cp5.addChart("dataflow")
               .setPosition(400, 100)
               .setSize(250, 250)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
                   .setColorBackground(color(217, 217, 217))
               .setColorCaptionLabel(color(239,239,239))  ;

  humiditychart.addDataSet("Humidity");
  humiditychart.setData("Humidity", new float[100]); 
  
    humidityError= cp5.addTextarea("Error")
                  .setPosition(70,550)
                  .setSize(300,200)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(255,0,0))
    .setColorBackground(color(217, 217, 217))
                  ;
humidityError.setText("High Humidity\nLow Humidity");
}

void Light()
{
tempbutton.hide();
o2button.hide();
co2button.hide();
humiditybutton.hide();
motorbutton.hide();
camerabutton.hide();
lightbutton.hide();
backbutton.show();
reglight.show();
coollight.show();
lightsettings.show();

lightscreenon=true;

lightdata = cp5.addTextarea("DATA")             
                  .setPosition(70,100)
                  .setSize(300,400)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(128))
    .setColorBackground(color(217, 217, 217))
                  .showScrollbar()
                  .setScrollActive(5)
                  ;
 
  lightinfo = dtf.format(now) +", Slot:" + humidityslot +", " + "\nLight On/Off at   " + "\n";
  lightdata.setText(lightinfo);
  
}

void Camera(){
  port.write('x');
tempbutton.hide();
o2button.hide();
co2button.hide();
humiditybutton.hide();
motorbutton.hide();
camerabutton.hide();
lightbutton.hide();
backbutton.show();
camerasettings.show();

camerascreenon=true;

cameradata = cp5.addTextarea("DATA")             
                  .setPosition(70,100)
                  .setSize(300,400)
                  .setFont(font)
                  .setLineHeight(50)
                  .setColor(color(128))
    .setColorBackground(color(217, 217, 217))
                  .showScrollbar()
                  .setScrollActive(5)
                  ;
 
  camerainfo = dtf.format(now) +", Slot:" + humidityslot +", " + "\nCamera On/Off at   " + "\n";
  cameradata.setText(camerainfo);
}

void Back()
{ 
  port.write('b');
tempbutton.show();
o2button.show();
co2button.show();
humiditybutton.show();
motorbutton.show();
camerabutton.show();
lightbutton.show();
backbutton.hide();
temponoff.hide();
tempsettings.hide();
if (humidityscreenon==true)
{
humiditydata.remove();
humiditychart.remove();
humidityError.remove();
temphighlimitinput.remove();
templowlimitinput.remove();
tempdays.hide();
temphours.hide();
tempminutes.hide();
tempseconds.hide();
}
if(co2screenon==true)
{
  co2data.remove();
  co2chart.remove();
  co2Error.remove();
  temphighlimitinput.remove();
templowlimitinput.remove();
  tempdays.hide();
temphours.hide();
tempminutes.hide();
tempseconds.hide();
}
if(o2screenon==true)
{
  o2data.remove();
  o2chart.remove();
  o2Error.remove();
  temphighlimitinput.remove();
templowlimitinput.remove();
  tempdays.hide();
temphours.hide();
tempminutes.hide();
tempseconds.hide();
}
if(tempscreenon==true)
{
tempsettings.hide();
tempchart.remove();
tempdata.remove();
tempError.remove();
temphighlimitinput.remove();
templowlimitinput.remove();
tempdays.hide();
temphours.hide();
tempminutes.hide();
tempseconds.hide();
}
if(camerascreenon==true)
{
  tempsettings.hide();
  cameradata.remove();
tempdays.hide();
temphours.hide();
tempminutes.hide();
tempseconds.hide();
}
if(motorscreenon==true)
{
   tempsettings.hide();
  motordata.remove();
  motorspeed.remove();
motorstart.remove();
motorstop.remove();
}
if(lightscreenon==true)
{
  tempsettings.hide();
  reglight.hide();
  coollight.hide();
  lightdata.hide();
lightrgb.remove();
lightstart.remove();
lightstop.remove();
lightbright.remove();
}


tempscreenon= false;
humidityscreenon = false;
o2screenon=false;
co2screenon=false;
camerascreenon=false;
motorscreenon=false;
lightscreenon=false;

}
void RegLight()
{
  if(portdatawritelight=="l")
{
  port.write('z');
  portdatawritelight="z";
}
else
{
  port.write('l');
  portdatawritelight="l";
}
}
void PartyMode()
{
if(portdatawritelight=="r")
{
  port.write('z');
  portdatawritelight="z";
}
else
{
  port.write('r');
  portdatawritelight="r";
}
}
void TempSettings()
{
  tempsettings.hide();
  temponoff.hide();
  tempdays.show();
  temphours.show();
  tempminutes.show();
  tempseconds.show();
  if (humidityscreenon==true)
{
humiditydata.remove();
humiditychart.remove();
humidityError.remove();
}
if(co2screenon==true)
{
  co2data.remove();
  co2chart.remove();
  co2Error.remove();
}
if(o2screenon==true)
{
  o2data.remove();
  o2chart.remove();
  o2Error.remove();
}
if(tempscreenon==true)
{
tempchart.remove();
tempdata.remove();
tempError.remove();
}
  temphighlimitinput=cp5.addTextfield("High limit")
     .setPosition(200,200)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
     .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;    
    
   templowlimitinput=cp5.addTextfield("Low limit")
     .setPosition(200,300)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;
     
}
void MotorSettings()
{
  motorsettings.hide();
  motordata.remove();
  motorspeed=cp5.addTextfield("Speed")
     .setPosition(200,200)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
     .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;     
   motorstart=cp5.addTextfield("Start")
     .setPosition(200,300)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;
      motorstop=cp5.addTextfield("Stop")
     .setPosition(200,400)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;
}
void CameraSettings()
{
  camerasettings.hide();
  cameradata.remove();
  tempdays.show();
  temphours.show();
  tempminutes.show();
  tempseconds.show();
  
}
void LightSettings()
{
  lightsettings.hide();
  reglight.hide();
  coollight.hide();
  lightdata.remove();
  lightrgb=cp5.addTextfield("RGB")
     .setPosition(200,100)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
     .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ; 
  lightbright=cp5.addTextfield("Brightness")
     .setPosition(200,200)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
     .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;     
   lightstart=cp5.addTextfield("Start")
     .setPosition(200,300)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;
      lightstop=cp5.addTextfield("Stop")
     .setPosition(200,400)
     .setSize(370,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(0,0,0))
     .setColorBackground(color(217,217,217))
     .setColorLabel(color(0,0,0))
          .setColorForeground(color(0,0,0))
     .setColorActive(color(0,0,0))
     ;
}

void ON()
{
  if(tempon==true)
  {
temponoff.setLabel("Off");
temponoff.setColorBackground(color(255,0,0));
temponoff.setColorForeground(color(255,0,0));
temponoff.setColorActive(color(0,255,0));
tempon = false;
  }
else
  {
temponoff.setLabel("On");
temponoff.setColorBackground(color(0,255,0));
temponoff.setColorForeground(color(0,255,0));
temponoff.setColorActive(color(255,0,0)); 
tempon=true;

  }
}
