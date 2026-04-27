ext InitVram
ext InitSound, SoundHandler
ext Main_

Interval equ 894886/60

dseg
TimerCount: 
    defb 0
zseg
SaveX:
    defw 0

cseg
    ldaa #$20
    staa $c800  ;   CMODE
    jsr InitVram
    jsr InitSound
    bsr StartTimer
jmp Main_

StartTimer:
    ldaa #low Interval | staa $c808
    ldaa #high Interval | staa $c809
rts

PollTimer_: public PollTimer_
    psha
        ldaa $c80d | bita #$20
        if ne
            bsr StartTimer
            inc TimerCount
            pshb
                stx <SaveX
                jsr SoundHandler
                ldx <SaveX
            pulb
        endif
    pula
rts


; void WaitTimer(byte t);
dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    psha
        staa WaitTimer_param
            do
                bsr PollTimer_
                ldaa TimerCount
                cmpa WaitTimer_param
            while cs
            wend
        ldaa WaitTimer_param
        clr TimerCount
    pula
rts
