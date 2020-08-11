NB. COVID-19 Data Filtering by Contryand Ploting "
NB. Required library scripts\n",
require 'tables/csv'
require 'web/gethttp'
require 'graphics/plot'

NB. Utility verbs
gets =: 4 : '(I. (<y) E. 0{|:x){x'
getm =: 4 : '(I. (<y) E. 4{|:x){x'
vfmx =: 3 : '}:(,|.\"1 [ 1,.-. *./\\\"1 |.\"1 y='' '')#,y,.LF'
lreg =: 4 : 'y %. 1 ,. x'
treg =: 3 : '((1{((i.#y) lreg y))*(i.#y))+(0{((i.#y) lreg y))'
col =: dyad : 'makenum }. x {\"1 y'
columns =: monad : '(;/ |: ,: i. #0{y) ,. (|: ,: 0{ y)'
counter =: monad : '(~. y) ,. (;/ (#/.~ y))'

covid =: fixcsv gethttp dquote 'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv'
plot (5 col 90 }. covid gets 'EGY') NB. ,: (5 col 90 }. covid gets 'KWT')
cov=: 5 col (183 }. covid gets 'EGY')
reg =: treg cov
plot cov,:reg 
