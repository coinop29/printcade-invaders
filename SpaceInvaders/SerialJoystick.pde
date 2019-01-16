

// Read from serial port and convert characters to key presses

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import processing.serial.*;


class SerialJoystick {

  Robot robot;
  Serial serialPort;
 
  void init(Serial aSerialPort) {
    try { 
      robot = new Robot();
    } catch (AWTException e) {
      e.printStackTrace();   
      exit();
    }
    
    serialPort = aSerialPort;
    
  }
  
  // Should be called each draw loop
  // Processes serial to simulated keyboard
  void draw() {
    if (serialPort.available() > 0) {
      char inByte = serialPort.readChar();
      this.handleSerialChar(inByte);  
    }
  }
   
  // Call this with the char from serial readChar
  void handleSerialChar(char c) {

    if (c == 'B') {
      pressShoot();
    } else if (c == 'L') {
      pressLeft();
    } else if (c == 'R') {
      pressRight();
    } else {
      println("SerialJoystick - unknown char '", c, "'");
    }
  }
  
  void pressLeft() { 
    // println("L");
    robot.keyPress(KeyEvent.VK_LEFT);
    robot.keyRelease(KeyEvent.VK_LEFT);
  }
  
  void pressRight() {
    // println("R");
    robot.keyPress(KeyEvent.VK_RIGHT);
    robot.keyRelease(KeyEvent.VK_RIGHT);
  }
  
  void pressShoot() {
    // println("B");
    robot.keyPress(KeyEvent.VK_SPACE);
    robot.keyRelease(KeyEvent.VK_SPACE);
  }
  
  void test() {
    //Press the space key
    // robot.keyPress(KeyEvent.VK_SPACE);
    //If we want a delay here, that gets a little bit more complicated...
    //robot.keyRelease(KeyEvent.VK_SPACE);
    
    
    // Demo
    println("Sending B");
    handleSerialChar('B');
    println("");
    
    println("Sending L");
    handleSerialChar('L');
    println("");
    
    println("Sending R");
    handleSerialChar('R');
    println("");
   
  }
  
}
