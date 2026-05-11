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
        mvi a,0c3h ; jmp
        sta 0eec2h
        lxi h,Handler
        shld 0eec2h+1

        defb 20h ; RIM
        sta Mask
        mvi a,0bh
        defb 30h ; SIM
    ei

    call InitSound
    call InitVram
    call Main_
    call EndVram

    di
        mvi a,0c9h ; ret
        sta 0eec2h

        lda Mask
        ani 0fh
        ori 08h
        defb 30h ; SIM
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
