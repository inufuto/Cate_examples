include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern,SpritePattern
ext VVram_

Color0 equ $0
Color1 equ $6
Color2 equ $5


dseg
CharColors: public CharColors
    defs Char_End
TerrainCharOffset: public TerrainCharOffset
    defb 0

scope
pSource equ ZW0
pDestination equ ZW1
xCount equ ZB0
yCount equ ZB1
source equ ZB2
destination equ ZB3
sourceOffset equ ZB4
destinationOffset equ ZB5
cseg
ColorSource:
defb 32,1 ; Ascii
defb 15,3 ; Logo
defb 1,1 ; Remain
defb 12,1 ; Terrain01
defb 11,3 ; Terrain03
defb 5,7 ; Terrain07
defb 12,1 ; Terrain11
defb 11,3 ; Terrain13
defb 5,7 ; Terrain17
defb 84,3 ; Fort
defb 0
InitVram: public InitVram
    lda #Color0 | sta $D020 | sta $D021
    lda #Color1 | sta $D022
    lda #Color2 | sta $D023
    ; lda #$f | sta $D024

    ldx #0 | ldy #0
    do
        lda ColorSource,x
    while ne
        inx
        sta yCount
        lda ColorSource,x | inx
        ora #$08
        do
            sta CharColors,y | iny
            dec yCount
        while ne | wend
    wend


    lda #low MonoPattern | sta pSource
    lda #high MonoPattern | sta pSource+1

    lda #low PatternRam | sta pDestination
    lda #high PatternRam | sta pDestination+1

    ldx #Char_Color | stx yCount
    do
        ldy #0 | sty sourceOffset | sty destinationOffset
        do
            ldy sourceOffset
            lda (pSource),y | sta source | iny | sty sourceOffset
            lda #2 | sta xCount
            do
                lda #0 | sta destination
                ldx #4
                do
                    lda destination
                    asl a | asl a
                    asl source
                    if cs
                        ora #$03
                    endif
                    sta destination

                    dex
                while ne | wend
                ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset

                dec xCount
            while ne | wend
            cpy #CharHeight
        while ne | wend
        lda pSource | clc|adc #CharHeight/2 | sta pSource
        lda pSource+1 | adc #0 | sta pSource+1

        lda pDestination | clc|adc #CharHeight | sta pDestination
        lda pDestination+1 | adc #0 | sta pDestination+1

        dec yCount
    while ne | wend


    ; lda #low ColorPattern | sta pSource
    ; lda #high ColorPattern | sta pSource+1

    ; lda #low(PatternRam+CharHeight*Char_Color) | sta pDestination
    ; lda #high(PatternRam+CharHeight*Char_Color) | sta pDestination+1

    ; ldx #Char_End-Char_Color
    ; do
    ;     ldy #0
    ;     do
    ;         lda (pSource),y | sta (pDestination),y
    ;         iny
    ;         cpy #CharHeight
    ;     while ne | wend
    ;     lda pSource | clc|adc #low CharHeight | sta pSource
    ;     lda pSource+1 | adc #high CharHeight | sta pSource+1

    ;     lda pDestination | clc|adc #low CharHeight | sta pDestination
    ;     lda pDestination+1 | adc #high CharHeight | sta pDestination+1

    ;     dex
    ; while ne | wend


    lda #low SpritePattern | sta pSource
    lda #high SpritePattern | sta pSource+1

    lda #low(VicRam+SpriteSize*128) | sta pDestination
    lda #high(VicRam+SpriteSize*128) | sta pDestination+1
    lda #Pattern_End-128 | sta yCount
    do
        ldy #0 | sty sourceOffset | sty destinationOffset 
        do
            ldx #2
            do
                ldy sourceOffset | lda (pSource),y | iny | sty sourceOffset
                ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset
                dex
            while ne | wend
            lda #0
            sta (pDestination),y | iny | sty destinationOffset
            cpy #48
        while ne | wend
        lda #0
        do
            sta (pDestination),y | iny
            cpy #SpriteSize
        while ne | wend
        lda pSource | clc|adc #low 32 | sta pSource
        lda pSource+1 | adc #high 32 | sta pSource+1

        lda pDestination | clc|adc #low SpriteSize | sta pDestination
        lda pDestination+1 | adc #high SpriteSize | sta pDestination+1

        dec yCount
    while ne | wend
rts
endscope

scope
pDestination equ ZW0
; void ClearScreen();
cseg
Clear:
    ldx #4
    do
        ldy #0
        do
            sta (pDestination),y | iny
        while ne | wend
        inc pDestination+1
        dex
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram | sta pDestination
        lda #high Vram | sta pDestination+1
        lda #0
        jsr Clear

        lda #low ColorMap | sta pDestination
        lda #high ColorMap | sta pDestination+1
        lda #1
        jsr Clear

        lda #0 | sta TerrainCharOffset
    pla
rts
endscope


scope
dseg
Put_@Param1: public Put_@Param1
Put_c:
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
    defb 0
zseg
pVram equ ZW0
cseg
Put:
    lda Put_c
    ldy #0 | sta (pVram),y
    tax
    lda pVram+1
    clc|adc #high(ColorMap-Vram)
    sta pVram+1
    lda CharColors,x
    sta (pVram),y
    
    lda pVram | clc|adc #1 | tay
    lda pVram+1 | adc #-high(ColorMap-Vram) | tax
rts

; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    pha
        sty pVram | stx pVram+1
        jsr Put
    pla
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " '-0123456789ACEFGHIKMNOPRSTUVYZ"
PrintC_: public PrintC_
    pha
        sty pVram | stx pVram+1
        lda PrintC_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_exit
            inx
            cpx #32
        while ne | wend
        ldx #Char_Space
        PrintC_exit:
        stx Put_c
        jsr Put
    pla
rts
endscope


scope
TerrainCharCount equ Char_Terrain1-Char_Terrain0
zseg
pSource equ ZW0
pDestination equ ZW1
pColorMap equ ZW2
yCount equ ZB0
; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVram_ | sta pSource
        lda #high VVram_ | sta pSource+1
        lda #low Vram | sta pDestination
        lda #high Vram | sta pDestination+1
        lda #low ColorMap | sta pColorMap
        lda #high ColorMap | sta pColorMap+1
        lda #VramHeight | sta <yCount
        do
            ldy #0
            do
                lda (pSource),y
                sta (pDestination),y
                tax
                lda CharColors,x
                sta (pColorMap),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda pSource | clc | adc #low VVramWidth | sta pSource
            if cs
                inc pSource+1
            endif
            lda pDestination | clc | adc #low VramWidth | sta pDestination
            if cs
                inc pDestination+1
            endif
            lda pColorMap | clc | adc #low VramWidth | sta pColorMap
            if cs
                inc pColorMap+1
            endif

            dec <yCount
        while ne | wend

        lda TerrainCharOffset
        eor #TerrainCharCount
        sta TerrainCharOffset
    pla
rts
endscope
