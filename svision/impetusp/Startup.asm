include "Port.inc"

ext InitVram
ext InitSound, SoundHandler
ext Main_

Interval equ 4

dseg
TimerCount: 
    defb 0


cseg
Startup: public Startup
    jsr InitSound
    lda #$1a | sta SystemControl
    lda #Interval | sta IRQTimer
    jsr InitVram
jmp Main_


IrqHandler: public IrqHandler
    pha | phx | phy
        lda IRQStatus
        and #$01
        if ne
            inc TimerCount
            jsr SoundHandler
            lda ResetIRQTimerFlag
            lda #Interval | sta IRQTimer
        endif
    ply | plx | pla
NmiHandler: public NmiHandler
rti


; void WaitTimer(byte t);
dseg
WaitTimer_t:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    pha
        sty WaitTimer_t
        do
            lda TimerCount
            cmp WaitTimer_t
        while cc | wend
        sei
            stz TimerCount
        cli
    pla
rts