ext InitVram
ext Main_

dseg
PrevCount:
    defb 0
TimerCount:
    defb 0 

cseg
    xra a | sta TimerCount
    call InitVram
jmp Main_


; void PollVSync();
cseg
PollVSync_: public PollVSync_
    push psw | push h | push d
        lda $4034 | mov e,a
        lda PrevCount
        lxi h,TimerCount
        do
            cmp e
        while nz
            inr m
            dcr a
        wend
        sta PrevCount
    pop d | pop h | pop psw
ret


; void WaitTimer(byte t);
WaitTimer_: public WaitTimer_
    push psw | push d
        mov e,a
        do
            call PollVSync_
            lda TimerCount
            cmp e
        while c | wend
        xra a
        sta TimerCount
    pop d | pop psw
ret
