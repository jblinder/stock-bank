StockBank
=========
___
![xkcd](http://imgs.xkcd.com/comics/investing.png)
####notes
**client** - interface, arduino communciation, stock presentation [*processing*]

**server** - stock grabbing [*php*]

**libs** - dependencies (install these in your processing libraries folder) [*processing*]

--
####[notes to self]


**client**: GUI, Arduino communication.

**server**: Script aggraigates server data, possible caching.


Spec:
- grabs stock data.
- keeps track of the current piggy bank amount.
- passes LCD stock prices data.
- calculates the progress towards a stock purchase (**stock price - piggy bank amount = progress**, *check intermittently or whenever money is dropped into bank*).
- GUI that shows progress (fall bac for LCD).