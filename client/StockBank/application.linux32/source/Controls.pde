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

  void setup() 
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

  void draw() 
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
  void enteredNewStocks(String[] stocks)
  {}
  
  void selectedStock(String stock){}
  
  void addDelegates(List<UserInput> d)
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


