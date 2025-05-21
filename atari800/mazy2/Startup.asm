include "atari800.inc"
include "Vram.inc"
include "ZeroPage.inc"

ext InitVram
ext InitSound, SoundHandler
ext DisplayList
ext UpdateSprites, DisplayListHandler, InitSprites
ext Main_

dseg
NmiJump:
    defs 3
TimerCount: 
    defb 0
busy:
    defb 0


cseg
Startup_: public Startup_
    jsr InitSprites

    lda #low DisplayList | sta SDLSTL
    lda #high DisplayList | sta SDLSTH

    lda #$39 | sta SDMCTL | sta DMACTL
    lda #high CharRam | sta CHBAS
    lda #3 | sta GRACTL
    lda #$11 | sta GPRIOR

    ldx #0
    do
        lda Colors,x
        sta COLOR0,x
        inx
        cpx #5
    while ne | wend

    jsr InitVram
    jsr InitSound
    lda #0 | sta TimerCount

    lda #$4c | sta NmiJump   ; jmp
    lda VVBLKD  | sta NmiJump+1
    lda VVBLKD+1 | sta NmiJump+2

    lda #7
    ldy #low VBlankHandler
    ldx #high VBlankHandler
    jsr SETVBV

    sei
        lda #low DisplayListHandler | sta VDSLST
        lda #high DisplayListHandler | sta VDSLST+1
        lda #$c0 | sta NMIEN
    cli
jmp Main_
Colors:
defb $9c ; 708 01
defb $0a ; 709 10
defb $1e ; 710 11
defb $0f ; 711 11 or $80
defb $00 ; 712 00


VBlankHandler: public VBlankHandler
    pha
    txa | pha
    tya | pha
        inc TimerCount
        jsr SoundHandler
        jsr UpdateSprites
    pla | tay
    pla | tax
    pla
jmp NmiJump
; jmp XITVBV


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