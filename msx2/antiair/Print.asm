	extrn @Temporary@Byte
	dseg
zeroVisible_:	defs 1
byteValue_:	defs 1
wordValue_:	defs 2
	extrn	ClearScreen_
	extrn	Put_
	extrn	VVramToVram_
	extrn	SwitchVram_
	extrn	EraseBackup_
	extrn	DrawSprite_
	extrn	PrintC_
	extrn	DrawAll_
;
;	function PrintDigitB
;
	dseg
PrintDigitB_@Local5:	defs 1
	dseg
	;vram => register hl
	;n => @Local5
PrintDigitB_.@3_:	defs 1
	dseg
	;c => register a
	cseg
PrintDigitB_:
	push	af
	push	de
	;	vram = @1	[0]
	;	n = @2	[1]
	push	hl	; vram
		ld	hl,PrintDigitB_@Local5
		ld	(hl),e
	pop	hl	; vram
	;	c = 0	[2]
	xor	a
PrintDigitB@Anchor15:
	;	if byteValue < n goto PrintDigitB@Anchor14	[3]
	ld	(@Temporary@Byte),a	; c
	push	hl	; vram
		ld	a,(byteValue_)
		ld	hl,PrintDigitB_@Local5
		cp	(hl)
	pop	hl	; vram
	ld	a,(@Temporary@Byte)	; c
	jr	c,PrintDigitB@Anchor14
	;	c = c + 1	[4]
	inc	a
	;	byteValue = byteValue - n	[5]
	push	af	; c
	push	hl	; vram
		ld	a,(byteValue_)
		ld	hl,PrintDigitB_@Local5
		sub	(hl)
		ld	(byteValue_),a
	pop	hl	; vram
	pop	af	; c
	;	goto PrintDigitB@Anchor15	[6]
	jr	PrintDigitB@Anchor15
PrintDigitB@Anchor14:
	;	if c != 0 goto PrintDigitB@Anchor16	[7]
	or	a
	jr	nz,PrintDigitB@Anchor16
	;	if zeroVisible == 0 goto PrintDigitB@Anchor17	[8]
	ld	(@Temporary@Byte),a	; c
		ld	a,(zeroVisible_)
		or	a
	ld	a,(@Temporary@Byte)	; c
	jr	z,PrintDigitB@Anchor17
	;	@3 = 48	[9]
	push	af	; c
		ld	a,48
		ld	(PrintDigitB_.@3_),a
	pop	af	; c
	;	goto PrintDigitB@Anchor18	[10]
	jr	PrintDigitB@Anchor18
PrintDigitB@Anchor17:
	;	@3 = 32	[11]
	push	af	; c
		ld	a,32
		ld	(PrintDigitB_.@3_),a
	pop	af	; c
PrintDigitB@Anchor18:
	;	c = @3	[12]
	ld	a,(PrintDigitB_.@3_)
	;	goto PrintDigitB@Anchor19	[13]
	jr	PrintDigitB@Anchor19
PrintDigitB@Anchor16:
	;	zeroVisible = 1	[14]
	push	af	; c
		ld	a,1
		ld	(zeroVisible_),a
	pop	af	; c
	;	c = c + 48	[15]
	add	a,48
PrintDigitB@Anchor19:
	;	@4 = PrintC_(vram,c)	[16]
	ld	e,a
	call	PrintC_
	;	return @4	[17]
PrintDigitB@Anchor13:
	pop	de
	pop	af
	ret
;
;	function PrintByteNumber3
;
	dseg
PrintByteNumber3_@Local4:	defs 1
	dseg
	;vram => register hl
	;b => @Local4
	cseg
PrintByteNumber3_:
	public	PrintByteNumber3_
	push	af
	push	de
	;	vram = @1	[0]
	;	b = @2	[1]
	push	hl	; vram
		ld	hl,PrintByteNumber3_@Local4
		ld	(hl),e
	pop	hl	; vram
	;	zeroVisible = 0	[2]
	xor	a
	ld	(zeroVisible_),a
	;	byteValue = b	[3]
	ld	a,(PrintByteNumber3_@Local4)
	ld	(byteValue_),a
	;	vram = PrintDigitB_(vram,100)	[4]
	ld	e,100
	call	PrintDigitB_
	;	vram = PrintDigitB_(vram,10)	[5]
	ld	e,10
	call	PrintDigitB_
	;	@3 = byteValue + 48	[6]
	ld	a,(byteValue_)
	add	a,48
	;	vram = PrintC_(vram,@3)	[7]
	ld	e,a
	call	PrintC_
	;	return vram	[8]
PrintByteNumber3@Anchor20:
	pop	de
	pop	af
	ret
;
;	function PrintByteNumber2
;
	dseg
PrintByteNumber2_@Local4:	defs 1
	dseg
	;vram => register hl
	;b => @Local4
	cseg
PrintByteNumber2_:
	public	PrintByteNumber2_
	push	af
	push	de
	;	vram = @1	[0]
	;	b = @2	[1]
	push	hl	; vram
		ld	hl,PrintByteNumber2_@Local4
		ld	(hl),e
	pop	hl	; vram
	;	zeroVisible = 0	[2]
	xor	a
	ld	(zeroVisible_),a
	;	byteValue = b	[3]
	ld	a,(PrintByteNumber2_@Local4)
	ld	(byteValue_),a
	;	vram = PrintDigitB_(vram,10)	[4]
	ld	e,10
	call	PrintDigitB_
	;	@3 = byteValue + 48	[5]
	ld	a,(byteValue_)
	add	a,48
	;	vram = PrintC_(vram,@3)	[6]
	ld	e,a
	call	PrintC_
	;	return vram	[7]
PrintByteNumber2@Anchor21:
	pop	de
	pop	af
	ret
;
;	function PrintDigitW
;
	dseg
PrintDigitW_@Local5:	defs 2
	dseg
	;vram => register hl
	;n => @Local5
PrintDigitW_.@3_:	defs 1
	dseg
	;c => register a
	cseg
PrintDigitW_:
	public	PrintDigitW_
	push	af
	push	de
	;	vram = @1	[0]
	;	n = @2	[1]
	ld	(PrintDigitW_@Local5),de
	;	c = 0	[2]
	xor	a
PrintDigitW@Anchor24:
	;	if wordValue < n goto PrintDigitW@Anchor23	[3]
	push	hl	; vram
		ld	de,(PrintDigitW_@Local5)
		ld	hl,(wordValue_)
		call	cate.CompareHlDe
	pop	hl	; vram
	jr	c,PrintDigitW@Anchor23
	;	c = c + 1	[4]
	inc	a
	;	wordValue = wordValue - n	[5]
	push	hl	; vram
		ld	hl,(wordValue_)
		or	a
		sbc	hl,de
		ld	(wordValue_),hl
	pop	hl	; vram
	;	goto PrintDigitW@Anchor24	[6]
	jr	PrintDigitW@Anchor24
PrintDigitW@Anchor23:
	;	if c != 0 goto PrintDigitW@Anchor25	[7]
	or	a
	jr	nz,PrintDigitW@Anchor25
	;	if zeroVisible == 0 goto PrintDigitW@Anchor26	[8]
	ld	(@Temporary@Byte),a	; c
		ld	a,(zeroVisible_)
		or	a
	ld	a,(@Temporary@Byte)	; c
	jr	z,PrintDigitW@Anchor26
	;	@3 = 48	[9]
	push	af	; c
		ld	a,48
		ld	(PrintDigitW_.@3_),a
	pop	af	; c
	;	goto PrintDigitW@Anchor27	[10]
	jr	PrintDigitW@Anchor27
PrintDigitW@Anchor26:
	;	@3 = 32	[11]
	push	af	; c
		ld	a,32
		ld	(PrintDigitW_.@3_),a
	pop	af	; c
PrintDigitW@Anchor27:
	;	c = @3	[12]
	ld	a,(PrintDigitW_.@3_)
	;	goto PrintDigitW@Anchor28	[13]
	jr	PrintDigitW@Anchor28
PrintDigitW@Anchor25:
	;	zeroVisible = 1	[14]
	push	af	; c
		ld	a,1
		ld	(zeroVisible_),a
	pop	af	; c
	;	c = c + 48	[15]
	add	a,48
PrintDigitW@Anchor28:
	;	@4 = PrintC_(vram,c)	[16]
	ld	e,a
	call	PrintC_
	;	return @4	[17]
PrintDigitW@Anchor22:
	pop	de
	pop	af
	ret
;
;	function PrintNumber5
;
	dseg
	;vram => register bc
	;w => register de
	cseg
PrintNumber5_:
	public	PrintNumber5_
	push	af
	push	de
	push	bc
	;	vram = @1	[0]
	ld	c,l
	ld	b,h
	;	w = @2	[1]
	;	zeroVisible = 0	[2]
	xor	a
	ld	(zeroVisible_),a
	;	wordValue = w	[3]
	ld	(wordValue_),de
	;	vram = PrintDigitW_(vram,10000)	[4]
	ld	de,10000
	ld	l,c
	ld	h,b
	call	PrintDigitW_
	ld	c,l
	ld	b,h
	;	vram = PrintDigitW_(vram,1000)	[5]
	ld	de,1000
	ld	l,c
	ld	h,b
	call	PrintDigitW_
	ld	c,l
	ld	b,h
	;	vram = PrintDigitW_(vram,100)	[6]
	ld	de,100
	ld	l,c
	ld	h,b
	call	PrintDigitW_
	ld	c,l
	ld	b,h
	;	vram = PrintDigitW_(vram,10)	[7]
	ld	de,10
	ld	l,c
	ld	h,b
	call	PrintDigitW_
	ld	c,l
	ld	b,h
	;	@4 = wordValue + 48	[8]
	ld	hl,(wordValue_)
	ld	de,48
	add	hl,de
	;	@3 = (byte)@4	[9]
	ld	a,l
	;	vram = PrintC_(vram,@3)	[10]
	ld	l,c
	ld	h,b
	ld	e,a
	call	PrintC_
	ld	c,l
	ld	b,h
	;	return vram	[11]
	ld	l,c
	ld	h,b
PrintNumber5@Anchor29:
	pop	bc
	pop	de
	pop	af
	ret
;
;	function PrintNumber3
;
	dseg
	;vram => register bc
	;w => register de
	cseg
PrintNumber3_:
	public	PrintNumber3_
	push	af
	push	de
	push	bc
	;	vram = @1	[0]
	ld	c,l
	ld	b,h
	;	w = @2	[1]
	;	zeroVisible = 0	[2]
	xor	a
	ld	(zeroVisible_),a
	;	wordValue = w	[3]
	ld	(wordValue_),de
	;	vram = PrintDigitW_(vram,100)	[4]
	ld	de,100
	ld	l,c
	ld	h,b
	call	PrintDigitW_
	ld	c,l
	ld	b,h
	;	vram = PrintDigitW_(vram,10)	[5]
	ld	de,10
	ld	l,c
	ld	h,b
	call	PrintDigitW_
	ld	c,l
	ld	b,h
	;	@4 = wordValue + 48	[6]
	ld	hl,(wordValue_)
	ld	de,48
	add	hl,de
	;	@3 = (byte)@4	[7]
	ld	a,l
	;	vram = PrintC_(vram,@3)	[8]
	ld	l,c
	ld	h,b
	ld	e,a
	call	PrintC_
	ld	c,l
	ld	b,h
	;	return vram	[9]
	ld	l,c
	ld	h,b
PrintNumber3@Anchor30:
	pop	bc
	pop	de
	pop	af
	ret

	extrn	cate.CompareHlDe
