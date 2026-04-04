ext InitSound
ext Main_

VSyncBit equ 02h

dseg
PrevSync:
    defb 0
TimerCount: public TimerCount
    defb 0


cseg
    di
    ld sp,2800h
    xor a
    ld (TimerCount),a
    call InitSound
jp Main_

cseg
PollVSync_: public PollVSync_
	push af
		ld a,(6000h)
		and VSyncBit
        if nz
            ld a,(PrevSync)
            or a
            call z,Handler
            ld a,VSyncBit
        endif
        ld (PrevSync),a
    pop af
ret


Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
ret


WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            call PollVSync_
            ld a,(TimerCount)
            cp e
        while c | wend
        xor a
        ld (TimerCount),a
    pop de | pop af
ret
