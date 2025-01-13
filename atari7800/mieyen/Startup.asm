include "Atari7800.inc"

ext CharPattern
ext InitDisplayLists
ext InitVram
ext InitSprites
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount:
    defb 0
PrevSync:
    defb 0

cseg
Startup: public Startup
    ldx #$ff | txs
    sei
    cld

    lda #$07 | sta <INPTCTRL
    lda #1 | sta TIM64T
    
    lda #high CharPattern | sta <CHARBASE
    jsr InitDisplayLists
    jsr InitVram
    jsr InitSprites
    jsr InitSound
jmp Main_

NmiHandler: public NmiHandler
    pha
    txa | pha
    tya | pha
        lda MSTAT
        if pl
            inc TimerCount
            jsr SoundHandler
        endif
    pla | tay
    pla | tax
    pla
rti
IrqHandler: public IrqHandler
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
            lda #0 | sta TimerCount
        cli
    pla
rts