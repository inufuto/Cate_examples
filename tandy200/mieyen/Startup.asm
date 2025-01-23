ext InitVram, EndVram
ext InitSound, SoundHandler
ext Main_

dseg
Mask:
    defb 0
clockCount: 
    defb 0
TimerCount: public TimerCount
    defb 0


cseg
    di
        mvi a,$c3 ; jmp
        sta $eec2
        lxi h,Handler
        shld $eec2+1

        defb $20 ; RIM
        sta Mask
        mvi a,$0b
        defb $30 ; SIM
    ei

    call InitSound
    call InitVram
    call Main_
    call EndVram

    di
        mvi a,$c9 ; ret
        sta $eec2

        lda Mask
        ani $0f
        ori $08
        defb $30 ; SIM
    ei
ret


Handler: public Handler
    push psw
        lda clockCount
        sui 2
        if c
            push psw
                lda TimerCount
                inr a
                sta TimerCount
                call SoundHandler
            pop psw
            TimerRate: public TimerRate
            adi 10 ; actual
            ; adi 5 ; mess
        endif
        sta clockCount
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
