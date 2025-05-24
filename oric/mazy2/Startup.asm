include "Vram.inc"
include "ZeroPage.inc"

ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: 
    defb 0
Denom:
    defb 0


; void Init();
cseg
    lda #0
    sta Denom
    sta TimerCount

    jsr InitVram
    jsr InitSound

    sei
        lda $230
        cmp #$40
        if eq
            ; V1.0
            lda #$4c ; jmp
            sta $228
            lda #low Handler
            sta $228+1
            lda #high Handler
            sta $228+2
        else
            ; V1.1
            lda #$4c ; jmp
            sta $244
            lda #low Handler
            sta $244+1
            lda #high Handler
            sta $244+2
        endif
    cli
jmp Main_


Handler:
    pha
        lda $30d
        and #$40
        if ne
            sta $30d

            lda Denom
            sec|sbc #60
            if cc
                adc #100
                pha
                    inc TimerCount
                    jsr SoundHandler
                pla
            endif
            sta Denom
        endif
    pla
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