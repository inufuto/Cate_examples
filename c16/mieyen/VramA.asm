include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern,ColorPattern

Color0 equ 53
Color1 equ 77
Color2 equ 59

VramTop equ Vram+VramRowSize*1
ColorMapTop equ ColorMap+VramRowSize*1

pDestination equ ZW0
pSource equ ZW1
pColorMap equ ZW2
xCount equ ZB0
yCount equ ZB1
source equ ZB2
destination equ ZB3
sourceOffset equ ZB4
destinationOffset equ ZB5

dseg
CharColors: public CharColors
    defs Char_End


cseg
ColorSource:
defb 64,113 and $f7 ; Ascii
defb 16,70 and $f7 ; Logo
defb 16,38 and $f7 ; Wall
defb 4,87 and $f7 ; Dot
defb 32,113 or $08 ; Man
defb 32,84 or $08 ; Monster
defb 4,82 or $08 ; FireBullet
defb 4,82 or $08 ; Fire
defb 4,103 or $08 ; Food
defb 0
InitVram: public InitVram
    lda #Color0 | sta $FF15 | sta $FF19
    lda #Color1 | sta $FF16
    lda #Color2 | sta $FF17

    ldx #0 | ldy #0
    do
        lda ColorSource,x
    while ne
        inx
        sta <yCount
        lda ColorSource,x | inx
        do
            sta CharColors,y | iny
            dec <yCount
        while ne | wend
    wend


    lda #low MonoPattern | sta <pSource
    lda #high MonoPattern | sta <pSource+1

    lda #low PatternRam | sta <pDestination
    lda #high PatternRam | sta <pDestination+1

    ldx #Char_Color | stx <yCount
    do
        ldy #0 | sty <sourceOffset | sty <destinationOffset
        do
            ldy <sourceOffset
            lda (<pSource),y | sta <source | iny | sty <sourceOffset
            lda #2 | sta <xCount
            do
                lda #0 | sta <destination
                ldx #4
                do
                    lda <destination
                    asl a | asl a
                    asl <source
                    if cs
                        ora #$03
                    endif
                    sta <destination

                    dex
                while ne | wend
                ldy <destinationOffset | sta (<pDestination),y | iny | sty <destinationOffset

                dec <xCount
            while ne | wend
            cpy #CharHeight
        while ne | wend
        lda <pSource | clc|adc #CharHeight/2 | sta <pSource
        lda <pSource+1 | adc #0 | sta <pSource+1

        lda <pDestination | clc|adc #CharHeight | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1

        dec <yCount
    while ne | wend


    lda #low ColorPattern | sta <pSource
    lda #high ColorPattern | sta <pSource+1

    lda #low(PatternRam+CharHeight*Char_Color) | sta <pDestination
    lda #high(PatternRam+CharHeight*Char_Color) | sta <pDestination+1

    ldx #Char_End-Char_Color
    do
        ldy #0
        do
            lda (<pSource),y | sta (<pDestination),y
            iny
            cpy #CharHeight
        while ne | wend
        lda <pSource | clc|adc #low CharHeight | sta <pSource
        lda <pSource+1 | adc #high CharHeight | sta <pSource+1

        lda <pDestination | clc|adc #low CharHeight | sta <pDestination
        lda <pDestination+1 | adc #high CharHeight | sta <pDestination+1

        dex
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram | sta <pDestination
        lda #high Vram | sta <pDestination+1
        lda #0
        ldx #4
        do
            ldy #0
            do
                sta (<pDestination),y | iny
            while ne | wend
            inc <pDestination+1
            dex
        while ne | wend

        lda #low VVramBack_ | sta <pDestination
        lda #high VVramBack_ | sta <pDestination+1
        ldx #VVramHeight*2
        do
            ldy #0 | tya
            do
                sta (<pDestination),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pDestination | clc|adc #VVramWidth | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1
            dex
        while ne | wend
    pla
rts


; void Put(ptr<byte>, byte c);
dseg
Put_pVram:
    defw 0
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    pha
        sty Put_pVram | sty <pDestination
        stx Put_pVram+1 | stx <pDestination+1
        lda Put_c
        ldy #0
        sta (<pDestination),y
        tax
        lda <pDestination+1
        clc|adc #high(ColorMap-Vram)
        sta <pDestination+1
        lda CharColors,x
        sta (<pDestination),y

        lda Put_pVram | clc|adc #1 | tay
        lda Put_pVram+1 | adc #0 | tax
    pla
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVramFront_ | sta <pSource
        lda #high VVramFront_ | sta <pSource+1
        lda #low VramTop | sta <pDestination
        lda #high VramTop | sta <pDestination+1
        lda #low ColorMapTop | sta <pColorMap
        lda #high ColorMapTop | sta <pColorMap+1
        lda #VVramHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pSource),y
                sta (<pDestination),y
                tax
                lda CharColors,x
                sta (<pColorMap),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pSource | clc | adc #low VVramWidth | sta <pSource
            lda <pSource+1 | adc #high VVramWidth | sta <pSource+1
            lda <pDestination | clc | adc #low VramWidth | sta <pDestination
            lda <pDestination+1 | adc #high VramWidth | sta <pDestination+1
            lda <pColorMap | clc | adc #low VramWidth | sta <pColorMap
            lda <pColorMap+1 | adc #high VramWidth | sta <pColorMap+1

            dec <yCount
        while ne | wend
    pla
rts
