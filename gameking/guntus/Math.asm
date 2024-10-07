extrn @zp
extrn ZB0
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
	dseg
	;r => register <@zp+0
	cseg
Rnd_:
	public	Rnd_
	pha
	lda	<@zp+0
	pha
	lda	<@zp+1
	pha
	;	@2 = (sword)RndIndex	[0]
	lda	RndIndex_
	sta	<@zp+0
	stz	<@zp+1
	;	@1 = @2 + Numbers_	[1]
	lda	<@zp+0
	clc|adc	#low(Numbers_)
	sta	<@zp+0
	lda	<@zp+1
	adc	#high(Numbers_)
	sta	<@zp+1
	;	r = *@1	[2]
	lda	(<@zp+0)
	tax
	stx	<@zp+0
	;	RndIndex = RndIndex + 1	[3]
	inc	RndIndex_
	;	if RndIndex < 32 goto Rnd@Anchor5	[4]
	lda	RndIndex_
	cmp	#32
	bcc	Rnd@Anchor5
	;	RndIndex = 0	[5]
	lda	#0
	sta	RndIndex_
Rnd@Anchor5:
	;	@3 = r & 15	[6]
	lda	<@zp+0
	and	#15
	;	return @3	[7]
	tay
Rnd@Anchor4:
	pla
	sta	<@zp+1
	pla
	sta	<@zp+0
	pla
	rts
;
;	function Abs
;
	dseg
Abs_@Local4:	defs 1
	dseg
	;a => @Local4
Abs_@Param1:
	public	Abs_@Param1
Abs_.b_:	defs 1
	cseg
Abs_:
	public	Abs_
	pha
	;	a = @1	[0]
	sty	Abs_@Local4
	;	if a >= b goto Abs@Anchor7	[1]
	lda	Abs_@Local4
	cmp	Abs_.b_
	bcs	Abs@Anchor7
	;	@2 = b - a	[2]
	lda	Abs_.b_
	sec|sbc	Abs_@Local4
	;	return @2	[3]
	tay
	jmp	Abs@Anchor6
	;	goto Abs@Anchor8	[4]
	jmp	Abs@Anchor8
Abs@Anchor7:
	;	@3 = a - b	[5]
	sec|sbc	Abs_.b_
	;	return @3	[6]
	tay
Abs@Anchor6:
Abs@Anchor8:
	pla
	rts
;
;	function Sign
;
	dseg
Sign_@Local2:	defs 1
	dseg
	;from => @Local2
Sign_@Param1:
	public	Sign_@Param1
Sign_.to_:	defs 1
	cseg
Sign_:
	public	Sign_
	pha
	;	from = @1	[0]
	sty	Sign_@Local2
	;	if from != to goto Sign@Anchor10	[1]
	lda	Sign_@Local2
	cmp	Sign_.to_
	bne	Sign@Anchor10
	;	return 0	[2]
	ldy	#0
	jmp	Sign@Anchor9
Sign@Anchor10:
	;	if from >= to goto Sign@Anchor11	[3]
	cmp	Sign_.to_
	bcs	Sign@Anchor11
	;	return 1	[4]
	ldy	#1
	jmp	Sign@Anchor9
Sign@Anchor11:
	;	return -1	[5]
	ldy	#-1
Sign@Anchor9:
	pla
	rts
