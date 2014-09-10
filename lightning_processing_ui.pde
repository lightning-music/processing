import controlP5.*;
import oscP5.*;
import netP5.*;

ControlP5 cp5;
OscP5 oscP5;
NetAddress oscServer;

void setup() {
  size(800, 450);
  noStroke();
  
  /* set up OSC comm */
  oscP5 = new OscP5(this, 4801);
  oscServer = new NetAddress("127.0.0.1", 4800);
  
  /* set up GUI controllers */
  cp5 = new ControlP5(this);
  for (int i = 0; i < 4; i++) {
    cp5.addBang("sample" + (i + 1))
       .setPosition(60 + (120 * i), 60)
       .setSize(60, 60)
       .setId(i)
       ;
  }
}

void draw() {
  background(40);
}

public void controlEvent(ControlEvent ev) {
  OscMessage msg = new OscMessage("/sample/play");
  msg.add("path/to/audio.wav");
  oscP5.send(msg, oscServer);
}
