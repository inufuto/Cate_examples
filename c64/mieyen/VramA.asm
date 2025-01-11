include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern,ColorPattern,SpritePattern

Color0 equ 0
Color1 equ 14
Color2 equ 10

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
CharPatternRam:
    defs CharHeight*Char_End
CharMap:
    defs $400

cseg
ColorSource:
defb 64,1 ; Ascii
defb 16,3 ; Logo
defb 16,6 ; Wall
defb 4,7 ; Dot
defb 4,1 ; Remain
defb 4,7 ; Food
defb 0
InitVram: public InitVram
    lda #Color0 | sta $D020 | sta $D021
    lda #Color1 | sta $D022 | sta $D025
    lda #Color2 | sta $D023 | sta $D026

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

    lda #low CharPatternRam | sta <pDestination
    lda #high CharPatternRam | sta <pDestination+1

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

    lda #low(CharPatternRam+CharHeight*Char_Color) | sta <pDestination
    lda #high(CharPatternRam+CharHeight*Char_Color) | sta <pDestination+1

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

    lda #low SpritePatternRam0 | sta <pDestination
    lda #high SpritePatternRam0 | sta <pDestination+1
    lda #Pattern_End0-0 | sta <yCount
    jsr DefSprites

    lda #low SpritePatternRam1 | sta <pDestination
    lda #high SpritePatternRam1 | sta <pDestination+1
    lda #Pattern_End1-32 | sta <yCount
    jsr DefSprites
rts

DefSprites:
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
        ldx #$20
        jsr Clear

        lda #low TextMap | sta <pDestination
        lda #high TextMap | sta <pDestination+1
        lda #Color2 or (Color1 shl 4)
        ldx #$04
        jsr Clear

        lda #low ColorMap | sta <pDestination
        lda #high ColorMap | sta <pDestination+1
        lda #1
        ldx #$04
        jsr Clear

        lda #low CharMap | sta <pDestination
        lda #high CharMap | sta <pDestination+1
        lda #0
        ldx #$04
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

        lda #0 | sta <pSource+1
        lda Put_c
        asl a | rol <pSource+1
        asl a | rol <pSource+1
        asl a | rol <pSource+1
        clc|adc #low CharPatternRam | sta <pSource
        lda <pSource+1 | adc #high CharPatternRam | sta <pSource+1

        ldy #0
        do
            lda (<pSource),y
            sta (<pVram),y
            iny
            cpy #CharHeight
        while ne | wend

        lda <pVram+1
        sec|sbc #high Vram
        lsr a | ror <pVram
        lsr a | ror <pVram
        lsr a | ror <pVram
        sta <pVram+1
        clc|adc #high ColorMap
        sta <pColorMap+1
        lda <pVram | sta <pColorMap
        ldx Put_c | lda CharColors,x
        ldy #0 | sta (<pColorMap),y

        lda <pVram | clc|adc #low CharMap | sta <pVram
        lda <pVram+1 | adc #high CharMap | sta <pVram+1
        lda Put_c | sta (<pVram),y
        
        lda Put_pVram | clc|adc #VramStep | tay
        lda Put_pVram+1 | adc #0 | tax
    pla
rts


; byte ReadVram(ptr<byte> pVram);
cseg
ReadVram_: public ReadVram_
    pha
        sty <pVram | txa
        sec|sbc #high Vram
        lsr a | ror <pVram
        lsr a | ror <pVram
        lsr a | ror <pVram
        sta <pVram+1
        lda <pVram | clc|adc #low CharMap | sta <pVram
        lda <pVram+1 | adc #high CharMap | sta <pVram+1
        ldy #0
        lda (<pVram),y
        tay
    pla
rts
