include "Vram.inc"
include "ZeroPage.inc"

ext InitVram
ext InitSound, SoundHandler
ext Main_


dseg
IntSave defw 0 
TimerCount defw 0

cseg
    lda $9000
    ; sta RegSave0
    and #$08 | ora #$02 | sta $9000   ; horizontal centering

    ; lda $9002
    ; sta RegSave2
    lda #VramWidth | sta $9002   ; set # of columns, bit 7 is part of screen address

    ; lda $9003
    ; sta RegSave3
    lda #(VramHeight shl 1) | sta $9003   ; set # of rows

    ; lda $9005
    ; sta RegSave5
    lda #$cd | sta $9005   ; bits 0-3 start of character memory / bits 4-7 is rest of video address

    ; lda $900e
    ; sta RegSaveE
    lda #$27 | sta $900E   ; bit 0-3 sets volume of all sound / bits 4-7 are auxiliary color information

    ; lda $900f
    ; sta RegSaveF
    lda #$06+8 | sta $900F   ; Screen and border color register

    jsr InitVram
    jsr InitSound

    sei
        lda #0 | sta TimerCount
        lda $0314
        sta IntSave
        lda $0315
        sta IntSave+1
        lda #low Handler
        sta $0314
        lda #high Handler
        sta $0315
    cli

jmp Main_


Handler:
    inc TimerCount
    jsr SoundHandler
jmp (IntSave)


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