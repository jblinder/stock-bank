ControlP5 cp5;
class Controls implements UserInput
{
  List<UserInput> delegates = new ArrayList<UserInput>();

  String textValue = "";
  PApplet app;

  Controls(PApplet p)
  {
    app = p;  
    setup();
  }

  void setup() 
  {
    PFont font = createFont("arial", 20);

    cp5 = new ControlP5(app);
    cp5.addTextfield("input")
      .setPosition(20, 100)
        .setSize(200, 40)
          .setFont(font)
            .setFocus(true)
              .setColor(color(255, 0, 0))
                ;
    cp5.addTextfield("textValue")
      .setPosition(20, 170)
        .setSize(200, 40)
          .setFont(createFont("arial", 20))
            .setAutoClear(false)
              ;

    cp5.addBang("clear")
      .setPosition(240, 170)
        .setSize(80, 40)
          .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
            ;    

    textFont(font);
  }

  void draw() 
  {
    fill(255);
    text(cp5.get(Textfield.class, "input").getText(), 360, 130);
    text(textValue, 360, 180);
  }


  void controlEvent(ControlEvent theEvent) 
  {
    if (theEvent.isAssignableFrom(Textfield.class)) {
      println("controlEvent: accessing a string from controller '"
        +theEvent.getName()+"': "
        +theEvent.getStringValue()
        );
    }
  }
   
  void enteredNewStocks(String[] stocks)
  {}
  
  void addDelegates(List<UserInput> d)
  {
    delegates = d;
  }
}

// CP5 methos
// I know, bad java. Issues trying to get cp5 lib working with a custom interface.
public void input(String theText) {
  println("B");
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}

public void clear() 
{
  println("B");
  String[] s = {"AAPL","GOOG"};
  UserInput ui = new Net();
  ui.enteredNewStocks(s);
  cp5.get(Textfield.class, "textValue").clear();
}

