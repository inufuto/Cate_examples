ext InitSound
ext Main_

WRTP26 equ $FED4
Interval equ 9500

dseg
Save08:
    defb 0
SaveInt:
    defs 3
TimerCount:
    defb 0


cseg
    jsr InitSound
    sei
        ldaa $010F | staa SaveInt
        ldx $010F+1 | stx SaveInt+1
        ldaa #$7e | staa $010F ; jmp 
        ldx #TimerHandler | stx $010F+1

        ldaa <$08 | staa Save08
        ldaa #$08 | staa <$08
        ldx #0 | stx <$09
        ldx #Interval | stx <$0b

        ldd #$1000 | jsr WRTP26
    cli
    
    jsr Main_

    sei
        ldaa Save08 | staa <$08
        staa SaveInt | staa $010F
        ldx SaveInt+1 | stx $010F+1

        ldd #$1010 | jsr WRTP26
    cli
rts


TimerHandler: public TimerHandler
    psha | pshb
        ldaa <$08
        ldd #0 | std <$09
        ldd #Interval | std <$0b
        ldaa #$08 | staa <$08
        inc TimerCount
    pulb | pula
rti
; jmp SaveInt


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
    ldaa WaitTimer_param
    clr TimerCount
rts
