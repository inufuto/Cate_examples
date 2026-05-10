include "pc82.inc"

ext Main_
ext InitSound, SoundHandler

dseg
TimerCount: public TimerCount
    defb 0
; Scale:
;     defb 0
OldMask:
    defb 0

cseg
    xra a | sta TimerCount
    di
        mvi a,0c3h ; jmp
        sta 0f38fh
        lxi h,Handler
        shld 0f38fh+1

        mvi a,04h | call 73b3h
    ei

    defb 20h ; RIM
    sta OldMask
    mvi a,00bh
    defb 30h ; SIM

    call InitSound
    call Main_

    lda OldMask
    defb 30h ; SIM

    di
        mvi a,0c9h ; ret
        sta 0f38fh
    ei
ret


Handler: public Handler
    push psw
        lda TimerCount
        inr a
        sta TimerCount
        call SoundHandler    
    pop psw
ret


WaitTimer_: public WaitTimer_
    push psw | push d
        mov e,a
        do
            lda TimerCount
            cmp e
        while c | wend
        xra a
        sta TimerCount
    pop d | pop psw
ret










