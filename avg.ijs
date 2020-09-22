NB. Moving Average
ma =: (+/%#)\

NB. Harmonic Average
harmonic =: #%(+/@:%)
harmonic2 =: 3 : '(# y) % (+/ % y)'

NB. Normalization
norm=: (-<./)%(>./ - <./)
norm2=: 3 : '(y -(min y)) %((max y)-(min y))'
