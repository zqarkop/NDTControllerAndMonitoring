/****************************************************************
 NDT Controller and Monitoring With Eddy Current Testing Project
 https://github.com/zqarkop/NDTControllerAndMonitoring
 ****************************************************************
 Schematic Diagram Shown Below
 LINK DIAGRAM SKEMATIK
 
 This project using Arduino Mega 2560, Board Ramps 1.4, Stepper Motor Hessai 17HS4401, 
  Driver Motor AM4988, Osciloscope Hante 6022BE, Eddy Current Sensor, Low Pass Filter, 
  Op Amp, Signal Generator, Mechanical Printer 3D Prusa i3, Dual Switching Power Supply
 For controlling and monitoring this project, you can use visual basic 6.0 program from the link shown on top
 
 Created Dec 2022
 By
 [Andi Saputra](3332190032)
 Teknik Elektro, Universitas Sultan Ageng Tirtayasa
 *****************************************************************/
 
#define X_STEP_PIN         54
#define X_DIR_PIN          55
#define X_ENABLE_PIN       38
#define X_MIN_PIN           3
#define X_MAX_PIN           2

#define Y_STEP_PIN         60
#define Y_DIR_PIN          61
#define Y_ENABLE_PIN       56
#define Y_MIN_PIN          14
#define Y_MAX_PIN          15

#define Z_STEP_PIN         46
#define Z_DIR_PIN          48
#define Z_ENABLE_PIN       62
#define Z_MIN_PIN          18
#define Z_MAX_PIN          19

int konstantaStep2Mm = 80; //default 81 ==> 81 steps = 1mm
int stepCustom = 1;//default 1 ==> 1mm per step
int delayMotorPerMM = 1;
int speedMotor = 1;
int coordinateX = 0;
int coordinateY = 0;
int boundLeft,boundRight;

float chord,radiusChord;
float manualTravel = 1; //default 1 ==> setiap gerakin manual jaraknya 1mm

bool modeAuto = false; //default false
bool directionXAutoVertikal = true; //default TRUE
bool directionYAutoVertikal = false; //default false
bool directionXAutoHorizontal = true; //default TRUE
bool directionYAutoHorizontal = false; //default false
bool directionXAutoCircle = true; //default TRUE
bool directionYAutoCircle = false; //default false
bool isHalfCircle = true; //default true
bool isEndCircle = true; //default true
bool calibratedX = false; //default false
bool calibratedY = false; //default false
bool calibratedStepper = false; //default false

void setup() {
  pinMode(X_STEP_PIN  , OUTPUT);
  pinMode(X_DIR_PIN    , OUTPUT);
  pinMode(X_ENABLE_PIN    , OUTPUT);
  
  pinMode(Y_STEP_PIN  , OUTPUT);
  pinMode(Y_DIR_PIN    , OUTPUT);
  pinMode(Y_ENABLE_PIN    , OUTPUT);
  
  pinMode(Z_STEP_PIN  , OUTPUT);
  pinMode(Z_DIR_PIN    , OUTPUT);
  pinMode(Z_ENABLE_PIN    , OUTPUT);
  
  digitalWrite(X_ENABLE_PIN    , LOW);
  digitalWrite(Y_ENABLE_PIN    , LOW);
  digitalWrite(Z_ENABLE_PIN    , LOW);
  
  bool directionXAutoVertikal = true; //default TRUE
  bool directionYAutoVertikal = false; //default false
  bool directionXAutoHorizontal = true; //default TRUE
  bool directionYAutoHorizontal = false; //default false
  bool directionXAutoCircle = true; //default TRUE
  bool directionYAutoCircle = false; //default false
  
  Serial.begin(115200);
}

void loop () {
  if(Serial.available()){
    char val = Serial.read();
    if(val == 'c'){
      calibratedX = false;calibratedY = false;calibratedStepper = false;
      while(!calibratedStepper){
        calibrationPosition();
      }
      state2Default();
    }
    if(val == 's'){ //baca step per mm
      bool bacaStep = true;
      while(bacaStep){
        String bacaStepString = Serial.readString();
        if(bacaStepString != ""){
          String stepString = getValueParsingData(bacaStepString, ',', 0);
          int bacaStepInt = stepString.toInt(); //rubah string ke integer
          stepCustom = stepCustom * bacaStepInt;
          konstantaStep2Mm = konstantaStep2Mm * bacaStepInt;
          bacaStep = false;
        }
      }
    }
    if(val == 'x'){
      moveX(manualTravel, 1, true); //panjang kecepatan arah(Ke Kanan)
    }
    if(val == '1'){
      moveX(manualTravel, 1, false); //panjang kecepatan arah(Ke Kiri)
    }
    if(val == 'y'){
      moveY(manualTravel, 1, true); //panjang kecepatan arah(Bed ke arah badan)
    }
    if(val == '2'){
      moveY(manualTravel, 1, false); //panjang kecepatan arah(Bed ke arah selain badan)
    }
    if(val == 'z'){
      moveZ(15, 1, true); //panjang kecepatan arah(Ke Atas)
    }
    if(val == '3'){
      moveZ(15, 1, false); //panjang kecepatan arah(Ke Bawah)
    }
    if(val == 'a'){
      modeAuto = true;
      while(modeAuto){
        String inputModeAuto = Serial.readString();
        if(inputModeAuto != ""){
          String heightModeAutoString = getValueParsingData(inputModeAuto, ',', 0); //ngambil data yang depan
          String widthModeAutoString = getValueParsingData(inputModeAuto, ',', 1); //ngambil data yang belakang
          int heightModeAuto = heightModeAutoString.toInt(); //rubah string ke integer
          int widthModeAuto = widthModeAutoString.toInt(); //rubah string ke integer
          startAutoHorizontal(heightModeAuto, widthModeAuto, 1); //height, width, panjang jalan ke bawah (sumbu y)
          modeAuto = false;
        }
      }
    }
    if(val == 'b'){
      modeAuto = true;
      while(modeAuto){
        String inputModeAuto = Serial.readString();
        if(inputModeAuto != ""){
          String radiusModeAutoString = getValueParsingData(inputModeAuto, ',', 0);
          int radiusModeAuto = radiusModeAutoString.toInt(); //rubah string ke integer
          automaticCircle(radiusModeAuto); //jari jari
          modeAuto = false;
        }
      }
    }
  }
}

void automaticCircle(float radius){
  radius = radius / stepCustom;
  if(isHalfCircle){
   for(int p = radius; p >= 0; p--){
    automaticCircleMove(radius,p);
    directionXAutoCircle = !directionXAutoCircle;
    if(p != radius){automaticCircleMove(radius,p);}
    if(p != 0){moveY(1*stepCustom, speedMotor, directionYAutoCircle);}
   }
   isHalfCircle = false;
  }
  if(!isHalfCircle && isEndCircle){
   for(int p = 1; p <= radius; p++){
    directionXAutoCircle = !directionXAutoCircle;
    repositionSecondHalfCircle(radius,p);
    moveY(1*stepCustom, speedMotor, directionYAutoCircle);
    automaticCircleMove(radius,p);
   }
   isEndCircle = false;
  }
}

void repositionSecondHalfCircle(float radius,int p){
  if(directionXAutoCircle == false){
    while(coordinateX != getboundRight(radius,p)){
      moveX(1*stepCustom, speedMotor, directionXAutoCircle);
    }
  }
  else{
    while(coordinateX != getboundLeft(radius,p)){
      moveX(1*stepCustom, speedMotor, directionXAutoCircle);
    }
  }
}

void automaticCircleMove(float radius,int p){
  if(directionXAutoCircle == true){
    while(coordinateX != getboundRight(radius,p)){
      moveX(1*stepCustom, speedMotor, directionXAutoCircle);
    }
  }
  else{
    while(coordinateX != getboundLeft(radius,p)){
      moveX(1*stepCustom, speedMotor, directionXAutoCircle);
    }
  }
}

int getboundLeft(float radius, int p){
    chord = 2*sqrt(pow(radius,2)-pow(p,2));
    radiusChord = sqrt(pow(radius,2)-pow(p,2));
    boundLeft = radius - radiusChord;
    boundRight = radius + radiusChord; 
    return boundLeft;
}
int getboundRight(float radius, int p){
    chord = 2*sqrt(pow(radius,2)-pow(p,2));
    radiusChord = sqrt(pow(radius,2)-pow(p,2));
    boundLeft = radius - radiusChord;
    boundRight = radius + radiusChord;  
    return boundRight;
}

void startAutoHorizontal(float height, float width, float heightTravel){
  float yMaxAutoHorizontal = 0;
  heightTravel = stepCustom;
  bool initializedAutoHorizontal = false;
  bool doneAutoHorizontal = false;
  bool looping = true;
  while(looping){
    if(!initializedAutoHorizontal){
      moveX(width, speedMotor, directionXAutoHorizontal);
      directionXAutoHorizontal = !directionXAutoHorizontal;
      initializedAutoHorizontal = true;
    }
    if(yMaxAutoHorizontal < height){
      moveY(heightTravel, speedMotor, directionYAutoHorizontal);
      yMaxAutoHorizontal += heightTravel;
    }
    if(!doneAutoHorizontal){
      moveX(width, speedMotor, directionXAutoHorizontal);
      directionXAutoHorizontal = !directionXAutoHorizontal;
    }
    if(!(yMaxAutoHorizontal < height)){
      doneAutoHorizontal = true;
      looping = false;
    }
  }
}

void startAutoVertikal(float height, float width, float heightTravel){
  float xMaxAutoVertikal = 0;
  heightTravel = stepCustom;
  bool initializedAutoVertikal = false;
  bool doneAutoVertikal = false;
  bool looping = true;
  while(looping){
    if(!initializedAutoVertikal){
      moveY(height, speedMotor, directionYAutoVertikal);
      directionYAutoVertikal = !directionYAutoVertikal;
      initializedAutoVertikal = true;
    }
    if(xMaxAutoVertikal < width){
      moveX(heightTravel, speedMotor, directionXAutoVertikal);
      xMaxAutoVertikal += heightTravel;
    }
    if(!doneAutoVertikal){
      moveY(height, speedMotor, directionYAutoVertikal);
      directionYAutoVertikal = !directionYAutoVertikal;
    }
    if(!(xMaxAutoVertikal < width)){
      doneAutoVertikal = true;
      looping = false;
    }
  }
}

String printCoordinate(){
  String Coordinate = String(coordinateX) + "," + String(coordinateY);
  return Coordinate;
}

void moveX(float distance, float speedMotor, bool direction){
  distance = distance*konstantaStep2Mm/stepCustom;
  digitalWrite(X_DIR_PIN, direction);
  for(int x = 0; x < distance; x++){
    digitalWrite(X_STEP_PIN, HIGH);
    delay(speedMotor);
    digitalWrite(X_STEP_PIN, LOW);
    delay(speedMotor);
    if(x % (konstantaStep2Mm) == false){
      delay(delayMotorPerMM);
      direction ? coordinateX += 1 : coordinateX -= 1;
      Serial.print(printCoordinate());
//      delay(50);
    }
  }
}

void moveY(float distance, float speedMotor, bool direction){
  distance = distance*konstantaStep2Mm/stepCustom;
  digitalWrite(Y_DIR_PIN, direction);
  for(int y = 0; y < distance; y++){
    digitalWrite(Y_STEP_PIN, HIGH);
    delay(speedMotor);
    digitalWrite(Y_STEP_PIN, LOW);
    delay(speedMotor);
    if(y % (konstantaStep2Mm) == false){
      delay(delayMotorPerMM);
      direction ? coordinateY -= 1 : coordinateY += 1;
      Serial.print(printCoordinate());
//      delay(50);
    }
  }
}

void moveZ(float distance, float speedMotor, bool direction){
  distance = distance*konstantaStep2Mm/stepCustom;
  digitalWrite(Z_DIR_PIN, direction);
  for(int z = 0; z < distance; z++){
    digitalWrite(Z_STEP_PIN, HIGH);
    delay(speedMotor);
    digitalWrite(Z_STEP_PIN, LOW);
    delay(speedMotor);
  }
}

void calibrationPosition(){
  if((!calibratedStepper) && (digitalRead(X_MIN_PIN))){
    digitalWrite(X_DIR_PIN, LOW);
    digitalWrite(X_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(X_STEP_PIN, LOW);
    delay(1);
  }
  if(!(digitalRead(X_MIN_PIN))){
    calibratedX = true;
  }
  if((!calibratedStepper) && (digitalRead(Y_MIN_PIN))){
    digitalWrite(Y_DIR_PIN, HIGH);
    digitalWrite(Y_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(Y_STEP_PIN, LOW);
    delay(1);
  }
  if(!(digitalRead(Y_MIN_PIN))){
    calibratedY = true;
  }
  if(calibratedX && calibratedY){
    calibratedStepper = true;
    coordinateX = 0;
    coordinateY = 0;
  }
}

void moveXCalibration(float distance, float speedMotor, bool direction){
  distance = distance*81;//konstantaStep2Mm = 81
  digitalWrite(X_DIR_PIN, direction);
  for(int x = 0; x < distance; x++){
    digitalWrite(X_STEP_PIN, HIGH);
    delay(speedMotor);
    digitalWrite(X_STEP_PIN, LOW);
    delay(speedMotor);
  }
}

void moveYCalibration(float distance, float speedMotor, bool direction){
  distance = distance*81;//konstantaStep2Mm = 81
  digitalWrite(Y_DIR_PIN, direction);
  for(int y = 0; y < distance; y++){
    digitalWrite(Y_STEP_PIN, HIGH);
    delay(speedMotor);
    digitalWrite(Y_STEP_PIN, LOW);
    delay(speedMotor);
  }
}

void state2Default(){
  int coordinateX = 0;
  int coordinateY = 0;
  
  bool modeAuto = false; //default false
  bool directionXAutoVertikal = true; //default TRUE
  bool directionYAutoVertikal = false; //default false
  bool directionXAutoHorizontal = true; //default TRUE
  bool directionYAutoHorizontal = false; //default false
  bool directionXAutoCircle = true; //default TRUE
  bool directionYAutoCircle = false; //default false
  bool isHalfCircle = true; //default true
  bool isEndCircle = true; //default true
  bool calibratedX = false; //default false
  bool calibratedY = false; //default false
  bool calibratedStepper = false; //default false

  moveXCalibration(5, speedMotor, true);
  moveYCalibration(89, speedMotor, false);
}

String getValueParsingData(String data, char separator, int index){
  int found = 0;
  int strIndex[] = {0, -1};
  int maxIndex = data.length()-1;
 
  for(int i=0; i<=maxIndex && found<=index; i++){
    if(data.charAt(i)==separator || i==maxIndex){
        found++;
        strIndex[0] = strIndex[1]+1;
        strIndex[1] = (i == maxIndex) ? i+1 : i;
    }
  } 
 
  return found>index ? data.substring(strIndex[0], strIndex[1]) : "";
}
