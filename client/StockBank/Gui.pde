class Gui
{
  // Gui static text
  public static final String GUI_TITLE = "Stock Bank";
  public static final String GUI_TITLE_BANKTOTAL = "Bank Total:";
  public static final String GUI_TITLE_STOCKTOTAL = "Current Stock Price:";  
  
  // Gui dynamic text
  String bankAmount;
  String stockAmount;
  String stockName;
 
  // Fonts
  PFont headerFont;
  Controls controls;
  Gui(PApplet p, ControlP5 c)
  {
    controls = new Controls(c);
    //headerFont = loadFont("fonts/lateron-48.vlw");
    //textFont(headerFont, 48);
  }
  
  void update()
  {
  }
  
  void draw()
  {
      controls.draw();
       fill(0);
       textSize(20);
       text(GUI_TITLE, 40, 60);
       textSize(12);
       text(GUI_TITLE_BANKTOTAL + " " + "$45.12" , 40, 100);
       text(GUI_TITLE_STOCKTOTAL + " $" + stockAmount, 40, 120);       
  }
  
}
