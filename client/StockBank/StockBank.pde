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
String[] stocks;

void setup()
{
  size(800, 600);
  String[] tempstocks = { 
    "AAPL", "GOOG", "FB", "MSFT"
  };
  stocks = tempstocks;
  cp5 = new ControlP5(this);

  net = new Net();
  gui = new Gui(this, cp5, stocks);
  profile = new Profile();
  device = new Device(this);
  

  String url = net.getFormattedURL(stocks);
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

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.
  String[] s = {"AAPL","GOOG"};
  //UserInput ui = new Net();
  //net.selectedStock(tempstocks[(int)theEvent.getGroup().getValue()]);
  String[] params = new String[1];
  params[0] = stocks[(int)theEvent.getGroup().getValue()];
  println(params);
  String url = net.getFormattedURL(params);
  net.getStockData(join(loadStrings(url), ""), profile);
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}



