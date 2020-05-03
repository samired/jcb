NB. https://www.johndcook.com/blog/2020/04/24/envelopes-of-epicycloids/

require 'plot stats'

xs =: steps 0 6.28319 200

draw =: 4 : 'plot (cos (x*xs),.(y*xs));(sin (x*xs),.(y*xs))'

NB. Or make it monad with extra line for a & b variables

draw2 =: 3 : 0 
  'a b' =: y
  plot (cos (a*xs),.(b*xs));(sin (a*xs),.(b*xs))
)

draw3 =: 4 : 'plot (cos;sin)(x&*,.y&*) (steps 0 2p1 360)'