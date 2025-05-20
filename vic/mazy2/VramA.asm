include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext BackgroundPattern
ext VVram_

VramTop equ Vram+VramWidth*2
ColorTop equ ColorMap+VramWidth*2

pVVram equ ZW0
pVram equ ZW1
pColor equ ZW2
yCount equ ZB0
pSource equ ZW0
pDestination equ ZW1

dseg
CharColors: public CharColors
    defs Char_End


cseg
ColorSource:
defb 30,1 ; Space
defb 6,1 ; Man
defb 36,2 ; Monster
defb 24,1 ; Knife
defb 24,1 ; Point
defb 12,1 ; Message
defb 7,3 ; SW2
defb 60,1 ; D00D010
defb 27,7 ; G01W4
defb 0
InitVram: public InitVram
    ldx #0 | ldy #0
    do
        lda ColorSource,x
    while ne
        sta <yCount
        inx
        lda ColorSource,x | inx
        do
            sta CharColors,y | iny
            dec <yCount
        while ne | wend
    wend

    ldx #0 | txa
    do
        sta PatternRam,x | inx
        cpx CharHeight
    while ne | wend

    
    lda #low BackgroundPattern | sta <pSource
    lda #high BackgroundPattern | sta <pSource+1

    lda #low(PatternRam+CharHeight*Char_Background) | sta <pDestination
    lda #high(PatternRam+CharHeight*Char_Background) | sta <pDestination+1
    
    ldx #Char_End-Char_Background
    do
        ldy #0
        do
            lda (<pSource),y
            sta (<pDestination),y
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
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram | sta <pVram
        lda #high Vram | sta <pVram+1
        ldx #VramHeight
        do
            ldy #0 | tya
            do
                sta (<pVram),y | iny
                cpy #VramWidth
            while ne | wend
            lda <pVram | clc|adc #low VramWidth | sta <pVram
            lda <pVram+1 | adc #high VramWidth | sta <pVram+1
            dex
        while ne | wend

        lda #low ColorMap | sta <pVram
        lda #high ColorMap | sta <pVram+1
        ldx #VramHeight
        do
            ldy #0 | lda #1
            do
                sta (<pVram),y | iny
                cpy #VramWidth
            while ne | wend
            lda <pVram | clc|adc #low VramWidth | sta <pVram
            lda <pVram+1 | adc #high VramWidth | sta <pVram+1
            dex
        while ne | wend

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        ldx #VVramHeight
        do
            ldy #0 | tya
            do
                sta (<pVVram),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            dex
        while ne | wend
    pla
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    lda #low VVram_ | sta <pVVram
    lda #high VVram_ | sta <pVVram+1

    lda #low VramTop | sta <pVram
    lda #high VramTop | sta <pVram+1
    lda #low ColorTop | sta <pColor
    lda #high ColorTop | sta <pColor+1

    lda #VVramHeight
    sta <yCount
    do
        ldy #0
        do
            lda (<pVVram),y
            sta (<pVram),y
            tax
            lda CharColors,x
            sta (<pColor),y
            iny
            cpy #VVramWidth
        while ne | wend
        lda <pVVram | clc | adc #VVramWidth | sta <pVVram
        lda <pVVram+1 | adc #0 | sta <pVVram+1

        lda <pVram | clc | adc #VramWidth | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1

        lda <pColor | clc | adc #VramWidth | sta <pColor
        lda <pColor+1 | adc #0 | sta <pColor+1

        dec <yCount
    while ne | wend
rts
