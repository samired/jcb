load 'viewmat'
 
mandelbrot =. ([ + ^&2)
mandel_iter =: (|)@:(mandelbrot/\.)@:([ # ])
range =. (i.@:(1&+)@:(*&2) - ])
grid =. ({. (,"0)/ {.)@:(range "0)@:(2&#)
 
pixels =. (2&>)@:(25&mandel_iter)@:(-&0.5)@:j./@:(0.01&*) L:0 <"1 grid 100
 
viewmat > +/ L:0 pixels
