ext InitVram
ext InitSound, SoundHandler
ext Main_

Vector equ 0f304h

dseg
Timer10:
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
	;DMA off
	xor a
	out (68h),a
	ld (Timer10),a

	call InitVram
	call InitSound

	ld a,(0ef0eh)
	and 0f8h
	or 1
	out (0e6h),a
	ld (0ef0eh),a
	
	ld hl,Handler | ld (Vector),hl
    ei
jp Main_


Handler: public Handler
    push af
		ld a,(0e6c3h)
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

WaitTimer_: public WaitTimer_
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
