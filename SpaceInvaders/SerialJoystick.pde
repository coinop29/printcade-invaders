

// Read from serial port and convert characters to key presses.
// We need to hold the key for at least one draw cycle, so the
// Processing sketch can process it.
//
// Each time we are called from draw:
// - clear any held keys
// - if there is a character at the serial port:
//   - read the character
//   - if it's a known character:
//      - hold the corresponding key
//      - queue the key to be released next time we're called

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.util.Queue;
import java.util.LinkedList;
import processing.serial.*;


class SerialJoystick {

  Robot robot;
  Serial serialPort;
  Queue<Integer> heldKeys;
 
  void init(Serial aSerialPort) {
    heldKeys = new LinkedList<Integer>();
    
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
    //this.releaseHeldKeys();
    
    if (serialPort.available() > 0) {
      char inByte = serialPort.readChar();
      this.handleSerialChar(inByte);  
    }
  }
   
  // Call this with the char from serial readChar
  void handleSerialChar(char c) {

    if (c == 'B') {
      pressShoot();
      
    } else if (c == 'l') {
      pressLeft();
        this.holdKey(KeyEvent.VK_LEFT);
    } else if (c == 'r') {
      pressRight();
      this.holdKey(KeyEvent.VK_RIGHT);
    } else {
      println("SerialJoystick - unknown char '", c, "'");
    }
  }
  
  void pressLeft() { 
    println("L");
    this.holdKey(KeyEvent.VK_LEFT);
   }
  
  void pressRight() {
    println("R");
    this.holdKey(KeyEvent.VK_RIGHT);
  }
  
  void pressShoot() {
    println("B");
    invaderDeath = minim.loadFile("shoot.wav");
    this.holdKey(KeyEvent.VK_SPACE);
  }
  
  void holdKey(int aKey)
  {
    robot.keyPress(aKey);
    heldKeys.add(new Integer(aKey));
  }
  
  void releaseHeldKeys()
  {
    while (heldKeys.size() > 0) {
      Integer aKey = heldKeys.remove();
      robot.keyRelease(aKey.intValue());
    }
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
