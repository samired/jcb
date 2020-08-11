NB. init

require 'convert/pjson'

coclass 'qtwebview'
coinsert 'ptab psym pjson'

Page=: jpath '~addons/demos/wd/webview/index.html'
Pindex=: 0
NB. util

vex=: 1.0005         NB. average volume growth per day

int01=: i.@>: % ]
limit=: <. >. [: - [
linesert=: 2&$: :([: +/\ {.@] , [ # (}. - }:)@] % [)
normalrand=: 3 : '(2 o. +: o. rand01 y) * %: - +: ^. rand01 y'
rand01=: ?@$ 0:
round=: [ * [: <. 0.5 + %~
roundint=: <.@:+&0.5
tolist=: }. @ ; @: (LF&, @ , @ ": each)
xrnd=: 4 : '^ x * 2 limit normalrand y'

NB. =========================================================
NB. constrained random walk
NB. a max movement per step
NB. b max movement at any time (above/below)
NB. c number of steps
cgen=: 3 : 0
'a b c'=. y
m=. %b
while. 1 do.
  p=. */\ 1 + a * normalrand c
  if. -. 1 e. (m>p) +. b<p do. return. end.
end.
)

NB. =========================================================
choleski=: 3 : 0
mp=. +/ .*
n=. #a=. y
if. 1>:n do.
  13!:8(,(a=|a)>0=a)}.12
  %:a
else.
  p=. >.n%2 [ q=. <.n%2
  x=. (p,p){.a [ y=. (p,-q){.a [ z=. (-q,q){.a
  l0=. choleski x
  l1=. choleski z-(t=. (+|: y) mp %.x) mp y
  l0,(t mp l0),.l1
end.
)

NB. =========================================================
NB. paired correlation, matrix of variates, min 0.1 coeff
choleskicor=: 3 : 0
'ccf dat'=. y
n=. #dat
c=. 0.1 >. (n,n)$1,ccf,((n-2)#0),ccf
(choleski c) +/ .* dat
)

NB. =========================================================
NB. J day number to javascript date
daynoj2js=: 86400000 * -&62091

NB. =========================================================
NB. get week dates
getweekdates=: 3 : 0
'b e'=. y
d=. b + i. 1 + e-b
d #~ -. (7 | 3 + d) e. 0 6
)

NB. =========================================================
jsbracket=: 3 : 0
if. L.y do.
  '[',']',~}.;',' ,each y
else.
  if. 8=3!:0 y do.
    y=. 0.001 round y
  end.
  d=. ": y
  d=. '-' (I. d='_')} d
  d=. ',' (I. d=' ')} d
  '[',d,']'
end.
)

NB. =========================================================
makevolumes=: 3 : 0
'size count'=. y
v=. cgen 0.03 3,count
a=. vex ^ -count
roundint (size + ? count#<.size*0.7) * 0.5 >. 2 <. v*a+((%{:v)-a) * int01 count-1
)

NB. =========================================================
show_webview_events=: 3 : 0
n=. {."1 wdq
v=. {:"1 wdq
if. -. (,'w') -: (n i. <'syschild') pick v do. return. end.
m=. (n e. ;:'sysevent') +. (<'w_') = 2 {.each n
smoutput m#wdq
)

NB. =========================================================
NB. volume profile - random times, weighted toward ends
NB. y=# of buckets, total count
volprof=: 3 : 0
'buckets count'=. y
p=. 1.75
c=. <. count%3
b=. (?c$0) ^ p
e=. 2-(?c$0) ^ p
m=. ?(count-2*c)$0
sort m,0.5*b,e
+/"1 (i.buckets) =/<.buckets * m,0.5*b,e
)

NB. =========================================================
volprof1=: 3 : 0
count=. y
p=. 1.75
c=. <. count%3
b=. (?c$0) ^ p
e=. 2-(?c$0) ^ p
m=. ?(count-2*c)$0
m,0.5*b,e
)

NB. =========================================================
wdhandler_debug_z_=: show_webview_events_qtwebview_
NB. price

PriceInit=: 0

NB. =========================================================
PriceDef=: 0 : 0
type='price'
label='close'
datefmt='%d %b'
key=['AAPL','GOOG','MSFT']
)

NB. =========================================================
run_price=: 3 : 0
if. -. PriceInit do.
  9!:1[235741
  PriceInit=: 1
end.
sym=. ;: 'APPL GOOG MSFT'
bgn=. (todayno 2015 1 1) + ?180
end=. bgn + 31
ccf=. 0.5            NB. correlation coefficient
prc=. 30 + 3?70
cnt=. #sym
dates=. getweekdates bgn,end
prices=. makeprices ccf;cnt;dates;prc
r=. PriceDef
r=. r,'daty=',jsbracket jsbracket each ;/prices
r=. r,LF,'datv=',jsbracket makevolumes 150000,#dates
r=. r,LF,'dates=',jsbracket daynoj2js dates
r,LF
)

NB. =========================================================
makeprices=: 3 : 0
'ccf cnt dates prc'=. y
p=. 1,.cgen @ (0.0375 3&,) &> cnt##dates
p=. choleskicor ccf;p
(prc % {."1 p) * p *"1 [ 1.1 ^ int01 #dates
)
NB. scatterplot data

SPinit=: 0

NB. =========================================================
SPdefs=: 0 : 0
Beijing,China,12.5,2
Berlin,Germany,3.6,3
Chicago,USA,9.5,0
Hamburg,Germany,1.8,3
Hong Kong,China,7.2,2
Houston,USA,2.1,0
Kyoto,Japan,1.5,2
London,England,8.7,3
Milan,Italy,1.3,3
Munich,Germany,1.4,3
New York,USA,8.2,0
Osaka,Japan,2.7,2
Paris,France,2.2,3
Rome,Italy,2.9,3
Salvador,Brazil,2.9,1
Sao Paolo,Brazil,11.9,1
Tokyo,Japan,9,2
Shanghai,China,16.6,2
Toronto,Canada,5.6,0
)

NB. =========================================================
make_scatter=: 3 : 0
dat=. _4[\','cutopen SPdefs rplc LF,','
if. SPinit do.
 dat=. dat #~ 0<?(#dat)#8
end.
SPinit=: 1
dat=. <"1 |: dat
SPlen=: # 0 pick dat
dat=. (0 ". &> each 2 3{dat) 2 3} dat
dat=. dat,<'Show All';sort ~.1 pick dat
dat=. dat,<'North America';'South America';'Asia';'Europe'
nms=. ;: 'city country population continent nubcountry continents'
SPdata=: tolist nms ,each ('=' , enc) each dat
EMPTY
)

NB. =========================================================
run_scatter=: 3 : 0
make_scatter ''
xmax=. 50 + 10 * ?4
ymax=. 100
xval=. 1 + ?SPlen#xmax-1
yval=. 1 + ?SPlen#ymax-1
nms=. ;:'xmax ymax xval yval'
dat=. tolist nms ,each ('=' , enc) each xmax;ymax;xval;yval
SPdata,LF,dat
)
NB. win

NB. =========================================================
webview=: 3 : 0
wd 'pc webview closeok escclose;pn Intro'
wd 'bin hvp8'
wd 'cc intro button;cn Intro'
wd 'cc comms button;cn Comms'
wd 'cc plot button;cn Plot'
wd 'cc report button;cn Report'
wd 'cc web button;cn Web'
wd 'bin s'
wd 'cc reload button;cn Reload'
wd 'bin p8zv1'
wd 'cc w webview'
wd 'bin zz'
wd 'pmove _1 _1 1000 700'
wd 'pshow hide'
webview_load''
)

NB. =========================================================
webview_w_post=: 3 : 0
select. w_name
case. 'init' do.
  webview_show ''
  wd 'pshow'
case. 'd3plot' do.
  wd 'cmd w call d3plot *',('run_',w_value)~0
case. 'error' do.
  echo w_name,' ',w_value
case. 'name';'return' do.
case. do.
  fn=. 'run_',w_name
  wd 'cmd w call report *',fn~w_value
end.
)

NB. =========================================================
webview_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
webview_load=: 3 : 0
wd 'set w url *file://',('/' #~ '/'~:{.Page),Page
)

NB. =========================================================
webview_intro_button=: webview_show bind 0
webview_comms_button=: webview_show bind 1
webview_plot_button=: webview_show bind 2
webview_report_button=: webview_show bind 3
webview_web_button=: webview_show bind 4
webview_reload_button=: webview_load

NB. =========================================================
webview_show=: 3 : 0
wd 'cmd w call initpage ',":Pindex=: {.y,Pindex
wd 'pn ',Pindex pick ;:'Intro Comms Plot Report Web'
)

coclass 'qtwebview'

Axis=: Cube=: Order=: Piv=: Table=: $0

Format=: 'table'
NB. util

cutparts=: <;.1~ 1 , }. ~: }:
joins=: ,.@>@(,.&.>/)
rand=: ?@$
rand01=: rand 0:
normalrand=: 3 : '(2 o. +: o. rand01 y) * %: - +: ^. rand01 y'
gen=: [: ^ 0.3 * normalrand

td=: '<td>' , ,&'</td>'
tda=: '<td class="tdalt">' , ,&'</td>'
th=: '<th>' , ,&'</th>'
tr=: '<tr>' , ,&'</tr>'

NB. =========================================================
NB. <th> with colspan
thcolspan=: 4 : 0
if. x=1 do.
  '<th>', y, '</th>'
else.
  '<th colspan=',(":x),'>',y,'</th>'
end.
)

NB. =========================================================
NB. <th> with rowspan
throwspan=: 4 : 0
if. x=1 do.
  <'<th>', y, '</th>'
else.
  ('<th rowspan=',(":x),'>',y,'</th>');(x-1)$<''
end.
)
NB. html

NB. =========================================================
chartnms=: 3 : '}. ; ''.'' ,each y'

NB. =========================================================
tab2chart=: 3 : 0
'cls typ dat'=. y

nmx=. cls i. 0 pick Table
rwx=. nmx {~ ,0 pick Order
clx=. nmx {~ ,1 pick Order

nms=. 0 pick Axis
rnms=. rwx{cls
cnms=. clx{cls

rows=. joins rwx{dat
cols=. joins clx{dat

crws=. #nrws=. ~.rows
ccls=. #ncls=. ~.cols
ndx=. (rows,.cols) i. (ccls#nrws),.(crws*ccls)$ncls

ndat=. ndx { (_1 pick dat),0

lab=. }.each <@;"1 '.',each fromsym nrws
hdr=. }.each <@;"1 '.',each fromsym ncls
tit=. 'sum(values) of ',(chartnms cnms),' by ',chartnms rnms

tit;lab;hdr;ndat
)

NB. =========================================================
tab2html1=: 3 : 0
'rows cols data'=. y

rws=. #rows
cls=. #cols

'wid lab'=. lab2html rows
hdr=. wid hdr2html cols
dat=. (rws,cls)$data

ndx=. I. rws$1 0
dat=. (td each ndx{dat) ndx} dat
ndx=. I. rws$0 1
dat=. (tda each ndx{dat) ndx} dat

bdy=. ;<@tr@;"1 lab,.dat
'<table id="cube1" class="cube"><thead>',hdr,'</thead><tbody>',bdy,'</tbody></table>'
)
NB. cube data

NB. =========================================================
FPlaces=: ':' ,each cutopen 0 : 0
southeast:AL
midwest:AK
southwest:AZ
southeast:AR
west:CA
west:CO
northeast:CT
northeast:DE
southeast:FL
southeast:GA
west:HI
west:ID
midwest:IL
midwest:IN
midwest:IA
midwest:KS
midwest:KY
southwest:LA
northeast:ME
northeast:MD
northeast:MA
midwest:MI
midwest:MN
southwest:MS
midwest:MO
northeast:MT
northeast:NE
west:NV
northeast:NH
northeast:NJ
southwest:NM
northeast:NY
southeast:NC
midwest:ND
midwest:OH
southwest:OK
west:OR
northeast:PA
northeast:RI
southeast:SC
midwest:SD
southeast:TN
southwest:TX
west:UT
northeast:VT
southeast:VA
west:WA
southeast:WV
midwest:WI
west:WY
)

NB. =========================================================
makecubedefs=: 3 : 0
Sym=: ''
Cls=: ;:'perspective company division region state line year quarter'
a1=. ;: 'net ceded'
n1=. 4 1
a2=. ;: 'alpha beta gamma delta epsilon'
n2=. 2 1 4 3 3
a3=. ('div_' , ":) each 1 + i. 6
n3=. 1+?~#a3
a4=. FPlaces
n4=. 1+5|?~#a4
a5=. sort <;._1 '|home owners|flood|health|pers auto|comm auto|comm prop|malpractice|travel|umbrella'
n5=. 1+4|?~#a5
a6=. '2015';'2016';'2017'
n6=. 1 1.05 1.11
a7=. ;: 'q1 q2 q3 q4'
n7=. 1 1.01 1.02 1.03
ndx=. 3
piv=. >,{a1;a2;a3;a4;a5;a6;<a7
piv=. (ndx {."1 piv),.(<;._1 &> ndx {"1 piv),.(ndx+1) }."1 piv
Sym=: ~. (;:'gross net ceded'),a2,sort ~.,piv
typ=. (#Cls)#iSym
Piv=: Cls;typ;<<"1 |: tosym piv
Num=: */"1 >,{n1;n2;n3;n4;n5;n6;n7
pns=. ~. each <"1 |: piv
Lab=: ('gross';0 pick pns);}.pns
EMPTY
)

NB. =========================================================
makecube=: 3 : 0
if. 0=#Piv do.
  makecubedefs''
end.
'cls typ dat'=. Piv
val=. <. 20 * Num * gen #Num

NB. add gross:
len=. <.-:#Num
g=. +/ (-len) [\ val
val=. (g),val
grs=. (len#tosym 'gross');len {. each }.dat
dat=. grs ,each dat
tab=. (cls,<'value');(typ,iInt);<dat,<val

len=. tabsize tab
msk=. 82 > ?len$99
tab=. tabindex tab;I.msk
Table=: tabmove tab;<;:'company division region state line'

ndx=. Cls i. cls=. }: 0 pick Table
Axis=: cls;<ndx{Lab
Order=: ,each 0 5;2 6;1 3 4 7;<,each _1;_1;_1;_1;_1;_1;1 2;_1

EMPTY
)
NB. header

NB. =========================================================
NB. format headers
hdr2html=: 4 : 0
if. 0 e. $y do. '' return. end.

dat=. |: y
cnt=. #dat

pfx=. x thcolspan ''

r=. ''
for_i. i.cnt-1 do.
  p=. cutparts i{dat
  n=. # &> p
  s=. fromsym {.each p
  r=. r,<;n thcolspan each s
end.

r=. r,<;th each fromsym {:dat
r=. (<pfx) ,each r
;tr each r
)
NB. html

NB. =========================================================
tab2html=: 3 : 0
'cls typ dat'=. y
nmx=. cls i. 0 pick Table

rows=. joins (nmx {~ ,0 pick Order) { dat
cols=. joins (nmx {~ ,1 pick Order) { dat

crws=. #nrws=. ~.rows
ccls=. #ncls=. ~.cols
ndx=. (rows,.cols) i. (ccls#nrws),.(crws*ccls)$ncls

data=. 'c13.0' (8!:0) _1 pick dat
ndat=. ndx { data,<''

tab2html1 nrws;ncls;<ndat
)

NB. =========================================================
tab2html1=: 3 : 0
'rows cols data'=. y

rws=. #rows
cls=. #cols

'wid lab'=. lab2html rows
hdr=. wid hdr2html cols
dat=. (rws,cls)$data

ndx=. I. rws$1 0
dat=. (td each ndx{dat) ndx} dat
ndx=. I. rws$0 1
dat=. (tda each ndx{dat) ndx} dat

bdy=. ;<@tr@;"1 lab,.dat
'<table id="cube1" class="cube"><thead>',hdr,'</thead><tbody>',bdy,'</tbody></table>'
)
NB. label

NB. =========================================================
NB. format labels
lab2html=: 3 : 0
if. 0 e. $y do. 0;'' return. end.

dat=. |: y
cnt=. #dat

rws=. th each fromsym {: dat

for_i. i. 1-cnt do.
  p=. cutparts i{dat
  n=. # &> p
  s=. fromsym {.each p
  rws=. (;n throwspan each s),.rws
end.

cnt;<rws
)
NB. main

NB. =========================================================
NB. this defines the data, and if necessary the initial order
makereport=: 3 : 0
makecube''
reportorder''
)

NB. =========================================================
axis_report=: 3 : 0
a=. 'names';<0 pick Axis
b=. 'labels';<1 pick Axis
c=. 'order';<Order
'Axis=',enc_dict a,b,:c
)

NB. =========================================================
order_report=: 3 : 0
'Axis.order=',enc Order
)

NB. =========================================================
NB. run report to initialize system
run_report=: 3 : 0
makecube''
(axis_report''),LF,reportformat reportorder''
)

NB. =========================================================
run_newdata=: 3 : 0
order=. Order
Piv=: ''
makecube''
run_setorder enc order
)

NB. =========================================================
NB. argument in json
run_setformat=: 3 : 0
old=. Format
Format=: y
if. (old-:'table') = Format-:'table' do.
  'Cube.format="',Format,'"'
else.
  reportformat reportorder''
end.
)

NB. =========================================================
NB. argument in json
run_setorder=: 3 : 0
Order=: dec y
r=. 'Axis.order=',enc Order
r,LF,reportformat reportorder''
)

NB. =========================================================
reportformat=: 3 : 0
a=. 'type';'dummy'
b=. 'format';Format
if. Format -: 'table' do.
  c=. 'html';tab2html y
else.
  c=. 'chart';<tab2chart y
end.
'Cube=',enc_dict a,b,:c
)
NB. order

NB. =========================================================
NB. return report data in order
reportorder=: 3 : 0

'nms lab'=. Axis
'rows cols pages select'=. Order
tab=. Table
'cls typ dat'=. tab

NB. subset selections:
ndx=. I. -. _1 e.&> select
if. #ndx do.
  tab=. tabwhere tab;<,(ndx{cls),.(ndx{select) {each ndx{lab
end.

NB. subtotal pages:
if. #pages do.

NB. for perspective, gross=total
  if. (<'perspective') e. pages{cls do.
    psp=. tabget1 tab;<'perspective'
    if. (tosym 'gross') e. psp do.
      tab=. tabindex tab;I. psp=tosym 'gross'
    end.
  end.
  tab=. tabremove tab;<pages{cls
  tab=. tabkeysum tab;<(rows,cols){cls
end.

NB. sort pages:
tabindex tab;/: joins }:2 pick tab
)
cocurrent 'ptab'
col=: ,.@:>each :($:@([ {.each ]))
commasep=: }.@;@:((',' , ":)each)
isboxed=: 0 < L.
ischar=: 2=3!:0
isnum=: 3!:0 e. 1 4 8"_
joins=: >@(,.&.>/)
remsep=: }.~ '/' -@= {:

sfe=: 6!:16
efs=: 6!:17
fmtdp=: 4 : 0
if. 8 ~: 3!:0 y do. y return. end.
d=. 10 ^ x
'a b'=. |: 0 1 #: ,y
":,.a + (<.0.5+b*d) % d
)
date2num=: 3 : 0
efs y
)
num2date=: 3 : 0
'  d' sfe y
)
num2datetime=: 3 : 0
'  0' sfe y
)
num2datetimem=: 3 : 0
'.  3' sfe y
)
num2datetimen=: 3 : 0
'.  9' sfe y
)
boxgrade=: /:@|:@:((i.~ { /:@/:)&>)
boxindexof=: i.&>~@[ i.&|: i.&>
boxmember=: i.&>~ e.&|: i.&>~@]
boxnubsieve=: ~:@|:@:(i.&>~)
boxnubsiever=: ~:&.|.@|:@(i.&>~)
boxexcept=: <@:-.@boxmember #each [
boxsort=: <@boxgrade {each ]
boxunique=: <@boxnubsieve #each ]
boxdupsieve=: boxmember <@:-.@boxnubsieve #each ]
boxdups=: <@boxdupsieve #each ]
boxnubcount=: 3 : 0
a=. |: i.&>~ y
c=. #/.~ a
r=. (<"1 |:~.a) {each y
(\:c)&{ each r,<c
)
tabextend=: 3 : 0
'tab new'=. y
'c1 t1 v1'=. tab
'c2 t2 v2'=. new
if. -. isnum t2 do. t2=. typenum t2 end.
(c1,boxxopen c2);(t1,t2);<v1,t2 fixcols boxxopen v2
)
tabmove=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
n=. cls i. boxxopen col
(n, (i.#cls) -. n)&{ each tab
)
tabremove=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
tab #~ each <-. cls e. boxxopen col
)
tabrename=: 3 : 0
'tab col'=. y
cls=. 0 pick tab
cls=. (#cls) {. col,(#col) }. cls
(<cls) 0} tab
)
tabselect=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
(cls i. boxxopen col)&{ each tab
)
fixcols=: 4 : 0
r=. y
m=. isnum &> r
n=. I.m < x = iSym
r=. (tosym each n{r) n} r
n=. I.m < x >: iTime
r=. (time2num each n{r) n} r
n=. I.m < x >: iDate
r=. (date2num each n{r) n} r
n=. I. -.isnum &> r
r=. ((0 ". >) each n{r) n} r
)
fixval=: 4 : 0
if. isnum y do. y return. end.
v=. boxxopen y
if. x = iSym do. tosym v return. end.
if. x >: iTime do. time2num v return. end.
if. x >: iDate do. date2num v return. end.
0 ". &> v
)
fmtbase=: 4 : 0
m=. isnum &> y
if. 0 e. m do.
  ((m#x) fmtbase1 m#y) (I.m)} y
else.
  x fmtbase1 y
end.
)
fmtbase1=: 4 : 0
r=. y
n=. I.x = iSym
r=. (fromsym each n{r) n} r
if. -. 1 e. x >: iDate do. return. end.
n=. I.x = iDate
r=. (num2date each n{r) n} r
n=. I.x = iDatetime
r=. (num2datetime each n{r) n} r
n=. I.x = iDatetimem
r=. (num2datetimem each n{r) n} r
n=. I.x = iDatetimen
r=. (num2datetimen each n{r) n} r
n=. I.x = iTime
r=. (num2time each n{r) n} r
n=. I.x = iTimem
r=. (num2timem each n{r) n} r
n=. I.x = iTimen
r=. (num2timen each n{r) n} r
)
fmthead=: 4 : 0
r=. x fmtbase y
n=. I.x e. iInt,iFloat
r=. (,. each n{r) n} r
n=. I. x = iSym
r=. (> each n{r) n} r
)
fmtlist=: 4 : 0
r=. x fmtbase y
n=. I.x >: iDate
r=. (<"1 each n{r) n}r
)
fmtsym=: 4 : 0
ndx=. I. x=iSym
(fromsym each ndx{y) ndx} y
)
doget=: 4 : 0
if. 3=#y do.
  'tab col whr'=. y
  'cls typ dat'=. tab
  if. isnum whr do.
    dat=. whr&{ each dat
  else.
    while. #whr do.
      ndx=. cls i. {. whr
      ind=. I.(ndx pick dat) e. (ndx{typ) fixval 1 pick whr
      dat=. ind&{ each dat
      whr=. 2 }. whr
    end.
  end.
else.
  'tab col'=. y
  'cls typ dat'=. tab
end.
ndx=. cls i. boxxopen col
dat=. ndx{dat
if. x do. (ndx{typ) fmtlist dat end.
)
tabcols=: 3 : '0 pick y'
tabrange=: 3 : 0
'cls typ dat'=. y
dat=. ~. each dat
ndx=. I.typ = iSym
dat=. ((/:fromsym) each ndx{dat) ndx} dat
ndx=. I.typ ~: iSym
dat=. (/:~ each ndx{dat) ndx} dat
cls;typ;<dat
)
tabsize=: 3 : 0
# (2;0) {:: y
)
tabkey=: 1 : 0
'tab key'=. y
'cls typ dat'=. tab
kdx=. cls i. boxxopen key
vdx=. (i.#cls) -. kdx
cls=. (kdx,vdx) { cls
typ=. (kdx,vdx) { typ
kes=. joins kdx { dat
dat=. kes & (u /.) each vdx{dat
res=. (<"1 |: ~.kes), dat
cls;typ;<res
)

tabkeysum=: +/ tabkey
tablj=: 3 : 0
'tab1 tab2 cls'=. y
key1=. tabget tab1;cls
key2=. tabget tab2;cls
ndx=. key2 boxindexof key1
add=. tabremove tab2;cls
tab1 tabstitch tabindex add;ndx
)
tabappend=: 3 : 0
'tab dat'=. y
(<(2 pick tab) ,each dat) 2} tab
)
tabcat=: 4 : 0
'c1 t1 d1'=. x
'c2 t2 d2'=. y
if. -. c1 -: c2 do.
  'c2 t2 d2'=. tabmove y;<c1
  assert. t1 -: t2
end.
c1;t1;<d1 ,each d2
)
tabget=: 3 : '0 doget y'
tabgets=: 3 : '1 doget y'
tabget1=: 3 : '0 pick 0 doget y'
tabgets1=: 3 : '0 pick 1 doget y'
tabindex=: 3 : 0
'tab ndx'=. y
(< ndx&{ each 2 pick tab) 2} tab
)
tabput=: 4 : 0
'tab col'=. y
'cls typ dat'=. tab
ndx=. cls i. boxxopen col
new=. boxxopen x
if. (1=#ndx) *. 1<#new do. new=. <new end.
cls;typ;<new ndx} dat
)
tabsort=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
ndx=. cls i. boxxopen col
typ=. ndx { typ
dat=. ndx { dat
ind=. I.typ = iSym
dat=. (fromsym each ind{dat) ind} dat
tabindex tab;boxgrade dat
)
tabstitch=: 4 : 'x ,each y'
tabunique=: 3 : 0
(2{.y),<boxunique>{:y
)
tabwhere=: 3 : 0
'tab whr'=. y
'cls typ dat'=. tab
if. isnum whr do.
  dat=. whr&{ each dat
else.
  while. #whr do.
    ndx=. cls i. {. whr
    ind=. I.(ndx pick dat) e. (ndx{typ) fixval 1 pick whr
    dat=. ind&{ each dat
    whr=. 2 }. whr
  end.
end.
cls;typ;<dat
)
tabhead=: 3 : 0
10 tabhead y
:
'cls typ dat'=. y
if. 0=#cls do. EMPTY return. end.
if. x~:0 do.
  n=. (*x) * (|x) <. # &> dat
  dat=. n {.each dat
end.
cls,:typ fmthead dat
)
tabrand=: 3 : 0
10 tabrand y
:
'cls typ dat'=. y
if. 0=#cls do. EMPTY return. end.
if. x~:0 do.
  p=. <./ # &> dat
  n=. sort (x <. p) ? p
  dat=. n&{ each dat
end.
cls,:typ fmthead dat
)
tabread=: 3 : 0
'cls typ dat'=. y
cls;<typ fmtlist dat
)
tabreads=: 3 : 0
'cls typ dat'=. y
if. 0=#cls do. EMPTY return. end.
cls,:typ fmthead dat
)
tabreadcsv=: 3 : 0
'cls typ dat'=. y
hdr=. }.;',' ,each cls
dat=. typ fmtlist dat
ndx=. I. typ e. iInt,iFloat
dat=. (8!:0 each ndx{dat) ndx} dat
ndx=. I. -. typ e. iInt,iFloat
qot=. '"' &, @ (,&'"')
dat=. (qot each each ndx{dat) ndx} dat
dat=. <@}.@; "1 ',' ,each |: >dat
hdr,LF,;dat ,each LF
)
tabreadtext=: 3 : 0
_1 tabreadtext y
:
dat=. 0 tabhead y
hdr=. {.dat
dat=. {:dat
ndx=. I. (x>:0) *. 8=3!:0 each dat
if. #ndx do.
  dat=. (x fmtdp each ndx{dat) ndx} dat
end.
dat=. hdr ,each ":each dat
sep=. LF,~(<:#dat)#' '
LF dtbs ,joins dat ,. each sep
)
tabtail=: 3 : 0
10 tabtail y
:
(-x) tabhead y
)
j=. cutopen 0 : 0
1 bool 1          # 0 1 0
2 int 8           # 2 3 5
3 float 8         # 3.123
4 sym 8           # 'hello'
11 date 8         # 2019-08-14
12 datetime 8     # 2019-08-14T15:07:34
13 datetimem 8    # 2019-08-14T15:07:34.925
14 datetimen 8    # 2019-08-14T15:07:34.925902831
15 time 8         # 15:07:34
16 timem 8        # 15:07:34.925
17 timen 8        # 15:07:34.925902831
)

j=. cutopen@deb@({.~i.&'#') &> j
Typenum=: 0 ". &> 0 {"1 j
Types=: 1 {"1 j
Typesizes=: 0 ". &> 2 {"1 j
typenum=: 3 : 'Typenum {~ Types i. boxxopen y'
definetypes=: 3 : 0
('i' ,each (toupper@{.,}.) each Types_ptab_)=: Typenum_ptab_
)

definetypes''

coclass 'psym'
3 : 0 ''
if. 0 ~: 4!:0 <'Sym' do.
  Sym=: fileSym=: ''
  locSym=: <'psym'
end.
EMPTY
)
create=: initsym
destroy=: codestroy
isnum=: 3!:0 e. 1 4 8"_
fromsym=: 3 : 'y { Sym'
initsym=: 3 : 0
fileSym=: y
d=. fread fileSym
if. -. _1 -: d do.
  Sym=: <;._2 d
else.
  Sym=: ''
end.
locSym=: coname''
)
setfile=: 3 : 0
fileSym=: y
writesym''
)
tosym=: 3 : 0
if. isnum y do. y return. end.
nms=. , each boxopen y
ndx=. Sym i. nms
if. 1 e. b=. ,ndx=#Sym do.
  Sym__locSym=: Sym, ~.b#,nms
  writesym''
  Sym i. nms
end.
)
tosymx=: 3 : 0
if. isnum y do. y return. end.
Sym i. , each boxopen y
)
writesym=: 3 : 0
if. #fileSym do.
  (; Sym ,each {.a.) fwrite fileSym
end.
EMPTY
)
fromsym_z_=: fromsym_psym_
tosym_z_=: tosym_psym_
tosymx_z_=: tosymx_psym_

webview_qtwebview_ 0