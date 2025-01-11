include "Vram.inc"
include "ZeroPage.inc"

ext InitVram
ext InitSound, SoundHandler
ext Main_

CINV  equ $0314

dseg
IrqJump:
    defs 3
TimerCount: 
    defb 0
Rate:
    defb 0
Denom:
    defb 0

cseg
    ; mode
    lda #$1b | sta $ff00+6
    lda $ff00+7 | and #$40 | ora #$98 | sta $ff00+7

    ; charactor table
    lda #$c0 | sta $ff00+18
    lda #$10 | sta $ff00+19
    
    ; colors
    lda #$00 | sta $ff00+21
    lda #$0 | sta $ff00+25

    jsr InitVram
    jsr InitSound
    lda #0
    sta Denom
    sta TimerCount

    ; interrupt
    lda $ff00+7 | and #$40
    if eq
        ; PAL
        lda #60
    else
        ; NTSC
        lda #50
    endif
    sta Rate

    lda #$4c | sta IrqJump   ; jmp
    lda CINV  | sta IrqJump+1
    lda CINV +1 | sta IrqJump+2
    sei
        lda #low Handler | sta CINV 
        lda #high Handler | sta CINV +1
        lda #$02 | sta $ff00+10 ; Raster interrupt enable
        lda #192 | sta $ff00+11
    cli
jmp Main_


Handler: public Handler
    pha
        lda $ff00+9
        and #$02
        if ne
            lda Denom
            sec|sbc Rate
            do | while mi
                pha
                    inc TimerCount
                    jsr SoundHandler
                pla
                clc|adc #50
            wend
            sta Denom
        endif
    pla
jmp IrqJump


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