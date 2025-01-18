include "apple2.inc"
include "apple2gs.inc"

ext InitVram
ext InitSound, SoundHandler
ext ReadStick_
ext Main_

TimerInterrupt equ $e1002c

dseg
TimerCount: 
    defb 0


cseg
    clc | xce
    sep #$30 | a8 | i8

    sei
        jsr InitVram
        jsr InitSound

        sep #$30 | a8 | i8
        lda #low TimerHandler | sta TimerInterrupt+1
        lda #high TimerHandler | sta TimerInterrupt+2
        phk | pla | sta TimerInterrupt+3
    cli
    rep #$10 | i16
jmp Main_


TimerHandler: public TimerHandler
    php
        sep #$20 | a8
        inc TimerCount
        jsr SoundHandler
    plp
rtl


; void WaitTimer(byte t);
dseg
WaitTimer_t:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    php
        sep #$20 | a8
        pha
            sta WaitTimer_t
            do
                lda TimerCount
                cmp WaitTimer_t
            while cc | wend
            sei
                stz TimerCount
            cli
            jsr ReadStick_
        pla
    plp
rts
