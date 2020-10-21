CANVAS_DEFSIZE_jwplot_ =: 700 300
africa =: 'keystyle for; key "Daily Cases"; rulecolor white; axes 1 0; frame 0; forecolor white; gridcolor white; axiscolor white; backcolor Silver'
asia =: 'keystyle for;ytic 0.2; key "Daily Cases"; axes 0 0; frame 0; forecolor orange; gridcolor orange; axiscolor orange'
europe =: 'key Daily Cases; keystyle for; xtic 5; ytic 0.3; frame 0'

require 'tables/csv web/gethttp plot stats'

NB. Utility verbs
ma =: (+/%#)\
NB. moving average by country for 10 days of daily cases:
mac =: 3 : '10 (+/%#)\ 5 col covid  gets y' 
gets =: 4 : '(I. (<y) E. 0{|:x){x'
lreg =: 4 : 'y %. 1 ,. x'
treg =: 3 : '((1{((i.#y) lreg y))*(i.#y))+(0{((i.#y) lreg y))'
col =: 4 :  'makenum  x { |: y' NB. adjust by adding }. if header=true
columns =: 3 : '(;/ |: ,: i. #0{y) ,. (|: ,: 0{ y)'
counter =: 3 : '(~. y) ,. (;/ (#/.~ y))'
norm=: (-<./)%(>./ - <./)

covid =: readcsv 'C:/Users/e120294/OneDrive - WFT/Desktop/covid.csv' NB. fixcsv gethttp dquote 'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv'

lnt =: 4 : '|., y {. |. 4 col covid gets x'  NB. No. of Cases in last n days (y) for country (x)
lnd =: 4 : '|., y {. |. 5 col covid gets x'  NB. No. of Cases in last n days (y) for country (x)
lnx =: 4 : '|., y {. |. 11 col covid gets x' NB. No. of Cases/million in last n days (y) for country (x)
lnf =: 4 : '|., y {. |. 8 col covid gets x' NB. No. of Cases/million in last n days (y) for country (x)


report =: 3 : 0                              NB. country iso code as (y)
  last =: {. |. 5 col covid gets y 
  weekavg =: (+/%#) y lnd 7                  NB. average daily infection for week
  monthavg =: (+/%#) y lnd 30                NB. average daily infection for month
  total =: {: 4 col covid gets y             NB. returns last total infection
  cpm =:   {: 11 col covid gets y            NB. daily cases per million
  death =: {. |. 9 col covid gets y 
  
  echo '- Last Recorded Daily Infection: ',":last
  echo '- Daily Average For Last Week  : ',":weekavg
  echo '- Daily Average For Last Month : ',":monthavg
  echo '- Total Cases in Country       : ',":total
  echo '- Daily Cases per Million      : ',":cpm
  echo '- Last Recorded Daily Deaths   : ',":death
)
