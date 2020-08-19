#!/home/sam/j901/bin/jconsole

load 'tables/csv stats web/gethttp plot'
NB. apikey variable is in alphakey.ijs 
daily =: 'TIME_SERIES_DAILY'
quote =: 'GLOBAL_QUOTE'
intra =: 'TIME_SERIES_INTRADAY'    NB. not used yet
ma =: (+/%#)\

NB.======================================
NB. To get and plot intraday data 
NB. intra 'twtr' <- example
NB.======================================

intra =: 3 : 0
  d=: fixcsv gethttp dquote 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=',y,'&interval=5min&apikey=',apikey,'&datatype=csv'
  plot makenum |. 4 { |: }. d
)

NB.======================================
NB. Dyad to get either quote data or daily
NB. data for plotting, plot with dplot 
NB.======================================

data =: 4 : 0 
  fixcsv gethttp dquote 'https://www.alphavantage.co/query?function=',x,'&symbol=',y,'&apikey=',apikey,'&datatype=csv'
) 

NB.======================================
NB. dplot daily data 'amd' 
NB.======================================

dplot =: 3 : 0
  ddata =: }. y 
  dhead =: {. y 
  'ddate dclose' =: <"1 |: ddata {"1 ~ dhead i. 'timestamp';'close'NB.;'volume'
  NB.s =: 20 ma dclose

  NB.'xtic 10; pensize 2; type dot' plot stock_close  
  plot (makenum |. dclose) NB.,: ((0 ~: s)#s)
)
 

NB. ma =: +%[ 

NB. plot makenum |. 4 { |: }. data

NB. plot makenum |. 4 { |: }. intra

