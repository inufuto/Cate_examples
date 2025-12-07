include "Lynx.inc"
include "ZeroPage.inc"

ext InitVram
ext InitSound,SoundHandler
ext Main_

Interval equ 130
; Interval equ 80

dseg
TimerCount: 
    defb 0

cseg
Startup:
    lda #$08 | sta MAPCTL
	lda #$0d | sta DISPCTL
	lda #$9e | sta TIM0BKUP
	lda #$18 | sta TIM0CTLA
	lda #$68 | sta TlM2BKUP
	lda #$1f | sta TIM2CTLA
	lda #$29 | sta PBKUP

    jsr InitVram
    jsr InitSound
    sei
        lda #low EOI | sta NmiVector
        lda #high EOI | sta NmiVector+1
        lda #low Handler | sta IrqVector
        lda #high Handler | sta IrqVector+1

        lda #Interval-1 | sta TIM1BKUP
        lda #$1e | sta TIM1CTLA
        lda #2-1 | sta TIM3BKUP
        lda #$9f | sta TIM3CTLA
    cli
jmp Main_

Handler: public Handler
    pha
        lda INTSET
        and #$08
        if ne
            sta INTRST
            pha | phx | phy
                inc TimerCount
                jsr SoundHandler
            ply | plx | pla
        endif
    pla
EOI:
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
