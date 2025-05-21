include "Vram.inc"
include "ZeroPage.inc"

ext UpdateSprites
ext InitSound, SoundHandler
ext InitSprites
ext InitVram
ext Main_

Interval equ $4295

dseg
TimerCount: 
    defb 0

cseg
VicValues:
    defb $1d,$ff,$0,$0,$ff,$c8,$0,$1c
    defb $ff,$1,$0,$0,$0,$0,$0,$0,$0

Startup: public Startup
    sei
        ldx #0 | txs
        do
            lda VicValues,x
            sta $d011,x
            inx
            cpx #17
        while ne | wend
        jsr InitSprites
    cli
    lda $D016 | ora #$10 | sta $D016 ; Multicolor 
    jsr InitVram
                                
    lda #0 | sta TimerCount

    sei
        lda #low Interval
        sta $DC04
        lda #high Interval
        sta $DC05
        lda #$7e | sta $DC0D
        lda #$81 | sta $DC0D
        lda #$11 | sta $DC0E
    cli

    jsr InitSound
jmp Main_


IrqHandler: public IrqHandler
    pha
    txa | pha
    tya | pha
        lda $D019
        and #$01
        if ne
            sta $D019
            jsr UpdateSprites
        endif
        lda $DC0D
        and #$01
        if ne
            inc TimerCount
            jsr SoundHandler
        endif
    pla | tay
    pla | tax
    pla
rti
; jmp (IrqSave)


NmiHandler: public NmiHandler
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