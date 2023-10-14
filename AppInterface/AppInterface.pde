/*
 * Things changed in AppInterface:
 *    Traffic Delay
 *    Traffic Light ON/OFF
 *    Light Delay
 *    Light Dimmness
 *    Threshold
 */

 //////////////////////////////   Import   /////////////////////////////////////////////////////////////////////////////////////
import processing.serial.*;
import javax.swing.JOptionPane;

//////////////////////////////   Control Center   /////////////////////////////////////////////////////////////////////////////////////
Serial myPort;
PFont font;
PFont font2;
PImage tick;
PImage cross;
color lFill = color(10, 65, 117);
color lTextC = color(255, 255, 255);
byte[] info = new byte[7];
float lWidthD = 6.5;
float lHeightD = 10;
String title = "Smart Lighting for Streets";
String[] trafficD = {"1", "1", "1"};
String lightD = "0";
String lightI = "0";
String irThreshold = "23";
boolean trafficOn = true;
boolean r;
boolean run;
boolean eCaught = false;
int screen = 1;
int editNo = 0;
int w = 0;
int h = 0;

//////////////////////////////   Setup   /////////////////////////////////////////////////////////////////////////////////////
void setup() {
  fullScreen();
  background(25, 144, 255);
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  w = width / 2;
  h = height / 2;
  font = loadFont("Figtree-Light-35.vlw");
  noStroke();
  tick = loadImage("tick.png");
  cross = loadImage("wrong.png");
  tick.resize(width / 20, width / 20);
  cross.resize(width / 20, width / 20);
}

//////////////////////////////   Draw   /////////////////////////////////////////////////////////////////////////////////////
void draw() {
  if(screen == 0){
    drawScreen0();
  
    if(clamp(mouseX, mouseY, width * 770 / 1440, height / 5, width * 1390 / 1440, height * 270 / 900)){
      cursor(HAND);
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 330 / 900, width * 1390 / 1440, height * 420 / 900)){
      cursor(TEXT);
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 480 / 900, width * 1390 / 1440, height * 570 / 900)){
      cursor(TEXT);
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 630 / 900, width * 1390 / 1440, height * 720 / 900)){
      cursor(TEXT);
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 780 / 900, width * 1390 / 1440, height * 870 / 900)){
      cursor(TEXT);
    }else{
      cursor(ARROW);
    }
    
    sendInfo();
  }else{
    drawScreen1();
    cursor(HAND);
  }
}

//////////////////////////////   drawScreen0   /////////////////////////////////////////////////////////////////////////////////////
void drawScreen0() {
  background(25, 144, 255);
  label(title, w, (h / 3) * 0.5, w * 12 / 7);
  label("Traffic Light On", w / 2, (h / 3) * 1.5, w * 6 / 7);
  label("Traffic Delay (in seconds)", w / 2, (h / 3) * 2.5, w * 6 / 7);
  label("Street Light Delay (in seconds)", w / 2, (h / 3) * 3.5, w * 6 / 7);
  label("Street Light Intensity", w / 2, (h / 3) * 4.5, w * 6 / 7);
  label("IR Threshold", w / 2, (h / 3) * 5.5, w * 6 / 7);

  for(int i = 1; i <= 5; i++){
    label("", (w / 2) * 3, (h / 3) * (i + 0.5), w * 6 / 7);
  }

  fill(255, 0, 0);
  ellipse(((w / 2) * 3) - (((w * 6 / 7) / 12) * 5), (h / 3) * 2.5, w / 10, w / 10);
  fill(255, 165, 0);
  ellipse(((w / 2) * 3) - (((w * 6 / 7) / 12) * 1), (h / 3) * 2.5, w / 10, w / 10);
  fill(0, 255, 0);
  ellipse(((w / 2) * 3) + (((w * 6 / 7) / 12) * 3), (h / 3) * 2.5, w / 10, w / 10);
  
  fill(lFill);
  rect(width * 9/10, height * 19.75/20, width * 330 / 2736, height * 45 / 1824);
  fill(lTextC);
  textFont(font, 20);
  text("Select Area", width * 9/10, height * 19.75/20);

  textFont(font, 50);
  fill(lTextC);
  text(trafficD[0], ((w / 2) * 3) - (((w * 6 / 7) / 12) * 3), (h / 3) * 2.5);
  text(trafficD[1], ((w / 2) * 3) + (((w * 6 / 7) / 12) * 1), (h / 3) * 2.5);
  text(trafficD[2], ((w / 2) * 3) + (((w * 6 / 7) / 12) * 5), (h / 3) * 2.5);
  text(lightD, (w / 2) * 3, (h / 3) * 3.5);
  text(lightI, (w / 2) * 3, (h / 3) * 4.5);
  text(irThreshold, (w / 2) * 3, (h / 3) * 5.5);

  if(trafficOn){
    tint(140, 140, 140);
    image(cross, (w / 2) * 3 + ((w * 6 / 7) / 6), (h / 3) * 1.5);
    noTint();
    image(tick, (w / 2) * 3 - ((w * 6 / 7) / 6), (h / 3) * 1.5);
  }else{
    noTint();
    image(cross, (w / 2) * 3 + ((w * 6 / 7) / 6), (h / 3) * 1.5);
    tint(140, 140, 140);
    image(tick, (w / 2) * 3 - ((w * 6 / 7) / 6), (h / 3) * 1.5);
  }
}

//////////////////////////////   drawScreen1   /////////////////////////////////////////////////////////////////////////////////////
void drawScreen1() {
  background(lFill);
  for(int i = 0; i < Serial.list().length; i++){
    textFont(font);
    fill(lTextC);
    text(Serial.list()[i], w, (h / 6) * (i + 0.5));
  }
}

//////////////////////////////   mousePressed   /////////////////////////////////////////////////////////////////////////////////////
void mousePressed() {
  if(screen == 0){
    if(clamp(mouseX, mouseY, width * 770 / 1440, height / 5, width * 1390 / 1440, height * 270 / 900)){
      if(trafficOn){
        r = false;
      }else{
        r = true;
      }
      trafficOn = r;
      editNo = 0;
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 330 / 900, width * 976 / 1400, height * 420 / 900)){
      editNo = 11;
    }else if(clamp(mouseX, mouseY, width * 976 / 1400, height * 330 / 900, width * 1182 / 1400, height * 420 / 900)){
      editNo = 12;
    }else if(clamp(mouseX, mouseY, width * 1182 / 1400, height * 330 / 900, width * 1390 / 1400, height * 420 / 900)){
      editNo = 13;
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 480 / 900, width * 1390 / 1440, height * 570 / 900)){
      editNo = 2;
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 630 / 900, width * 1390 / 1440, height * 720 / 900)){
      editNo = 3;
    }else if(clamp(mouseX, mouseY, width * 770 / 1400, height * 780 / 900, width * 1390 / 1440, height * 870 / 900)){
      editNo = 4;
    }else{
      editNo = 0;
    }
    
    if(clamp(mouseX, mouseY, width * 2297 / 2736, height * 1777 / 1824, width * 2623 / 2736, height * 1820 / 1824)){
      editNo = 0;
      screen = 1;
    }
  }else{
    run = true;
    for(int i = 11; i >= 0; i--){
      if(mouseY > (i * (height / 12)) && run == true){
        if(i < Serial.list().length){
          try{
            myPort = 
              new Serial(this, Serial.list()[i], 9600);
          }catch(Exception e){
            System.err.println("Port busy");
            //JOptionPane.showMessageDialog(frame, "Port busy"); //TODO: check
            eCaught = true;
          }
          if(eCaught != true){
            screen = 0;
          }
          run = false;
        }
        eCaught = false;
      }
    }
  }
}

//////////////////////////////   keyPressed   /////////////////////////////////////////////////////////////////////////////////////
void keyPressed() {
  if(keyCode < 58 && keyCode > 47){
    switch(editNo){
      case 11:
        trafficD[0] = trafficD[0] + key;
        if(int(trafficD[0]) > 255)
          trafficD[0] = "255";
        break;

      case 12:
        trafficD[1] = trafficD[1] + key;
        if(int(trafficD[1]) > 255)
          trafficD[1] = "255";
        break;

      case 13:
        trafficD[2] = trafficD[2] + key;
        if(int(trafficD[2]) > 255)
          trafficD[2] = "255";
        break;

      case 2:
        lightD = lightD + key;
        if(int(lightD) > 255)
          lightD = "255";
        break;

      case 3:
        lightI = lightI + key;
        if(int(lightI) > 255)
          lightI = "255";
        break;

      case 4:
        irThreshold = irThreshold + key;
        if(int(irThreshold) > 255)
          irThreshold = "255";
        break;

      default:
        break;
    }
  }else if(keyCode == 8){
    switch(editNo){
      case 11:
        if(trafficD[0].length() != 0)
          trafficD[0] = trafficD[0].substring(0, (trafficD[0].length() - 1));
        break;

      case 12:
        if(trafficD[1].length() != 0)
          trafficD[1] = trafficD[1].substring(0, (trafficD[1].length() - 1));
        break;

      case 13:
        if(trafficD[2].length() != 0)
          trafficD[2] = trafficD[2].substring(0, (trafficD[2].length() - 1));
        break;

      case 2:
        if(lightD.length() != 0)
          lightD = lightD.substring(0, (lightD.length() - 1));
        break;

      case 3:
        if(lightI.length() != 0)
          lightI = lightI.substring(0, (lightI.length() - 1));
        break;

      case 4:
        if(irThreshold.length() != 0)
          irThreshold = irThreshold.substring(0, (irThreshold.length() - 1));
        break;

      default:
        break;
    }
  }
}

//////////////////////////////   Clamp   /////////////////////////////////////////////////////////////////////////////////////
boolean clamp(int mx, int my, int x1, int y1, int x2, int y2) {
  if (mx > x1 && mx < x2) {
    if (my > y1 && my < y2) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

//////////////////////////////   Label   /////////////////////////////////////////////////////////////////////////////////////
void label(String text, float x, float y, float length){
  fill(lFill);
  textFont(font, 50);
  rect(x, y, length, height / lHeightD, 20);

  fill(lTextC);
  text(text, x, y);
}

//////////////////////////////   sendInfo   /////////////////////////////////////////////////////////////////////////////////////
void sendInfo(){
  writeInfo();
  try{
    myPort.available();
  }catch(Exception e){
    screen = 1;
    eCaught = true;
  }
  if(eCaught != true){
    if(myPort.available() > 0){
      myPort.read();
      myPort.write(info);
    }
  }
  eCaught = false;
}

//////////////////////////////   writeInfo   /////////////////////////////////////////////////////////////////////////////////////
void writeInfo(){
  info[0] = byte(int(trafficOn)); 
  info[1] = byte(int(trafficD[2]));
  info[2] = byte(int(trafficD[1]));
  info[3] = byte(int(trafficD[0]));
  info[4] = byte(int(lightD));
  info[5] = byte(int(lightI));
  info[6] = byte(int(irThreshold));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
