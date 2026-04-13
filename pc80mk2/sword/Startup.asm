ext InitVram
ext InitSound
ext Main_

Port31Save equ 0e6c6h
PortE6Save equ 0e65ch

dseg
Timer10:
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
	xor a
	out (68h),a
    ld (Timer10),a

    call InitSound
	call InitVram

    ld a,(Port31Save)
	or 0feh
	and not 04h
    out (31h),a
	ld (Port31Save),a

	ld a,(PortE6Save)
	and 0f8h
	or 1
	out (0e6h),a ; Interrupt level
	ld (PortE6Save),a

    ld hl,Handler
    ld (8004h),hl
    ei
jp Main_


Handler: public Handler
    push af
        ld a,(0ea55h)
        push af
			ld a,(Timer10)
			inc a
			cp 10
			if nc
				push hl
					ld hl,TimerCount
					inc (hl)
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
