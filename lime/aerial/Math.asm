	ext	@Temp@Byte
	ext	@Temp@Word
	ext	@Temp@Word2
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
	;r => register a
	cseg
Rnd_:
	public	Rnd_
	pshs	b,x
	;	@2 = (sword)RndIndex	[0]
	ldb	RndIndex_
	clra
	;	@1 = Numbers_ + @2	[1]
	ldx	#Numbers_
	leax	d,x
	;	r = *@1	[2]
	lda	,x
	;	RndIndex = RndIndex + 1	[3]
	inc	RndIndex_
	;	if RndIndex < 32 goto Rnd@Anchor5	[4]
	pshs	a	; r
		lda	RndIndex_
		cmpa	#32
	puls	a	; r
	bcs	Rnd@Anchor5
	;	RndIndex = 0	[5]
	clr	RndIndex_
Rnd@Anchor5:
	;	@3 = r & 15	[6]
	anda	#15
	;	return @3	[7]
Rnd@Anchor4:
	puls	b,x
	rts
;
;	function Abs
;
	dseg
Abs_@Local5:	defs 1
	dseg
	;a => @Local5
	;b => register b
	cseg
Abs_:
	public	Abs_
	;	a = @1	[0]
	sta	Abs_@Local5
	;	b = @2	[1]
	;	if a >= b goto Abs@Anchor7	[2]
	lda	Abs_@Local5
	stb	<@Temp@Byte
	cmpa	<@Temp@Byte
	bcc	Abs@Anchor7
	;	@3 = b - a	[3]
	tfr	b,a
	suba	Abs_@Local5
	;	return @3	[4]
	bra	Abs@Anchor6
	;	goto Abs@Anchor8	[5]
	bra	Abs@Anchor8
Abs@Anchor7:
	;	@4 = a - b	[6]
	stb	<@Temp@Byte
	suba	<@Temp@Byte
	;	return @4	[7]
Abs@Anchor6:
Abs@Anchor8:
	rts
;
;	function Sign
;
	dseg
	;from => register a
	;to => register b
	cseg
Sign_:
	public	Sign_
	;	from = @1	[0]
	;	to = @2	[1]
	;	if from != to goto Sign@Anchor10	[2]
	stb	<@Temp@Byte
	cmpa	<@Temp@Byte
	bne	Sign@Anchor10
	;	return 0	[3]
	clra
	bra	Sign@Anchor9
Sign@Anchor10:
	;	if from >= to goto Sign@Anchor11	[4]
	stb	<@Temp@Byte
	cmpa	<@Temp@Byte
	bcc	Sign@Anchor11
	;	return 1	[5]
	lda	#1
	bra	Sign@Anchor9
Sign@Anchor11:
	;	return -1	[6]
	lda	#-1
Sign@Anchor9:
	rts
