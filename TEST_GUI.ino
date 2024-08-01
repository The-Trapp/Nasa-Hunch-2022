#include <SparkFunBME280.h>
#include <SparkFunCCS811.h>
#include "SparkFun_ProDriver_TC78H670FTG_Arduino_Library.h"
#include <FastLED.h>

#define CCS811_ADDR 0x5B //Default I2C Address
//#define CCS811_ADDR 0x5A //Alternate I2C Address

#define NUM_LEDS 1
#define DATA_PIN 10

CRGB leds[NUM_LEDS];
char data;
PRODRIVER myProDriver;
//Global sensor objects
CCS811 myCCS811(CCS811_ADDR);
BME280 myBME280;
double temp;
int CO2;
int TVOC;
double pressure;
int humidity;

void setup()
{
  Serial.begin(9600);
//  Serial.println();
//  Serial.println("Apply BME280 data to CCS811 for compensation.");
  FastLED.addLeds<WS2812B, DATA_PIN, RGB>(leds, NUM_LEDS);  // GRB ordering is typical

   myProDriver.begin(); // custom pins defined above
   
  Wire.begin();//initialize I2C bus

 // This begins the CCS811 sensor and prints error status of .begin()
 myCCS811.begin();
 

  //Initialize BME280
  //For I2C, enable the following and disable the SPI section
  myBME280.settings.commInterface = I2C_MODE;
  myBME280.settings.I2CAddress = 0x77;
  myBME280.settings.runMode = 3; //Normal mode
  myBME280.settings.tStandby = 0;
  myBME280.settings.filter = 4;
  myBME280.settings.tempOverSample = 5;
  myBME280.settings.pressOverSample = 5;
  myBME280.settings.humidOverSample = 5;

  //Calling .begin() causes the settings to be loaded
  delay(5);  //Make sure sensor had enough time to turn on. BME280 requires 2ms to start up.
myBME280.begin();
//  if (id != 0x60)
//  {
//    Serial.println("Problem with BME280");
//  }
//  else
//  {
//    Serial.println("BME280 online");
//  }
}
void loop()
{
  if(Serial.available())
  {
    data=Serial.read();
  }
    if(data == 'r')
  {
  leds[0] = CRGB::Pink;
  FastLED.show();
    FastLED.delay(200);
    leds[0] = CRGB::Gold;
  FastLED.show();
    FastLED.delay(200);
        leds[0] = CRGB::Cyan;
  FastLED.show();
    FastLED.delay(200);
      leds[0] = CRGB::Blue;
  FastLED.show();
    FastLED.delay(200);
    leds[0] = CRGB::Red;
  FastLED.show();
    FastLED.delay(200);
  }
  else
  {
  leds[0] = CRGB::Black;
  FastLED.show(); 
  }
  if(data == 'l')
  {
  leds[0] = CRGB::Yellow;
  FastLED.show();
  FastLED.delay(500);
  }
  else
  {
  leds[0] = CRGB::Black;
  FastLED.show(); 
  }


  if(data == 'm')
  {
//    myProDriver.setTorque(PRODRIVER_TRQ_100);
//    myProDriver.enable();
//myProDriver.settings.stepResolutionMode = PRODRIVER_STEP_RESOLUTION_VARIABLE_1_16; // 1:1 <--> 1:16
  myProDriver.step(2000, 0); // turn 200 steps, CW direction
//  myProDriver.step(200, 1); // turn 200 steps, CCW direction
//  delay(1000);
}
//  myProDriver.step(200,1);
//  delay(1000);
  


  if (myCCS811.dataAvailable()) //Check to see if CCS811 has new data (it's the slowest sensor)
  {
    myCCS811.readAlgorithmResults(); //Read latest from CCS811 and update tVOC and CO2 variables
    //getWeather(); //Get latest humidity/pressure/temp data from BME280
    printData(); //Pretty print all the data
  }
  else if (myCCS811.checkForStatusError()) //Check to see if CCS811 has thrown an error
  {
    Serial.println(myCCS811.getErrorRegister()); //Prints whatever CSS811 error flags are detected
  }

  delay(2000); //Wait for next reading
} 
void printData()
{
  temp = myBME280.readTempC();
  CO2 = myCCS811.getCO2();
  TVOC = myCCS811.getTVOC();
  pressure= myBME280.readFloatPressure();
  humidity= myBME280.readFloatHumidity();

    Serial.print(CO2);

  Serial.print(",");

  Serial.print(TVOC);

  Serial.print(",");

  Serial.print(temp);

  Serial.print(",");

  Serial.print(pressure);

  Serial.print(",");

  Serial.print(humidity);

  Serial.println();
//  Serial.print(" CO2=");
//  Serial.print(CO2);
//  Serial.print("ppm");
//
//  Serial.print(" TVOC=");
//  Serial.print(TVOC);
//  Serial.print("ppb");
//
//  Serial.print(" temp=");
//  Serial.print(temp, 1);
//  Serial.print("C");
//
//  //Serial.print(" temp[");
//  //Serial.print(myBME280.readTempF(), 1);
//  //Serial.print("]F");
//
////  Serial.print(" pressure[");
////  Serial.print(pressure, 2);
////  Serial.print("]Pa");
//
//  //Serial.print(" pressure[");
//  //Serial.print((myBME280.readFloatPressure() * 0.0002953), 2);
//  //Serial.print("]InHg");
//
//  //Serial.print("altitude[");
//  //Serial.print(myBME280.readFloatAltitudeMeters(), 2);
//  //Serial.print("]m");
//
//  //Serial.print("altitude[");
//  //Serial.print(myBME280.readFloatAltitudeFeet(), 2);
//  //Serial.print("]ft");
//
//  Serial.print(" humidity=");
//  Serial.print(myBME280.readFloatHumidity(), 0);
//  Serial.print("%");

//  Serial.println();
}
