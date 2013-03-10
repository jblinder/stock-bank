/*  
 notes>>>>>>>>>>>>>>
 
 conversatiot: 
 mySerial.write("   FB Share Price       $28.88");
 [3/8/13 5:31:20 PM] JBC:  mySerial.write("    MSFT Share Price       $28.00");
 [3/8/13 5:31:26 PM] JBC: mySerial.write("AAPL Share Price       $430.58");
 so you turn it to the apple click - and it shows how much left for Apple, then to the FB one and it shows how much needed for FB, etc
 
 reminder -- http://www.processing.org/discourse/beta/num_1263296127.html
 */

import org.json.*;

Net net;
Gui gui;
Profile profile;

void setup()
{
  size(800, 600);

  net = new Net();
  gui = new Gui();
  profile = new Profile();
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
    println(s);
    gui.stockName = s.name;
    gui.stockAmount = Float.toString(s.price);
  }
}

void draw()
{
  update();
  background(255, 255, 255);
  gui.draw();
}



