import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import java.util.*;
String input;
PeasyCam cam;

/*
Hello all, welcome to my 3D Grapher presentation! Today we will be using the UserMod section. I have created the User Mod section so you can more easily
use this grapher. Please be patient as this is just a beta version of my program.



*/

Menu menu;
float max;
float stretch;
myFunction function;
String output;
String helpText;
PVector pointValue;
boolean integrating;
PVector[] integral;

void setup() {
  size(1500, 900, P3D);
  max = 5;
  stretch = 40/max;
  menu = new Menu();
  function = new myFunction();
  cam = new PeasyCam(this, 100);
  cam.setDistance(160);
  cam.lookAt(0, 0, 0);
  pointValue = new PVector(0,0,0);
  integrating = false;
  integral = new PVector[] {new PVector(0,0), new PVector(0,0)};
  input = "";
  output = "";
  helpText = "Welcome to TJ's 3D Grapher, and thanks for asking for the help. Press + to zoom in and _(underscore) to zoom out. \nHere are some helpful inputs (all x's and y's are floats):\nvalue x y\n(returns the z value at float x, float y)\nintegral x1 x2 y1 y2\n(integrates from [x1,x2] x [y1,y2])";
  helpText += "\nmax x1 x2 y1 y2\n(returns maximum value \nfor interval [x1,x2] x [y1,y2])";
  helpText += "\nmin x1 x2 y1 y2\n(returns minimum value \nfor interval [x1,x2] x [y1,y2])";
  helpText += "\nInput stop to close help";
}

void draw() {
  background(255);
  stroke(0);
  strokeWeight(2);
  noFill();
  //stroke(125,0,0);
  line(-40, 0, 40, 0);
  //stroke(0,125,0);
  line(0, -40, 0, 40);
  //stroke(0,0,125);
  line(0, 0, -40, 0, 0, 40);
  
  
  pushMatrix();
  textSize(10);
  rotateX(3*PI/2);
  translate(-2.5,-40,0);
  text("z", 0,0,0);
  popMatrix();
  
  pushMatrix();
  textSize(10);
  rotateX(3*PI/2);
  translate(-10,45,0);
  text("-z", 0,0,0);
  popMatrix();
  
  pushMatrix();
  textSize(10);
  translate(-2.5,-40,0);
  text("Y", 0,0,0);
  popMatrix();
  
  pushMatrix();
  textSize(10);
  translate(-7.5,45,0);
  text("-Y", 0,0,0);
  popMatrix();
  
  pushMatrix();
  textSize(10);
  rotateZ(PI/2);
  translate(-10,50,0);
  text("-x", 0,0,0);
  popMatrix();
  
  pushMatrix();
  textSize(10);
  rotateZ(PI/2);
  translate(-2.5,-40,0);
  text("x", 0,0,0);
  popMatrix();
  
  box(80);
  function.display();
  menu.display();
  
  strokeWeight(7.5);
  stroke(0, 200, 0);
  point(pointValue.x * stretch, -pointValue.y* stretch, pointValue.z* stretch);
  
  if(integrating){
    function.displayIntegral(integral[0].x, integral[1].x,integral[0].y,integral[1].y);
    
    
  }
  
}

void keyPressed(){
      if(keyCode == BACKSPACE){
        if(input.length() > 0){
        input = input.substring(0, input.length()-1);}}
       
       else if(keyCode == ENTER){
         if(input.contains("help")){
           menu.help = true;
         }else if(input.contains("stop")){
           menu.help = false;
         }else if(input.contains("value")){
           String[]v = input.split(" ");
           float x = (float) Double.parseDouble(v[1]);
           float y = (float) Double.parseDouble(v[2]);
           output = "f(" + x + "," +y  + ") = " + function.get(x,y);
           pointValue = new PVector(x, y, function.get(x,y));
         }else if(input.contains("max")){
           String[]v = input.split(" ");
           float x1 = (float) Double.parseDouble(v[1]);
           float x2 = (float) Double.parseDouble(v[2]);
           float y1 = (float) Double.parseDouble(v[3]);
           float y2 = (float) Double.parseDouble(v[4]);
           output = "The maxiumum for the function " + function + " on the interval [" + x1 + "," + x2 + "] x ["+ y1 + "," + y2 +"] is approximately: " + function.getMaximum(x1,x2,y1,y2).z;
           pointValue = function.getMaximum(x1,x2,y1,y2);
         }else if(input.contains("min")){
           String[]v = input.split(" ");
           float x1 = (float) Double.parseDouble(v[1]);
           float x2 = (float) Double.parseDouble(v[2]);
           float y1 = (float) Double.parseDouble(v[3]);
           float y2 = (float) Double.parseDouble(v[4]);
           output = "The miniumum for the function " + function + " on the interval [" + x1 + "," + x2 + "] x ["+ y1 + "," + y2 +"] is approximately: " + function.getMinimum(x1,x2,y1,y2).z;
           pointValue = function.getMinimum(x1,x2,y1,y2);
         }else if(input.contains("integral")){
           String[]v = input.split(" ");
           integral[0].x = (float) Double.parseDouble(v[1]);
           integral[1].x = (float) Double.parseDouble(v[2]);
           integral[0].y = (float) Double.parseDouble(v[3]);
           integral[1].y = (float) Double.parseDouble(v[4]);
           float dV = function.integrate(integral[0].x,integral[1].x,integral[0].y,integral[1].y);
           output = "The intergral for the function " + function + " on the interval [" + integral[0].x + "," + integral[1].x + "] x ["+ integral[0].y + "," + integral[1].y +"] is approximately: " + dV;
           integrating = true;
       }else if(input.contains("view")){
           menu.view = !menu.view;
       }
         
         input = "";
       }
       else if(key == '+'){
        max--;
        stretch = 40/max;
       }
       else if(key == '_'){
        max++;
        stretch = 40/max;
       }else if(key == 'S'){
        function.sketch = function.sketch.mult(2); 
         
       }else if(key == 'W'){
        function.sketch = function.sketch.mult(0.5); 
         
       }else if(key == 'D'){
        function.sketch.x -= (function.sketch.x/10); 
         
       }else if(key == 'A'){
        function.sketch.x += (function.sketch.x/10); 
         
       }
       else if(keyCode != SHIFT) input += key;
       
  
  
}


class Function {
  String name; 
  PVector calc;
  PVector sketch;
  Function(String n, PVector s) {
    name = n;
    calc = new PVector(0.001, 0.001);
    sketch = s;
  }
  float get(float x, float y) {
    return (float)Math.pow(x*x + y*y, 0.5);
  }

  void display() {
    strokeWeight(1);
    stroke(0, 21, 255);
    float z = 0;
    for (float x = (-max); x<(max); x+= sketch.x) {
      for (float y = (-max); y < (max); y+= sketch.y) {
        z = (float) function.get(x, y);

        if ((z < max) && (z > -max))
          point(x*stretch, -y*stretch,z*stretch);
      }
    }
    
    
   
  }

  float integrate(float x1, float x2, float y1, float y2) {
    double z = 0;
    for (float x = x1; x < x2; x += calc.x) {
      for (float y = y1; y < y2; y += calc.y) {
        z += (function.get(x,y));
      }
    }
    return (float)(z* (calc.x) * (calc.y));
  }
  void displayIntegral(float x1, float x2, float y1, float y2){
    for (float x = x1; x < x2; x += sketch.x) {
      for (float y = y1; y < y2; y += sketch.y) {
        stroke(255,0,0); 
        line(x*stretch,-y*stretch,get(x,y)*stretch, x*stretch,-y*stretch,0);
      }
    } 
  }  
  
  PVector getMaximum(float x1, float x2, float y1, float y2){
    PVector ret = new PVector (0,0,0);
    for (float x = x1; x < x2; x += calc.x) {
      for (float y = y1; y < y2; y += calc.y) {
        if(ret.z < get(x,y)){
         ret.x = x;
         ret.y = y;
         ret.z = get(x,y);
        }
      }
    }
    
    return ret;
    
    
  }
  PVector getMinimum(float x1, float x2, float y1, float y2){
    PVector ret = new PVector (0,0,0);
    for (float x = x1; x < x2; x += calc.x) {
      for (float y = y1; y < y2; y += calc.y) {
        if(ret.z > get(x,y)){
         ret.x = x;
         ret.y = y;
         ret.z = get(x,y);
        }
      }
    }
    
    return ret;
    
    
  }
  String toString(){
   return name; 
  }
}

class Menu{
  boolean help; 
  boolean view;
  Menu(){
    help = false;
    view = false;
    
  }
  
  void display(){
  cam.beginHUD();
  fill(0);
  textSize(25);
  text("TJ 3D Grapher Beta", 25,50);
  if(!help){
  text("" + function,25, 100);
  text("Window :: [" + -max +"," + max +"] x ["+ -max +"," + max + "] x ["+ -max +"," + max + "]", 25,150);
  if(!view)
  text("Input help and press [ENTER] to receive help", 25 , 200, 400, 500);
  }else{
  text(helpText, 25, 100, width, height);
  }
  
  text("INPUT :: " + input, 25, height - 125);
  text(output, 25, height - 75, width, height);
  cam.endHUD();
    
  }




}