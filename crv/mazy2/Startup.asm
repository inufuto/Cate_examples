include "Port.inc"
include "Vram.inc"

ext InitVram
ext InitSprites
ext InitSound, SoundHandler
ext Main_

dseg
VCount_: public VCount_
    defb 0
TimerRate:
    defb 0
TimerValue:
    defb 0
TimerCount: public TimerCount
    defb 0


cseg
Startup: public Startup
    sty TimerValue

    lda #0
    sei
        sta VCount_
    cli
    do
        lda VCount_
    while eq | wend
    lda #0
    tax | tay
    sei
        sta VCount_
    cli
    do
        iny
        if eq
            inx
        endif
        lda VCount_
    while eq | wend
    ; sei
    ;     do
    ;         lda VdpReadPort+1
    ;     while pl|wend
    ;     do
    ;         lda VdpReadPort+1
    ;     while mi|wend
    ;     do
    ;         iny
    ;         if eq
    ;             inx
    ;         endif
    ;         lda VdpReadPort+1
    ;     while pl|wend
    ; cli
    stx VCount_
    cpx #10
    if cs
        lda #6
    else
        lda #5
    endif
    sta TimerRate

    cli
    jsr InitVram
    jsr InitSprites
    jsr InitSound
jmp Main_


IrqHandler: public IrqHandler
    pha
    txa | pha
    tya | pha
        lda VdpReadPort+1
        if mi
            inc VCount_
            lda TimerValue
            sec|sbc TimerRate
            do
            while mi
                inc TimerCount
                pha
                    jsr SoundHandler
                pla
                clc|adc #5
            wend
            sta TimerValue
        endif
    pla | tay
    pla | tax
    pla
    cli
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