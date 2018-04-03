: even  2 % not ;

: ddup swap dup rot dup rot swap ;

: primary  
  dup 2 / 1 + 1
  repeat
        1 +
	ddup - 
	if
		swap -rot
		ddup %
		if rot swap 0 else drop swap 0 0 rot then
	else 
		1 -rot
	then
  until 
  not drop  ;

: storeValByAddr dup -rot ! ; 
: allotPrimary primary 8 allot storeValByAddr ;

: copyWord 
  ddup dup count 0  
  do
	ddup c@ swap c!
	swap 1 +
	swap 1 +
  loop ;

: concat ddup count swap count
  1 + + heap-alloc rot 
  copyWord
  drop >r rot r> swap 
  copyWord
  drop 0 swap c! swap drop rot ;

( promotorov hash=12908 %3=2 )
: rad 
  dup 2 / 1 + 1 swap 2
  do
	r@ rot swap ddup %
	if 
		swap -rot drop
        else
		swap -rot
		primary  
		if * else drop then
	then
  loop ;