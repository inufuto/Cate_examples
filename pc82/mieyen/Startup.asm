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
        mvi a,$c3 ; jmp
        sta $f38f
        lxi h,Handler
        shld $f38f+1

        mvi a,$04 | call $73b3
    ei

    defb $20 ; RIM
    sta OldMask
    mvi a,$0b
    defb $30 ; SIM

    call InitSound
    call Main_

    lda OldMask
    defb $30 ; SIM

    di
        mvi a,$c9 ; ret
        sta $f38f
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
