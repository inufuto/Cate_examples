ext InitSound
ext Main_

dseg
PrevSync: defb 0
TimerCount: defb 0 public TimerCount


cseg
Init_: public  Init_
    call InitSound
jp Main_


cseg
PollVSync_: public PollVSync_
	push af
		in a,(0fdh)
		and 01h
        if nz
            ld a,(PrevSync)
            or a
            call z,Handler
            ld a,01h
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


WaitTimer_:
    public WaitTimer_
    push af | push de
        ld e,a
        do
            call PollVSync_
            ld a,(TimerCount)
            cp e
        while c | wend
        ; di
            xor a
            ld (TimerCount),a
        ; ei
    pop de | pop af
ret
