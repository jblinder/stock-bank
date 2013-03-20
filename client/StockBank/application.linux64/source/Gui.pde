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
  
  // Testing
  boolean buyStock = false;
  
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
  
  void update()
  {
  }
  
  void buyStock(boolean b)
  {
    buyStock = b;
  }
  
  void draw()
  {
      controls.draw();
       fill(0);
       textSize(48);
      textFont(headerFont, 48);         
       text(GUI_TITLE, 40, 60);
       
        
      float f = Float.parseFloat(stockAmount);
      float total = f- 42.12;
      if (buyStock) total = 0;      
      String t  = String.format("%.2f",total);
               textFont(totalFont, 250);
      textSize(250);
       text("$" + t , 40, 400);
       
        textFont(dataFont, 24);    
       textSize(24);
       text(GUI_TITLE_STOCKNAME + " " + stockName, 40, 100);  
       text(GUI_TITLE_BANKTOTAL + " " + "$45.12" , 40, 130);
       text(GUI_TITLE_STOCKTOTAL + " $" + stockAmount, 40, 160);       
       if ( buyStock ) {
      
         noStroke();
         fill(255,71,71,240);
         rect(20,200,740,250);
         fill(255);
       textSize(80);         
         text("Purchased Stock!", 200, 340);                
       }
  }
  
}
