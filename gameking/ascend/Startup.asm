include "GameKing.inc"

ext Main_
ext InitSound,SoundHandler

dseg
TimerCount: 
    defb 0
Denom:
    defb 0


cseg
Startup: public Startup
    stz TimerCount
    stz Denom
    
    lda #low Handler | sta $92
    lda #high Handler | sta $93
    lda Bank4Port | sta $94
    lda ExtRom4Port | sta $95
    lda $8f | ora #$02 | sta $8f
    lda #$18 | sta Timer2Port
    lda #$08 | sta InterruptEnablePort

    ; lda #$36 or $80 | sta $16
    ; lda #$77 | sta $17
    ; lda #$c8 | sta $12
    ; lda #$0d | sta $13
    jsr InitSound
jmp Main_


Handler: public Handler
    pha
        lda Denom
        sec|sbc #60
        if cc
            adc #128
            pha
                inc TimerCount
                jsr SoundHandler
            pla
        endif
        sta Denom
    pla
rts


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