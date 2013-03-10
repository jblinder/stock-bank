<?php 

	function request($symbol,$stat)
	{
		$separator = ',';
		$local = 'download';
		$file = 'http://'.$local.'.finance.yahoo.com/d/quotes.csv?s='.$symbol.'&f='.$stat.'=.csv';
		$handle = fopen($file, "r");
		$data = fgetcsv($handle, 4096, $separator);
		fclose($handle);
		return $data;		
	}

	function getAllData($symbol)
	{
		$data = request($symbol, 'l1c1va2xj1b4j4dyekjm3m4rr5p5p6s7');
		$allData = array(	'price'=>$data[0],
    					 	'change'=>$data[1],
    					 	'volume'=>$data[2],
    						'avg_daily_volume'=>$data[3],
    						'stock_exchange'=>$data[4],
    						'market_cap'=>$data[5],
    						'book_value'=>$data[6],
    						'ebitda'=>$data[7],
    						'dividend_per_share'=>$data[8],
    						'dividend_yield'=>$data[9],
    						'earnings_per_share'=>$data[10],
    						'fiftytwo_week_high'=>$data[11],
    						'fiftytwo_week_low'=>$data[12],
    						'fiftyday_moving_avg'=>$data[13],
    						'twohundredday_moving_avg'=>$data[14],
    						'price_earnings_ratio'=>$data[15],
    						'price_earnings_growth_ratio'=>$data[16],
    						'price_sales_ratio'=>$data[17],
    						'price_book_ratio'=>$data[18],
    						'short_ratio'=>$data[19],);
		return $allData;
	}
	
	function getPrice($symbol)
	{
		$tmpArr =  request($symbol, 'l1');
		$price = $tmpArr[0];
		return $price;
		
	}

	$arr = array();
	foreach ( $_GET["stock"] as $param ) {
		$price = getPrice($param);
		
		$a = array($param => $price);
		array_push($arr, $a);
	}
	
	$json = json_encode($arr);
	print $json;
	
?> 