include "ZeroPage.inc"
include "gametank.inc"

ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: 
    defb 0

cseg
Startup: public Startup
    sei
        ldx #$ff | txs | cld

        ; ldy #0
        ; do
            ldx #0
            do
                dex
            while ne | wend
        ;     dey
        ; while ne | wend

            LDA #40
            STA BANK_REG
            ; STA $1FFF
            STZ BANK_REG
            ; STZ $1FFF

        lda #$07
        sta VIA+DDRA
        lda #$FF
        sta VIA+ORAr

        jsr InitSound
    cli
    
    jsr InitVram
jmp Main_

NmiHandler: public NmiHandler
    pha | phx | phy
        inc TimerCount
        jsr SoundHandler
    ply | plx | pla
rti


; void WaitTimer(byte t);
zseg
WaitTimer_t:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    pha
        sty <WaitTimer_t
        do
            lda TimerCount
            cmp <WaitTimer_t
        while cc | wend
        sei
            stz TimerCount
        cli
    pla
rts
