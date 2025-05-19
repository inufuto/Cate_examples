include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern,ColorPattern,SpritePattern

Color0 equ $0
Color1 equ $e
Color2 equ $1

pDestination equ ZW0
pSource equ ZW1
pVram equ ZW0
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
defb 64,1 ; Ascii
defb 16,3 ; Logo
defb 1,3 ; Knife
defb 8,6 ; Stair
defb 4,7 ; Goal
defb 4,2 ; Remain
defb 0
InitVram: public InitVram
    lda #Color0 | sta $D020 | sta $D021
    lda #Color1 | sta $D022 | sta $D025
    lda #Color2 | sta $D023 | sta $D026
    ; lda #$f | sta $D024

    ldx #0 | ldy #0
    do
        lda ColorSource,x
    while ne
        inx
        sta <yCount
        lda ColorSource,x | inx
        ora #$08
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


    lda #low SpritePattern | sta <pSource
    lda #high SpritePattern | sta <pSource+1

    lda #low(VicRam+SpriteSize*128) | sta <pDestination
    lda #high(VicRam+SpriteSize*128) | sta <pDestination+1
    lda #Pattern_End-128 | sta <yCount
    do
        ldy #0 | sty <sourceOffset | sty <destinationOffset 
        do
            ldx #2
            do
                ldy <sourceOffset | lda (<pSource),y | iny | sty <sourceOffset
                ldy <destinationOffset | sta (<pDestination),y | iny | sty <destinationOffset
                dex
            while ne | wend
            lda #0
            sta (<pDestination),y | iny | sty <destinationOffset
            cpy #48
        while ne | wend
        lda #0
        do
            sta (<pDestination),y | iny
            cpy #SpriteSize
        while ne | wend
        lda <pSource | clc|adc #low 32 | sta <pSource
        lda <pSource+1 | adc #high 32 | sta <pSource+1

        lda <pDestination | clc|adc #low SpriteSize | sta <pDestination
        lda <pDestination+1 | adc #high SpriteSize | sta <pDestination+1

        dec <yCount
    while ne | wend
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
        lda #0 | sta <pVram+1
        lda	VramPtr_y
        asl	a ; *2
        asl	a ; *4
        clc|adc	VramPtr_y ; *5
        asl	a | rol <pVram+1 ; *10
        asl	a | rol <pVram+1 ; *20
        asl	a | rol <pVram+1 ; *40
        clc|adc VramPtr_x | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1
        lda <pVram
        asl	a | rol <pVram+1 ; *2
        asl	a | rol <pVram+1 ; *4
        asl	a | rol <pVram+1 ; *8
        clc|adc #low Vram | tay
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
        sty <pVram
        stx <pVram+1
        lda Put_c
        ldy #0
        sta (<pVram),y
        tax
        lda <pVram+1
        clc|adc #high(ColorMap-Vram)
        sta <pVram+1
        lda CharColors,x
        sta (<pVram),y
        
        lda <pVram | clc|adc #1 | tay
        lda <pVram+1 | adc #-high(ColorMap-Vram) | tax
    pla
rts
