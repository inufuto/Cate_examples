include "Model100.inc"

ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: public TimerCount
    defb 0

cseg
    call InitSound
    di
        mvi a,04h | call 7383h
        mvi a,0c3h ; jmp
        sta 0f5ffh
        lxi h,Handler
        shld 0f5ffh+1
    ei

    mvi a,0bh
    defb 30h ; SIM
jmp Main_

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
