include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext CharColors_

Color0 equ 5
Color1 equ 6
Color2 equ 2

pDestination equ ZW0
pSource equ ZW1
pVram equ ZW0


InitVram: public InitVram
    lda #Color0 | sta $D020 | sta $D021
    lda #Color1 | sta $D022 | sta $D025
    lda #Color2 | sta $D023 | sta $D026
rts

; void ClearScreen();
cseg
Clear:
    ldx #4
    do
        ldy #0
        do
            sta (<pDestination),y | iny
        while ne | wend
        inc <pDestination+1
        dex
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram | sta <pDestination
        lda #high Vram | sta <pDestination+1
        lda #0
        jsr Clear

        lda #low ColorMap | sta <pDestination
        lda #high ColorMap | sta <pDestination+1
        lda #1
        jsr Clear
    pla
rts


; ptr<byte> VramPtr(byte x, byte y)
dseg
VramPtr_x:
    defb 0
VramPtr_@Param1: public	VramPtr_@Param1
VramPtr_y:
    defb 0
cseg
VramPtr_: public VramPtr_
    pha
        sty VramPtr_x

        lda	VramPtr_y
        asl	a ; *2
        asl	a ; *4
        clc|adc	VramPtr_y ; *5

        ldx #0 | stx <pVram+1
        asl	a | rol <pVram+1 ; *10
        asl	a | rol <pVram+1 ; *20
        asl	a | rol <pVram+1 ; *40

        clc|adc VramPtr_x | sta <pVram | tay
        lda <pVram+1 | adc #0 | tax

        tya | clc|adc #low Vram | tay
        txa | adc #high Vram | tax
	pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_pVram:
    defw 0
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    pha
        sty <pVram | sty Put_pVram
        stx <pVram+1 | stx Put_pVram+1

        lda Put_pVram
        sta <pVram
        lda Put_pVram+1
        sta <pVram+1
        lda Put_c
        ldy #0
        sta (<pVram),y
        tax
        lda <pVram+1
        clc|adc #high(ColorMap-Vram)
        sta <pVram+1
        lda CharColors_,x
        sta (<pVram),y
        
        lda Put_pVram | clc|adc #1 | tay
        lda Put_pVram+1 | adc #0 | tax
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
dseg
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
	defb 0
cseg
CharTable:
    defb " *-/0123456789@ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    pha
        sty <pDestination
        stx <pDestination+1

        lda PrintC_@Param1
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_exit
            inx
            cpx #32
        while ne | wend
        ldx #Char_Space

        PrintC_exit:        
        txa
        ldy #0
        sta (<pDestination),y
        ldy #0
        sta (<pDestination),y
        tax
        lda <pDestination+1
        clc|adc #high(ColorMap-Vram)
        sta <pDestination+1
        lda #1
        sta (<pDestination),y

        lda <pDestination | clc|adc #1 | tay
        lda <pDestination+1 | adc #-high(ColorMap-Vram) | tax
    pla
rts


; byte ReadVram(ptr<byte> pVram);
ReadVram_: public ReadVram_
    sty <pVram | stx <pVram+1
    ldy #0
    lda (<pVram),y
    tay
rts
