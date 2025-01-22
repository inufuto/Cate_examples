include "Model100.inc"

ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: public TimerCount
    defb 0

cseg
    call InitSound
    di
        mvi a,$04 | call $7383
        mvi a,$c3 ; jmp
        sta $f5ff
        lxi h,Handler
        shld $f5ff+1
    ei

    mvi a,$0b
    defb $30 ; SIM
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
