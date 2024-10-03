include "GameKing.inc"
include "ZeroPage.inc"
include "Vram.inc"

ext AsciiPattern, SpritePattern
ext DrawSprites

VramSize equ VramRowSize*VramHeight
LcdBottom equ $0200
LcdTop equ LcdBottom+VramSize-VramWidth
AsciiHeight equ 5

dseg
Vram_: public Vram_
    defs VramSize
StatusPane_: public StatusPane_
    defs VramWidth*AsciiHeight
SpriteLayer: public SpriteLayer
    defs VramSize
Param_pVram:
    defw 0
PrintC_@Param1: public PrintC_@Param1
Put_@Param1: public Put_@Param1
Param_c:
    defb 0
Put_@Param2: public Put_@Param2
Param_right:
    defb 0


pSource equ ZW0
pDestination equ ZW1
charWord equ ZW2
pUpper equ ZW3
pLower equ ZW0
charOffset equ ZB0
vramOffset equ ZB1


; ptr<byte> VramPtr(byte x, byte y);
dseg
VramPtr_@Param1: public VramPtr_@Param1
VramPtr_y:
	defs 1
cseg
VramPtr_: public VramPtr_
	pha
        lda	VramPtr_y
        asl a ;*2
        clc|adc VramPtr_y ;*3
        stz <pDestination+1
        asl a | rol <pDestination+1 ;*6
        asl a | rol <pDestination+1 ;*12
        asl a | rol <pDestination+1 ;*24
        sta <pDestination
        tya | lsr a
        clc|adc <pDestination | tay
        lda <pDestination+1 | adc #0 | tax
        tya | clc|adc #low Vram_ | tay
        txa | adc #high Vram_ | tax
	pla
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram_ | sta <pDestination
        lda #high Vram_ | sta <pDestination+1
        ldx #VramHeight*(CharHeight+AsciiHeight*2)
        do
            ldy #0 | tya
            do
                sta (<pDestination),y
                iny
                cpy #VramWidth
            while ne | wend
            lda <pDestination | clc|adc #VramWidth | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1
            dex
        while ne | wend
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " 0123456789ABCDEFGHIJKLMNOPQRSTUVWYXZ"
PrintC_: public PrintC_
    pha
        sty Param_pVram | sty <pDestination
        stx Param_pVram+1 | stx <pDestination+1

        lda Param_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_break
            inx
            cpx #37
        while ne | wend
        ldx #0
        PrintC_break:
        txa
        sta <pSource
        asl a ;*2
        asl a ;*4
        adc <pSource ;*5
        adc #low AsciiPattern | sta <pSource
        lda #0 | adc #high AsciiPattern | sta <pSource+1

        stz <charOffset | stz <vramOffset
        ldx #AsciiHeight
        do
            ldy <charOffset
            lda (<pSource),y
            iny | sty <charOffset
            ldy <vramOffset | sta (<pDestination),y
            tya | clc|adc #VramWidth | sta <vramOffset
            dex
        while ne | wend
        ldy Param_pVram | ldx Param_pVram+1
        iny
        if eq
            inx
        endif
    pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c, bool right);
cseg
Put_: public Put_
    pha
        sty Param_pVram | sty <pDestination
        stx Param_pVram+1 | stx <pDestination+1
        lda Param_c
        ldx Param_right
        if eq
            tay
            and #$f0 | sta <charWord
            tya
            asl a | asl a | asl a | asl a | sta <charWord+1
            lda (<pDestination)
            and #$0f | ora <charWord
            sta (<pDestination)
            ldy #VramWidth
            lda (<pDestination),y
            and #$0f | ora <charWord+1
            sta (<pDestination),y
            ldy Param_pVram | ldx Param_pVram+1
        else
            tay
            lsr a | lsr a | lsr a | lsr a | sta <charWord
            tya
            and #$0f | sta <charWord+1
            lda (<pDestination)
            and #$f0 | ora <charWord
            sta (<pDestination)
            ldy #VramWidth
            lda (<pDestination),y
            and #$f0 | ora <charWord+1
            sta (<pDestination),y
            ldy Param_pVram | ldx Param_pVram+1
            ldy Param_pVram | ldx Param_pVram+1
            iny
            if eq
                inx
            endif
        endif
    pla
rts


; void PresentVram();
cseg
PresentVram_: public PresentVram_
    pha
        lda #low Vram_ | sta <pSource
        lda #high Vram_ | sta <pSource+1
        lda #low SpriteLayer | sta <pDestination
        lda #high SpriteLayer | sta <pDestination+1
        ldx #VramHeight*CharHeight/16
        do
            ldy #0
            do
                lda (<pSource),y
                sta (<pDestination),y
                iny
                cpy #VramWidth*16
            while ne | wend
            lda <pSource | clc|adc #VramWidth*16 | sta <pSource
            lda <pSource+1 | adc #0 | sta <pSource+1
            lda <pDestination | clc|adc #VramWidth*16 | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1
            dex
        while ne | wend

        jsr DrawSprites

        lda #low StatusPane_ | sta <pSource
        lda #high StatusPane_ | sta <pSource+1
        lda #low SpriteLayer | sta <pDestination
        lda #high SpriteLayer | sta <pDestination+1
        ldy #0
        do
            lda (<pDestination),y
            ora (<pSource),y
            sta (<pDestination),y
            iny
            cpy #VramWidth*AsciiHeight
        while ne | wend

        lda #low SpriteLayer | sta <pSource
        lda #high SpriteLayer | sta <pSource+1
        lda #low LcdTop | sta <pDestination
        lda #high LcdTop | sta <pDestination+1
        ldx #VramHeight*CharHeight
        do
            ldy #0
            do
                lda (<pSource),y
                sta (<pDestination),y
                iny
                cpy #VramWidth
            while ne | wend
            lda <pSource | clc|adc #VramWidth | sta <pSource
            lda <pSource+1 | adc #0 | sta <pSource+1
            lda <pDestination | sec|sbc #VramWidth | sta <pDestination
            lda <pDestination+1 | sbc #0 | sta <pDestination+1
            dex
        while ne | wend
    pla
rts
