ext InitVram
ext InitSound, SoundHandler
ext Main_

PortE6Save equ 0e65ch

dseg
Timer10:
    defb 0
TimerCount:
    defb 0

cseg
	xor a
	out (68h),a ; DMA off
    ld (Timer10),a

    call InitSound
	call InitVram

	ld a,(PortE6Save)
	and 0f8h
	or 1
	out (0e6h),a ; Interrupt level
	ld (PortE6Save),a

    ld a,84h ; Graphics Display Priority
    out (33h),a

    ld hl,Handler
    ld (0f304h),hl
    ei

    ; ld a,90h | out (35h),a
jp Main_


Handler: public Handler
    push af
        ld a,(0e65bh)
        push af
			ld a,(Timer10)
			inc a
			cp 10
			if nc
				push hl
					ld hl,TimerCount
					inc (hl)
					call SoundHandler
				pop hl
				xor a
			endif
			ld (Timer10),a
		pop af
		out (0e4h),a
    pop af
	ei
ret


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
