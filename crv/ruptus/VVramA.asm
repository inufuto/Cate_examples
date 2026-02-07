include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"

ext WaitVdp

wVVram equ ZW0
wVram equ ZW1

; ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pha
        sei
            lda #low VVram | sta VdpWritePort+1
            lda #$40 or high VVram | sta VdpWritePort+1
            lda #Char_Space
            ldy #VVramHeight
            do
                ldx #VVramWidth
                do
                    sta VdpWritePort
                    jsr WaitVdp
                    dex
                while ne | wend
                dey
            while ne | wend
        cli
    pla
rts


; ptr<byte> VVramAddress(byte x, byte y)
zseg
VVramAddress_x:
    defs 1
dseg
VVramAddress_@Param1: public	VVramAddress_@Param1
VVramAddress_y:
    defs 1
cseg
VVramAddress_: public VVramAddress_
    pha
        sty VVramAddress_x

        lda #0 | sta <wVVram+1
        lda	VVramAddress_y
        asl	a ; *2
        clc|adc VVramAddress_y ;*3
        asl	a | rol <wVVram+1 ; *6
        asl	a | rol <wVVram+1 ; *12
        asl	a | rol <wVVram+1 ; *24

        clc|adc VVramAddress_x | tay
        lda <wVVram+1 | adc #0 | tax

        tya | clc|adc #low VVram | tay
        txa | adc #high VVram | tax
	pla
rts


; void VVramToVram();
dseg
RowBuff:
    defs VVramWidth
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVram | sta <wVVram
        lda #high VVram | sta <wVVram+1

        lda #low Vram_PatternName | sta <wVram
        lda #high Vram_PatternName or $40 | sta <wVram+1

        ldy #VVramHeight
        do
            sei
                lda <wVVram | sta VdpWritePort+1
                lda <wVVram+1 | sta VdpWritePort+1
                ldx #0
                do
                    jsr WaitVdp
                    lda VdpReadPort
                    sta RowBuff,x | inx
                    cpx #VVramWidth
                while ne | wend
            cli
            lda <wVVram | clc|adc #VVramWidth | sta <wVVram
            lda <wVVram+1 | adc #0 | sta <wVVram+1
            sei
                lda <wVram | sta VdpWritePort+1
                lda <wVram+1 | sta VdpWritePort+1
                ldx #0
                do
                    lda RowBuff,x | inx
                    sta VdpWritePort
                    jsr WaitVdp
                    cpx #VVramWidth
                while ne | wend
            cli
            lda <wVram | clc|adc #VramWidth | sta <wVram
            lda <wVram+1 | adc #0 | sta <wVram+1

            dey
        while ne | wend
    pla
rts