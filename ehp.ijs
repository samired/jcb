require 'plot web/gethttp tables/csv'
require 'alphakey'
NB. percent =: 0 61 45 0 0 25 50 0 20 0
NB. obj =: 'HWVA MFT TMDE SQP SVAC CLR DTR CRP GRIN TNA'

s =: fixcsv gethttp dquote 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=ko&apikey=MA',apikey,'&datatype=csv'
'pensize 2; color red' plot (makenum |. > }. 4{ |: s);(20 ma close)

close =: makenum |. > }. 4{ |: s

'type dot; pensize 2; color red' plot close
ma =: (+/%#)\
plot 20 ma close