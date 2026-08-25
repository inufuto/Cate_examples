ext InitVram
ext InitSound, SoundHandler
ext Main_

Interval equ $418a/6


dseg
TimerCount: 
    defb 0

cseg
    clr $0000 ; key click off
    jsr InitVram
    jsr InitSound

    sei
        ldaa #high Interval | staa $c817
        ldaa #low Interval | staa $c818
        ldx #handler | stx $10c
    cli
jmp Main_

Handler: public Handler
    ; ldaa $c81d
    ; bita #$10
    ; if ne
        inc TimerCount
        jsr SoundHandler
    ; endif
rts


; void WaitTimer(byte t);
dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    staa WaitTimer_param
        do
            ldaa TimerCount
            cmpa WaitTimer_param
        while cs
        wend
    ldaa <WaitTimer_param
    clr TimerCount
rts
