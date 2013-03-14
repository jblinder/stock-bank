import processing.core.*; 
import processing.xml.*; 

import org.json.*; 
import processing.serial.*; 
import controlP5.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class StockBank extends PApplet {

/*  
 notes>>>>>>>>>>>>>>
 mySerial.write("   FB Share Price       $28.88");
 mySerial.write("    MSFT Share Price       $28.00");
 mySerial.write("AAPL Share Price       $430.58");
 reminder -- http://www.processing.org/discourse/beta/num_1263296127.html
 */




ControlP5 cp5;

Net net;
Gui gui;
Profile profile;
Device device;
String[] stocks;

public void setup()
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

public void update()
{
  if ( profile.stocks.size() > 0 ) {
    Stock s = (Stock)profile.stocks.get(0);
    gui.stockName = s.name;
    gui.stockAmount = Float.toString(s.price);
    device.sendStock(s.name, Float.toString(s.price));
  }
}

public void draw()
{
  update();
  background(255, 255, 255);
  gui.draw();
}

public void controlEvent(ControlEvent theEvent) {
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



class Frame{
   int x;
   int y;
   int width;
   int height; 
}

class Controls implements UserInput
{
  List<UserInput> delegates = new ArrayList<UserInput>();
  String textValue = "";
  ControlP5 app;
  Frame frame;
  String[] stocks;
  DropdownList dropDown;

  Controls(ControlP5 cp5, String[] s)
  {
    app = cp5;  
    stocks = s;
    setup();
  }

  public void setup() 
  {
    PFont font = createFont("arial", 20);


    /*cp5.addTextfield("input")
      .setPosition(20, 100)
        .setSize(200, 40)
          .setFont(font)
            .setFocus(true)
              .setColor(color(0, 0, 0))
              .setColorActive(color(0, 0, 0))
               .setColorBackground(color(255, 255, 255))
                ;
                */
   dropDown = cp5.addDropdownList("stocks")
          .setPosition(600, 60)
          .setHeight(100)
          .setWidth(100)
          .setColorBackground(255)
              .setColorBackground(255)
                .setColorActive(color(122,122,122))
               .setColorBackground(color(255, 255, 255))
               .setColorForeground(color(0,0,0))
               .setBarHeight(15)
               .setItemHeight(15)
               .setColorLabel(0);
    for ( int i = 0; i < stocks.length; i++) {
        dropDown.addItem(stocks[i],i);
    }
          
    /*               
    cp5.addTextfield("textValue")
      .setPosition(20, 170)
        .setSize(200, 40)
          .setFont(createFont("arial", 20))
            .setValue("Add stocks here")
            .setAutoClear(true)
              .setColorActive(255)
               .setColorBackground(255)
                .setColor(color(0, 0, 0))
                .setColorActive(color(0, 0, 0))
               .setColorBackground(color(255, 255, 255))
               .setColorForeground(color(0,0,0)).
               setColorCursor(color(0,0,0))
              ;

    cp5.addBang("add")
      .setPosition(240, 170)
        .setSize(80, 40)
          .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
            ;    

   cp5.addBang("save")
      .setPosition(340, 170)
        .setSize(80, 40)
          .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
            ;    
            
*/
    textFont(font);
  }

  public void draw() 
  {
    fill(255);
    //text(cp5.get(Textfield.class, "input").getText(), 360, 130);
    text(textValue, 360, 180);
  }

/*
  void controlEvent(ControlEvent theEvent) 
  {
    if (theEvent.isAssignableFrom(Textfield.class)) {
      println("controlEvent: accessing a string from controller '"
        +theEvent.getName()+"': "
        +theEvent.getStringValue()
        );
    }
  }
   */
  public void enteredNewStocks(String[] stocks)
  {}
  
  public void selectedStock(String stock){}
  
  public void addDelegates(List<UserInput> d)
  {
    delegates = d;
  }


}

// Control P5 Methods
// NOTE: Really hackish putting them outside the class, but there were issues trying to get cp5 lib working with a custom interface.
// Apparently these callback methods need to be in PApplet
public void input(String theText) {
  println("B");
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}

public void add() 
{
  println("B");
  String[] s = {"AAPL","GOOG"};
  //UserInput ui = new Net();
  //ui.enteredNewStocks(s);
  cp5.get(Textfield.class, "textValue").clear();
}


class Device
{
  PApplet parent;
  Serial port;
  
  Device(PApplet p)
  { 
    parent = p;
    port = new Serial(parent, Serial.list()[0], 9600); // <- Gotta pass in root
  }
  
  public void send() 
  {
     port.write("BAM! DATA! iu0921jrfeawr;kDSAK:FA");
  }
  
  public void sendStock(String name, String price) 
  {
     port.write(name + "Share Price " + price);
  }
}
class Gui
{
  // Gui static text
  public static final String GUI_TITLE = "Stock Bank";
  public static final String GUI_TITLE_STOCKNAME = "Stock Name:";  
  public static final String GUI_TITLE_BANKTOTAL = "Bank Total:";
  public static final String GUI_TITLE_STOCKTOTAL = "Current Stock Price:";  
  
  // Gui dynamic text
  String bankAmount;
  String stockAmount;
  String stockName;
 
  // Fonts
  PFont headerFont;
  PFont dataFont;
  PFont totalFont;  
  
  Controls controls;
  Gui(PApplet p, ControlP5 c, String[] stocks)
  {
    controls = new Controls(c, stocks);
    headerFont = loadFont("fonts/lateron-48.vlw");
    dataFont   = loadFont("fonts/lateron-24.vlw");
    totalFont  = loadFont("fonts/lateron-250.vlw");
    textFont(headerFont, 48);
    textFont(dataFont, 24);    
    textFont(totalFont, 250);
  }
  
  public void update()
  {
  }
  
  public void draw()
  {
      controls.draw();
       fill(0);
       textSize(48);
      textFont(headerFont, 48);         
       text(GUI_TITLE, 40, 60);
       
      textFont(totalFont, 250);
      textSize(250);
      float f = Float.parseFloat(stockAmount);
      float total = 42.12f - f;
      String t  = String.format("%.2f",total);
       text("$" + t , 40, 400);        
       
        textFont(dataFont, 24);    
       textSize(24);
       text(GUI_TITLE_STOCKNAME + " " + stockName, 40, 100);  
       text(GUI_TITLE_BANKTOTAL + " " + "$45.12" , 40, 130);
       text(GUI_TITLE_STOCKTOTAL + " $" + stockAmount, 40, 160);       
  }
  
}
class Net implements UserInput
{
  // Net static urls
  public static final String BASE_URL = "http://justinblinder.com/dev/stockbank/stocks.php?";
  public static final String BASE_PARAM_URL = "stock[]=";
  public static final String TEST_URL = "http://justinblinder.com/dev/stockbank/stocks.php?stock[]=AAPL";
  
  Net() {
  }

  public void getStockData(String data, Profile profile) {
    try {
      JSONObject jsonData = new JSONObject(data);
      JSONArray _data = jsonData.getJSONArray("stocks");
      ArrayList stocks = new ArrayList();
      for (int i =0; i < _data.length(); i++) {

        JSONObject item = _data.getJSONObject(i);
        String name = (String)item.getString("name");
        float  price = (float)item.getDouble("price");      
        Stock s = new Stock(name,price);
        stocks.add(s);
        println(name);
        println(price);
      }
      profile.stocks = stocks;
    } 
    catch (Exception e) {
    }
  }


  public String getFormattedURL(String[] params)
  {
    String url = BASE_URL;
    for (int i = 0; i < params.length; i++) {
      String _param = new String();
      if (i > 1) {
        _param += "&";
      }
      _param = BASE_PARAM_URL;
      _param += params[i];
      if ( i < params.length - 1) {
        _param += "&";
      }
      url += _param;
    }
    return url;
  }
  
  public void enteredNewStocks(String[] stocks) 
  {
    println("stocks added");
  }
  
  public void selectedStock(String stock){
    println(stock);
  }
}

class Profile
{
    ArrayList stocks;
    
    Profile()
    {
      stocks = new ArrayList();
    }
    
    
}
class Stock
{
   String name;
   float price;
   
   Stock( String name, float price)
   {
       this.name = name;
       this.price = price;
   }
}
interface UserInput
{
  public void enteredNewStocks(String[] stocks);
  public void selectedStock(String stock);
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "StockBank" });
  }
}
