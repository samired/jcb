load 'jzplot tables/csv viewmat stats'
load 'plot'

0:0
This is a way
to make a multi-
line comment
)

ts =: 6!:2 , 7!:2@]
fibonacci=:1:`(fibonacci@-&2+fibonacci@<:)@.(>&2)
quicksort=: (($:@(<#[), (=#[), $:@(>#[)) ({~ ?@#)) ^: (1<#)
factorial =: 1: ` (* $: @ <:) @. *
NB.------------------------------------------------
NB. Euler 001: 3+5 multiplies below 1000
NB.------------------------

NB. add the sum of two arithmetic series and subtract the sum of a third.
NB. 3 * (333 * 334) / 2 + 5 * (199 * 200) / 2 - 15 * (66 * 67) /2 =
NB. 3*333*167 + 5*199*100 - 15*33*67 = 166833+99500-33165 = 233168

+/~.(3*i.334),5*i.200

+/~.((3 * >:i. 333) , (5 * >:i.199))

3 5 ([: +/ ] #~ [: +./ [: 0&= [: 1&| %~/) i.&.<:1000   NB. ??

+/ ((0=3|n)+.(0=5|n)) # n=:>:i.999 

+/(((i.1000) * (0= 5 | i.1000)) +. ((i.1000) * ( 0=3  | i.1000))) NB. this is the solution i tried with

NB.------------------------------------------------
NB. Euler 002: sum of even fibs below 1e6
NB.------------------------
fib=: {."1@(]`(({: , +/)@])@.(> {:)^:(<_))&1 2
+/ (#~ -.@(2&|)) fib 1e6

NB.------------------------------------------------
NB. Euler 003: max prime of 600851475143:
NB.------------------------
{:q:600851475143
>./q:600851475143
max q:600851475143 NB. in case of load 'stats'

NB.------------------------------------------------
NB. Euler 004 Palindrome number of 3 digits multiplies
NB.------------------------

>([:{: ]#~ (=|.&.>)) <@":"0 /:~(0:-.~[:,>:/**/)~(i.100)-.~i.1000

NB. another solution; brute force
n=:100+i.900  NB. 3 digit numbers
prod=:~.,n*/n NB. unique products
pal=:((-:|.)@:":)"0 NB. test for palindrome
answer=:>./(pal#])prod

>./(#~ (-: |.)@":"0) ,/*/~i.1000

NB.------------------------------------------------
NB. Euler 005 lcm of i.20
NB.------------------------

lcm =: *./ NB. LCM Least Common Multiplier
lcm >: i.20

*/ ((>./"1@(+/@(E.&>)/) # [)~ ~.@;) <@q: 1+i.20 NB. J without *. 

NB.------------------------------------------------
NB. Euler 006: sqr of sum - sum of squares of i.101:
NB.------------------------
(*: +/ i.101) - (+/ (*: i.101))


NB.------------------------------------------------
NB. Euler 007
NB.------------------------

NB. By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
NB. we can see that the 6th prime is 13. What is the 10 001st prime number?

p: 10001

NB.------------------------------------------------
NB. Euler 008 greatest product of 13 numbers
NB.------------------------

q =: '7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450'
>./13*/\"."0 q

NB.------------------------------------------------
NB. Euler 009: Pythagorian triblets where a+b+c=1000
NB.------------------------

x:*/{.(#~ 1000"_=+/"1)(, +&.*:/)"1,/,"0/~1+i.1000


NB.------------------------------------------------
NB. Euler 010: sum of all primes < 2M
NB.------------------------
+/ (i.2000000) * (1 p: i.2000000) NB. 142913828922

+/ I. (1 p: i.2000000) NB. another solution

NB.------------------------------------------------
NB. Euler 011: greatest product of 4 adjacent numbers all directions
NB.------------------------

matrix=: 20 20$ 8 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48

max_horizontal        =: >./,/4*/\ matrix
max_vertical          =: >./,/4*/\ |: matrix
max_positive_diagonal =: >./,/4*/\"1 , /. matrix
max_negative_diagonal =: >./,/4*/\"1 , /. (|."1) matrix
max_product           =: >./ max_horizontal, max_vertical, max_positive_diagonal, max_negative_diagonal
max_product

NB.------------------------------------------------
NB. Euler 012: number with 500 divisors:
NB.------------------------

NB. the function foo below implements "Number of Divisors"
nod=:[: */ 1: + [: +/"1 =@q: NB. number of divisors
NB. and the following expression yields the answer in 0.14 seconds.
{.(500 < nod"0 t)#t=:+/\>: i.13000
NB. answer 76576500


NB.------------------------------------------------
NB. Euler 013: 1st 10 digits in sum of looong number series
NB.------------------------

10{.":+/ ".@(,&'x');._2(0 : 0) NB. ;._2 for cutting at end of line 'LF'
12345565646476                 NB. numbers are just example
23234455675677
24453456546456
56456462453454
)


ss=: 3 : 0
if. (2|a)
do.  a%2
else. a * 3 + 1 end.
)

NB.------------------------------------------------
NB. Euler 014: xxx
NB.------------------------

NB. The following iterative sequence is defined for the set of positive integers:

NB. n → n/2 (n is even)
NB. n → 3n + 1 (n is odd)

NB. Using the rule above and starting with 13, we generate the following sequence:
NB. 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

NB. It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. 
NB. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
NB. Which starting number, under one million, produces the longest chain?
NB. NOTE: Once the chain starts the terms are allowed to go above one million.


collatz =: (%&2)`(>:@:*&3)@.(2&|)"0
iterations =: (>:@:$:@:collatz)`1:@.(=&1)"0
500001 + (i. (>./)) iterations >: 5e5 + i. 5e5

NB.------------------------------------------------
NB. Euler 016: xxx
NB.------------------------
NB. 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
NB. What is the sum of the digits of the number 2^1000

+/"."0":2^1000x
NB. 1366

NB.------------------------------------------------
NB. Euler 017: sum of letters of numbers names 1:999
NB.------------------------

ones =. ;:'one two three four five six seven eight nine'
teens=. ;:'eleven twelve thirteen fourteen fifteen sixteen 
             seventeen eighteen nineteen'
tens =. ;:'twenty thirty forty fifty sixty seventy eighty
             ninety'
w99  =. ones,(<'ten'),teens,,tens,&.>/'';' ',&.>ones

w=. w99,,(ones,&.><' hundred'),&.>/'';(<' and '),&.>w99
w=. w,<'one thousand'
# ' ' -.~ ; w

NB.------------------------------------------------
NB. Euler 020: Factorial digit sum
NB.------------------------


NB. n! means n × (n − 1) × ... × 3 × 2 × 1

NB. For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
NB. and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

NB. Find the sum of the digits in the number 100!

+/"."0":!100x

NB.------------------------------------------------
NB. Euler 048: Self Power
NB.------------------------

NB. The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

NB. Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.


(10^10x)|+/ ^~ 1+i.1000x
NB. 9110846700

|.10{. |. "."0": (+/ ^~ 1+i.1000x)
NB. 9 1 1 0 8 4 6 7 0 0

