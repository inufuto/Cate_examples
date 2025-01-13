include "Vram.inc"
include "ZeroPage.inc"

ext InitSound, SoundHandler
ext Main_

dseg
SaveInt:
    defw 0
denom:
    defb 0
TimerCount: 
    defb 0

cseg
    lda #$30 | sta $D0 ; hide cursor

    lda #ScreenMode | sta $fe07 | sta $282
    lda #low(VramOrg shr 1) | sta $fe02
    lda #high(VramOrg shr 1) | sta $fe03

    ; palette
    lda #$70 | sta $fe08
    lda #$35 | sta $fe09

    jsr InitSound

    sei
        lda #0 | sta TimerCount | sta denom
        lda $0204 | sta SaveInt
        lda $0205 | sta SaveInt+1
        lda #low Handler | sta $0204
        lda #high Handler | sta $0205
        lda #$04 | sta $fe00
    cli
jmp Main_


Handler: public Handler
    pha
        lda $fe00
        and #$04
        if ne
            lda denom
            and #$80
            if eq
                lda denom
                sec
                do 
                    inc TimerCount
                    sbc #50
                while cs | wend
            else
                lda denom
                clc|adc #60
            endif
            sta denom
            jsr SoundHandler
        endif
        ; lda #$f0 | sta $fe00
    pla
jmp (SaveInt)
; jmp $db89
;     cli
; rti


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