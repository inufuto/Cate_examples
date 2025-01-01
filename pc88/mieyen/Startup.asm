ext InitVram
ext InitSound, SoundHandler
ext Main_

Vector equ 0f302h

dseg
InterruptRate:
    defb 0
InterruptValue:
    defb 0
TimerCount:
    defb 0

cseg
	;DMA off
	xor a
	out (68h),a
	ld (InterruptValue),a

	in a,(40h)
	and 02h
	if z
		ld a,55
	else
		ld a,62
	endif
	ld (InterruptRate),a

	call InitVram
	call InitSound

	di
		ld a,(0ef0eh)
		and 0f8h
		or 2
		out (0e6h),a
		ld (0ef0eh),a
		;ld a,3
		;out (0e4h),a
		;ld (0e6c3h),a
		
        ld hl,(Vector) ; interrupt handler
        ld (Handler_end+1),hl
        ld hl,Handler
        ld (Vector),hl
    ei
    call Main_
    di
        ld hl,(Handler_end+1)
        ld (Vector),hl
    ei

	ld a,0ffh
	out (0e6h),a
	;DMA on
	ld hl,705bh
	ld a,(0ef88h)
	cp 21
	if nc
		ld hl,7066h
	endif
	ld a,(0ef89h)
	cp 80
	di
	call 6fd1h
	ei
ret	


Handler: public Handler
    push af | push hl
		ld hl,(InterruptRate)
		ld a,h
		sub 60
		ld h,a
		do
			bit 7,h
		while nz
			ld a,h
			add a,l
			ld h,a
			push hl
				ld hl,TimerCount
				inc (hl)
				call SoundHandler
			pop hl
		wend
		ld (InterruptRate),hl
    pop hl | pop af
	; ei
	; reti
	; ld a,(0ef0eh)
	; and 0f8h
	; or 1
	; out (0e6h),a
	; ld (0ef0eh),a
	; ld a,3
	; out (0e4h),a
Handler_end:
    jp 0

WaitTimer_:
    public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        di
            xor a
            ld (TimerCount),a
        ei
    pop de | pop af
ret
