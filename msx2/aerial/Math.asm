	extrn @Temporary@Byte
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
	push	hl
	push	de
	;	@2 = (sword)RndIndex	[0]
	ld	a,(RndIndex_)
	ld	l,a
	ld	h,0
	;	@1 = @2 + Numbers_	[1]
	ld	de,Numbers_
	add	hl,de
	;	r = *@1	[2]
	ld	a,(hl)
	;	RndIndex = RndIndex + 1	[3]
	ld	hl,RndIndex_
	inc	(hl)
	;	if RndIndex < 32 goto Rnd@Anchor5	[4]
	ld	(@Temporary@Byte),a	; r
		ld	a,(RndIndex_)
		cp	32
	ld	a,(@Temporary@Byte)	; r
	jr	c,Rnd@Anchor5
	;	RndIndex = 0	[5]
	push	af	; r
		xor	a
		ld	(RndIndex_),a
	pop	af	; r
Rnd@Anchor5:
	;	@3 = r & 15	[6]
	and	15
	;	return @3	[7]
Rnd@Anchor4:
	pop	de
	pop	hl
	ret
;
;	function Abs
;
	dseg
	;a => register b
	;b => register e
	cseg
Abs_:
	public	Abs_
	push	bc
	;	a = @1	[0]
	ld	b,a
	;	b = @2	[1]
	;	if a >= b goto Abs@Anchor7	[2]
	ld	a,b
	cp	e
	jr	nc,Abs@Anchor7
	;	@3 = b - a	[3]
	ld	a,e
	sub	b
	;	return @3	[4]
	jr	Abs@Anchor6
	;	goto Abs@Anchor8	[5]
	jr	Abs@Anchor8
Abs@Anchor7:
	;	@4 = a - b	[6]
	ld	a,b
	sub	e
	;	return @4	[7]
Abs@Anchor6:
Abs@Anchor8:
	pop	bc
	ret
;
;	function Sign
;
	dseg
	;from => register a
	;to => register e
	cseg
Sign_:
	public	Sign_
	;	from = @1	[0]
	;	to = @2	[1]
	;	if from != to goto Sign@Anchor10	[2]
	cp	e
	jr	nz,Sign@Anchor10
	;	return 0	[3]
	xor	a
	jr	Sign@Anchor9
Sign@Anchor10:
	;	if from >= to goto Sign@Anchor11	[4]
	cp	e
	jr	nc,Sign@Anchor11
	;	return 1	[5]
	ld	a,1
	jr	Sign@Anchor9
Sign@Anchor11:
	;	return -1	[6]
	ld	a,-1
Sign@Anchor9:
	ret
