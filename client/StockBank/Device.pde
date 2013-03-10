class Device
{
  PApplet parent;
  Serial port;
  
  Device(PApplet p)
  { 
    parent = p;
    port = new Serial(parent, Serial.list()[0], 9600);
  }
  
  void send() 
  {
     port.write("BAM! DATA! iu0921jrfeawr;kDSAK:FA");
  }
}
