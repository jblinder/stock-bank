/*  
 notes>>>>>>>>>>>>>>
 mySerial.write("   FB Share Price       $28.88");
 mySerial.write("    MSFT Share Price       $28.00");
 mySerial.write("AAPL Share Price       $430.58");
 reminder -- http://www.processing.org/discourse/beta/num_1263296127.html
 */
import org.json.*;
import processing.serial.*;
import controlP5.*;

ControlP5 cp5;

Net net;
Gui gui;
Profile profile;
Device device;

void setup()
{
  size(800, 600);

  cp5 = new ControlP5(this);

  net = new Net();
  gui = new Gui(this, cp5);
  profile = new Profile();
  device = new Device(this);
  
  String[] elements = { 
    "AAPL", "GOOG", "FB"
  };
  String url = net.getFormattedURL(elements);
  net.getStockData(join(loadStrings(url), ""), profile);
}

void update()
{
  if ( profile.stocks.size() > 0 ) {
    Stock s = (Stock)profile.stocks.get(0);
    gui.stockName = s.name;
    gui.stockAmount = Float.toString(s.price);
    device.sendStock(s.name, Float.toString(s.price));
  }
}

void draw()
{
  update();
  background(255, 255, 255);
  gui.draw();
}



