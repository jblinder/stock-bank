class Net implements UserInput
{
  // Net static urls
  public static final String BASE_URL = "http://justinblinder.com/dev/stockbank/stocks.php?";
  public static final String BASE_PARAM_URL = "stock[]=";
  public static final String TEST_URL = "http://justinblinder.com/dev/stockbank/stocks.php?stock[]=AAPL";
  
  Net() {
  }

  void getStockData(String data, Profile profile) {
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


  String getFormattedURL(String[] params)
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
  
  void enteredNewStocks(String[] stocks) 
  {
    println("stocks added");
  }
  
  void selectedStock(String stock){
    println(stock);
  }
}

