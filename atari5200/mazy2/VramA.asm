include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext CharPattern

pVram equ ZW0
pDestination equ ZW0
pSource equ ZW1


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
VramPtr_y:
	defb 0
cseg
VramPtr_: public	VramPtr_
	pha
        lda	VramPtr_y
        asl a | asl a | asl a  ;*8
        sta <pVram | lda #0 | sta <pVram+1
        asl <pVram | rol <pVram+1 ;16
        asl <pVram | rol <pVram+1 ;32
        tya | clc | adc <pVram | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1
        lda <pVram | clc|adc #low Vram | tay
        lda <pVram+1 | adc #high Vram | tax
	pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_@Param1: public Put_@Param1
Put_c:
	defb 0
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
dseg
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
	defb 0
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    pha
        sty <pDestination | stx <pDestination+1
        lda PrintC_@Param1
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
