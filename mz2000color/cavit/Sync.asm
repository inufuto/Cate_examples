dseg
PrevSync: defb 0 
public PrevSync
TimerCount_: defb 0 
public TimerCount_

cseg

PollVSync_: public PollVSync_
    push af | push hl
        in a,(0e1h)
        and 1
        ld hl,PrevSync
        cp (hl)
        if nz
            ld (hl),a
            or a
            if nz
                ld hl,TimerCount_
                inc (hl)
            endif
        endif
    pop hl | pop af
ret


WaitTimer_:
    public WaitTimer_
    push af | push de
        ld e,a
        do
            call PollVSync_
            ld a,(TimerCount_)
            cp e
        while c | wend
        ; di
            xor a
            ld (TimerCount_),a
        ; ei
    pop de | pop af
ret
