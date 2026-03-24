extrn @Temp@Byte
extrn @Temp@Word
extrn @Temp@Word2
	cseg
Numbers_: ;Numbers
	defb 26
	defb 30
	defb 1
	defb 16
	defb 9
	defb 13
	defb 12
	defb 5
	defb 14
	defb 15
	defb 27
	defb 7
	defb 4
	defb 3
	defb 24
	defb 20
	defb 8
	defb 18
	defb 22
	defb 10
	defb 19
	defb 21
	defb 23
	defb 6
	defb 2
	defb 29
	defb 28
	defb 11
	defb 31
	defb 0
	defb 17
	defb 25
	dseg
RndIndex_:	defs 1
	public	RndIndex_
;
;	function Rnd
;
	dseg
Rnd_@Local4:	defs 2
	dseg
	dseg
	;r => register b
	cseg
Rnd_:
	public	Rnd_
	pshb
	;	@2 = (sword)RndIndex	[0]
	ldaa	RndIndex_
	staa	Rnd_@Local4+1
	clr	Rnd_@Local4
	;	@1 = @2 + Numbers_	[1]
	ldx	Rnd_@Local4
	ldaa	#high(Numbers_)
	ldab	#low(Numbers_)
	jsr	Cate.AddXAB
	stx	Rnd_@Local4
	;	r = *@1	[2]
	ldab	0,x
	;	RndIndex = RndIndex + 1	[3]
	inc	RndIndex_
	;	if RndIndex < 32 goto Rnd@Anchor5	[4]
	ldaa	RndIndex_
	cmpa	#32
	bcs	Rnd@Anchor5
	;	RndIndex = 0	[5]
	clr	RndIndex_
Rnd@Anchor5:
	;	@3 = r & 15	[6]
	andb	#15
	;	return @3	[7]
	tba
Rnd@Anchor4:
	pulb
	rts
;
;	function Abs
;
	dseg
	;a => register a
Abs_@Param1:
	public	Abs_@Param1
Abs_.b_:	defs 1
	cseg
Abs_:
	public	Abs_
	pshb
	;	a = @1	[0]
	;	if a >= b goto Abs@Anchor7	[1]
	cmpa	Abs_.b_
	bcc	Abs@Anchor7
	;	@2 = b - a	[2]
	ldab	Abs_.b_
	staa	<@Temp@Byte
	subb	<@Temp@Byte
	;	return @2	[3]
	tba
	bra	Abs@Anchor6
	;	goto Abs@Anchor8	[4]
	bra	Abs@Anchor8
Abs@Anchor7:
	;	@3 = a - b	[5]
	tab
	subb	Abs_.b_
	;	return @3	[6]
	tba
Abs@Anchor6:
Abs@Anchor8:
	pulb
	rts
;
;	function Sign
;
	dseg
	;from => register a
Sign_@Param1:
	public	Sign_@Param1
Sign_.to_:	defs 1
	cseg
Sign_:
	public	Sign_
	;	from = @1	[0]
	;	if from != to goto Sign@Anchor10	[1]
	cmpa	Sign_.to_
	bne	Sign@Anchor10
	;	return 0	[2]
	clra
	bra	Sign@Anchor9
Sign@Anchor10:
	;	if from >= to goto Sign@Anchor11	[3]
	cmpa	Sign_.to_
	bcc	Sign@Anchor11
	;	return 1	[4]
	ldaa	#1
	bra	Sign@Anchor9
Sign@Anchor11:
	;	return -1	[5]
	ldaa	#-1
Sign@Anchor9:
	rts

	extrn	Cate.AddXAB
