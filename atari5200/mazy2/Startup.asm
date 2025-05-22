include "atari5200.inc"
include "Vram.inc"
include "ZeroPage.inc"

ext InitVram
ext InitSound, SoundHandler
ext DisplayList
ext UpdateSprites, DisplayListHandler, InitSprites
ext Main_

dseg
NmiJump1:
    defs 3
NmiJump2:
    defs 3
TimerCount: 
    defb 0
busy:
    defb 0
CHBAS: public CHBAS
    defb 0


cseg
Startup_: public Startup_
    jsr InitSprites
    jsr InitVram

    lda #4 | sta CONSOL
    lda #low DisplayList | sta SDLSTL
    lda #high DisplayList | sta SDLSTH
    lda #$39 | sta SDMCTL | sta DMACTL
    lda #high CharRam | sta CHBAS
    lda #3 | sta GRACTL
    lda #$11 | sta PRIOR    ; GPRIOR

    ldx #0
    do
        lda Colors,x
        sta COLOR0,x
        inx
        cpx #5
    while ne | wend

    jsr InitSound
    lda #0 | sta TimerCount

    lda #$4c | sta NmiJump1 | sta NmiJump2  ; jmp
    lda VVBLKI  | sta NmiJump1+1
    lda VVBLKI+1 | sta NmiJump1+2
    lda #low VBlankHandler1 | sta VVBLKI
    lda #high VBlankHandler1 | sta VVBLKI+1
    lda VVBLKD  | sta NmiJump2+1
    lda VVBLKD+1 | sta NmiJump2+2
    lda #low VBlankHandler2 | sta VVBLKD
    lda #high VBlankHandler2 | sta VVBLKD+1

    sei
        lda #low DisplayListHandler | sta VDSLST
        lda #high DisplayListHandler | sta VDSLST+1
    cli
    lda #$c0 | sta NMIEN
jmp Main_
Colors:
defb $9c ; 708 01
defb $0a ; 709 10
defb $1e ; 710 11
defb $0f ; 711 11 or $80
defb $00 ; 712 00

VBlankHandler1: public VBlankHandler1
    pha
        lda CHBAS | sta CHBASE
    pla
jmp NmiJump1

VBlankHandler2: public VBlankHandler2
    pha
    txa | pha
    tya | pha
        inc TimerCount
        jsr SoundHandler
        jsr UpdateSprites
    pla | tay
    pla | tax
    pla
jmp NmiJump2


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