NB. Moving Average
ma =: (+/%#)\

NB. Harmonic Average
harmonic =: #%(+/@:%)
harmonic2 =: 3 : '(# y) % (+/ % y)'

NB. Normalization
norm=: (-<./)%(>./ - <./)
norm2=: 3 : '(y -(min y)) %((max y)-(min y))'
lreg =: 4 : 'y %. 1 ,. x'
treg =: 3 : '((1{((i.#y) lreg y))*(i.#y))+(0{((i.#y) lreg y))'
col =: 4 :  'makenum  x { |: y' NB. adjust by adding }. if header=true
columns =: 3 : '(;/ |: ,: i. #0{y) ,. (|: ,: 0{ y)'
counter =: 3 : '(~. y) ,. (;/ (#/.~ y))'
