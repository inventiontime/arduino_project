import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AppInterface extends PApplet {

/*
 * Things changed in AppInterface:
 *    Traffic Delay
 *    Traffic Light ON/OFF
 *    Light Delay
 *    Light Dimmness
 *    Threshold
 *    PINS
 */

 //////////////////////////////   Import   /////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////   Control Center   /////////////////////////////////////////////////////////////////////////////////////
Serial myPort;
PFont font;
PImage tick;
PImage cross;
int lFill = color(10, 65, 117);
int lTextC = color(255, 255, 255);
float lWidthD = 6.5f;
float lHeightD = 10;
String title = "Smart Lighting for Streets";
String[] trafficD = {"1", "1", "1"};
String lightD = "0";
String lightI = "255";
String irThreshold = "35";
boolean delayActive = false;
boolean r;
int editNo = 0;
int w = 0;
int h = 0;

//////////////////////////////   Setup   /////////////////////////////////////////////////////////////////////////////////////
public void setup() {
  
  background(25, 144, 255);
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  w = width / 2;
  h = height / 2;
  font = loadFont("AmericanTypewriter-40.vlw");
  noStroke();
  tick = loadImage("tick.png");
  cross = loadImage("wrong.png");
  tick.resize(width / 20, width / 20);
  cross.resize(width / 20, width / 20);
  println(Serial.list());
}

//////////////////////////////   Draw   /////////////////////////////////////////////////////////////////////////////////////
public void draw() {
  label(title, w, (h / 3) * 0.5f, w * 12 / 7);
  label("Traffic Light On", w / 2, (h / 3) * 1.5f, w * 6 / 7);
  label("Traffic Delay (in seconds)", w / 2, (h / 3) * 2.5f, w * 6 / 7);
  label("Street Light Delay", w / 2, (h / 3) * 3.5f, w * 6 / 7);
  label("Street Light Intensity", w / 2, (h / 3) * 4.5f, w * 6 / 7);
  label("IR Threshold", w / 2, (h / 3) * 5.5f, w * 6 / 7);

  for(int i = 1; i <= 5; i++){
    label("", (w / 2) * 3, (h / 3) * (i + 0.5f), w * 6 / 7);
  }

  fill(255, 0, 0);
  ellipse(((w / 2) * 3) - (((w * 6 / 7) / 12) * 5), (h / 3) * 2.5f, 75, 75);
  fill(255, 165, 0);
  ellipse(((w / 2) * 3) - (((w * 6 / 7) / 12) * 1), (h / 3) * 2.5f, 75, 75);
  fill(0, 255, 0);
  ellipse(((w / 2) * 3) + (((w * 6 / 7) / 12) * 3), (h / 3) * 2.5f, 75, 75);

  textFont(font);
  fill(lTextC);
  text(trafficD[0], ((w / 2) * 3) - (((w * 6 / 7) / 12) * 3), (h / 3) * 2.5f);
  text(trafficD[1], ((w / 2) * 3) + (((w * 6 / 7) / 12) * 1), (h / 3) * 2.5f);
  text(trafficD[2], ((w / 2) * 3) + (((w * 6 / 7) / 12) * 5), (h / 3) * 2.5f);
  text(lightD, (w / 2) * 3, (h / 3) * 3.5f);
  text(lightI, (w / 2) * 3, (h / 3) * 4.5f);
  text(irThreshold, (w / 2) * 3, (h / 3) * 5.5f);

  if(delayActive){
    tint(140, 140, 140);
    image(cross, (w / 2) * 3 + ((w * 6 / 7) / 6), (h / 3) * 1.5f);
    noTint();
    image(tick, (w / 2) * 3 - ((w * 6 / 7) / 6), (h / 3) * 1.5f);
  }else{
    noTint();
    image(cross, (w / 2) * 3 + ((w * 6 / 7) / 6), (h / 3) * 1.5f);
    tint(140, 140, 140);
    image(tick, (w / 2) * 3 - ((w * 6 / 7) / 6), (h / 3) * 1.5f);
  }

  if(clamp(mouseX, mouseY, 770, 180, 1390, 270)){
    cursor(HAND);
  }else if(clamp(mouseX, mouseY, 770, 330, 1390, 420)){
    cursor(TEXT);
  }else if(clamp(mouseX, mouseY, 770, 480, 1390, 570)){
    cursor(TEXT);
  }else if(clamp(mouseX, mouseY, 770, 630, 1390, 720)){
    cursor(TEXT);
  }else if(clamp(mouseX, mouseY, 770, 780, 1390, 870)){
    cursor(TEXT);
  }else{
    cursor(ARROW);
  }
}

//////////////////////////////   mousePressed   /////////////////////////////////////////////////////////////////////////////////////
public void mousePressed() {
  println(mouseX);
  println(mouseY);

  if(clamp(mouseX, mouseY, 770, 180, 1390, 270)){
    if(delayActive){
      r = false;
    }else{
      r = true;
    }
    delayActive = r;
    editNo = 0;
  }else if(clamp(mouseX, mouseY, 770, 330, 976, 420)){
    editNo = 11;
  }else if(clamp(mouseX, mouseY, 976, 330, 1182, 420)){
    editNo = 12;
  }else if(clamp(mouseX, mouseY, 1182, 330, 1390, 420)){
    editNo = 13;
  }else if(clamp(mouseX, mouseY, 770, 480, 1390, 570)){
    editNo = 2;
  }else if(clamp(mouseX, mouseY, 770, 630, 1390, 720)){
    editNo = 3;
  }else if(clamp(mouseX, mouseY, 770, 780, 1390, 870)){
    editNo = 4;
  }else{
    editNo = 0;
  }
}

//////////////////////////////   keyPressed   /////////////////////////////////////////////////////////////////////////////////////
public void keyPressed() {
  if(keyCode < 58 && keyCode > 47){
    switch(editNo){
      case 11:
        trafficD[0] = trafficD[0] + key;
        break;

      case 12:
        trafficD[1] = trafficD[1] + key;
        break;

      case 13:
        trafficD[2] = trafficD[2] + key;
        break;

      case 2:
        lightD = lightD + key;
        break;

      case 3:
        lightI = lightI + key;
        if(PApplet.parseInt(lightI) > 255)
          lightI = "255";
        break;

      case 4:
        irThreshold = irThreshold + key;
        break;

      default:
        break;
    }
  }else if(keyCode == 8){
    switch(editNo){
      case 11:
        trafficD[0] = trafficD[0].substring(0, (trafficD[0].length() - 1));
        break;

      case 12:
        trafficD[1] = trafficD[1].substring(1, (trafficD[1].length() - 1));
        break;

      case 13:
        trafficD[2] = trafficD[2].substring(2, (trafficD[2].length() - 1));
        break;

      case 2:
        lightD = lightD.substring(0, (lightD.length() - 1));
        break;

      case 3:
        lightI = lightI.substring(0, (lightI.length() - 1));
        if(PApplet.parseInt(lightI) > 255)
          lightI = "255";
        break;

      case 4:
        irThreshold = irThreshold.substring(0, (irThreshold.length() - 1));
        break;

      default:
        break;
    }
  }
}

//////////////////////////////   Clamp   /////////////////////////////////////////////////////////////////////////////////////
public boolean clamp(int mx, int my, int x1, int y1, int x2, int y2) {
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
public void label(String text, float x, float y, float length){
  fill(lFill);
  textFont(font);
  rect(x, y, length, height / lHeightD, 20);

  fill(lTextC);
  text(text, x, y);
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AppInterface" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
