include "Zeropage.inc"
include "Atari800.inc"
include "Vram.inc"
include "Chars.inc"

ext CharPattern

pVram equ ZW0
pSource equ Zw0
pDestination equ Zw1


cseg
InitVram: public InitVram
    lda #low CharRam | sta <pDestination
    lda #high CharRam | sta <pDestination+1
    lda #low CharPattern | sta <pSource
    lda #high CharPattern | sta <pSource+1

    ldx #Char_End
    do
        ldy #0
        do
            lda (<pSource),y
            sta (pDestination),y
            iny
            cpy #CharHeight
        while ne | wend
        lda <pSource | clc|adc #CharHeight | sta <pSource
        lda <pSource+1 | adc #0 | sta <pSource+1

        lda <pDestination | clc|adc #CharHeight | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1

        dex
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram | sta <pDestination
        lda #high Vram | sta <pDestination+1
        ldx #VramHeight+2
        do
            lda #Char_Space
            ldy #0
            do
                sta (<pDestination),y
                iny
                cpy #VramWidth
            while ne | wend

            lda <pDestination | clc | adc #low VramWidth | sta <pDestination
            lda <pDestination+1 | adc #high VramWidth | sta <pDestination+1
            dex
        while ne | wend
    pla
rts


; ptr<byte> VramPtr(byte x, byte y);
dseg
VramPtr_@Param1: public	VramPtr_@Param1
VramPtr_y:	defs 1
cseg
VramPtr_: public	VramPtr_
	pha
        lda	VramPtr_y
        asl a | asl a | asl a  ;*8
        sta <ZW0 | lda #0 | sta <ZW0+1
        asl <ZW0 | rol <ZW0+1 ;16
        asl <ZW0 | rol <ZW0+1 ;32
        tya | clc | adc <ZW0 | sta <ZW0
        lda <ZW0+1 | adc #0 | sta <ZW0+1
        lda <ZW0 | clc|adc #low Vram | tay
        lda <ZW0+1 | adc #high Vram | tax
	pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_@Param1: public Put_@Param1
Put_c:
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
	defs 1
cseg
Put_: public Put_
    pha
        sty <pDestination | stx <pDestination+1
        lda Put_c
        ldy #0
        sta (<pDestination),y
        lda <pDestination | clc|adc #1 | tay
        lda <pDestination+1 | adc #0 | tax
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    pha
        sty <pDestination | stx <pDestination+1
        lda PrintC_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_exit
            inx
            cpx #29
        while ne | wend
        ldx #Char_Space
        PrintC_exit:        
        txa
        ora #$80
        ldy #0
        sta (<pDestination),y

        lda <pDestination | clc|adc #1 | tay
        lda <pDestination+1 | adc #0 | tax
    pla
rts


; byte ReadVram(ptr<byte> pVram);
ReadVram_: public ReadVram_
    sty <pVram | stx <pVram+1
    ldy #0
    lda (<pVram),y
    tay
rts
