include "Atari7800.inc"
include "ZeroPage.inc"
include "Vram.inc"

pVram equ ZW1

cseg
PaletteValues:
	defb	$c4, $86, $34, $6c, $f5, $0f, $fb, $99
	defb	$f5, $37, $29, $db, $0b, $00, $39, $4b
InitVram: public InitVram
    ldx PaletteValues | stx <BACKGRND
    do
        txa | and #3
        if ne
            lda PaletteValues,x
            sta <BACKGRND,x
        endif
        inx
        cpx #16
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram | sta <pVram
        lda #high Vram | sta <pVram+1
        ldx #VramHeight
        do
            lda #0 | tay
            do
                sta (<pVram),y | iny
                cpy #VramWidth
            while ne | wend
            lda <pVram | clc|adc #VramWidth | sta <pVram
            lda <pVram+1 | adc #0 | sta <pVram+1
            dex
        while ne | wend
    pla
rts


; ptr<byte> VramPtr(byte x, byte y)
dseg
VramPtr_@Param1: public	VramPtr_@Param1
    defs 1
cseg
VramPtr_: public VramPtr_
    pha
        lda	VramPtr_@Param1
        asl	a ; *2
        asl	a ; *4
        sta <pVram
        lda #0 | sta <pVram+1
        asl	<pVram | rol <pVram+1 ; *8
        asl	<pVram | rol <pVram+1 ; *16
        asl	<pVram | rol <pVram+1 ; *32

        tya | clc|adc <pVram | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1

        lda <pVram | clc|adc #low Vram | tay
        lda <pVram+1 | adc #high Vram | tax
	pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Put_c:
	defs 1
cseg
Put_: public Put_
    pha
        sty <pVram | stx <pVram+1
        lda Put_c | asl a
        ldy #0 | sta (<pVram),y
        lda <pVram | clc|adc #1 | tay
        lda <pVram+1 | adc #0 | tax
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " *+-/0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    pha
        sty <pVram | stx <pVram+1
        lda Put_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_exit
            inx
            cpx #32
        while ne | wend
        ldx #0
        PrintC_exit:        
        txa | asl a
        ldy #0 | sta (<pVram),y
        lda <pVram | clc|adc #1 | tay
        lda <pVram+1 | adc #0 | tax
    pla
rts


; byte ReadVram(ptr<byte> pVram);
ReadVram_: public ReadVram_
    pha
        sty <pVram | stx <pVram+1
        ldy #0
        lda (<pVram),y
        lsr a
        tay
    pla
rts
