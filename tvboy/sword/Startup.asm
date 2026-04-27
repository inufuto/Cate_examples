Interval equ 10240*5/3

ext SoundProc
ext Main_

dseg
TimerCount:
    defb 0

cseg
Startup: public Startup
    sei
        lds #$0100

        clra | staa <$01
        ldaa #$7f | staa <$00

        ldaa #$08 | staa <$08
        ldx #0 | stx <$09
        ldx #Interval | stx <$0b
    cli

    ldaa #$11 | staa $2000
    
    clr SoundProc
    clr SoundProc+1
jmp Main_


TimerHandler: public TimerHandler
    psha | pshb
        ldaa <$08
        ldd #0 | std <$09
        ldd #Interval | std <$0b
        ldaa #$08 | staa <$08
        inc TimerCount
    pulb | pula
rti


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
