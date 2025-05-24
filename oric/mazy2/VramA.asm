include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

VramTop equ Vram+VramRowSize*1

pSource equ ZW0
pDestination equ ZW1
yCount equ ZB0
charCount equ ZB0


dseg
CharColors: public CharColors
    defs Char_End-Char_Space

cseg
ColorSource:
defb 29,Color_White ; Ascii
defb 16,Color_Cyan ; Logo
defb 4,Color_White ; Knife
defb 4,Color_Magenta ; Chaser
defb 4,Color_Red ; Disturber
defb 16,Color_White ; Point
defb 8,Color_White ; Stair
defb 4,Color_Yellow ; Goal
defb 4,Color_White ; Remain
defb 4,Color_White ; Man
defb 0
InitVram: public InitVram
    ldy #0
    ldx #0
    do
        lda ColorSource,x
    while ne
        sta <charCount
        inx
        lda ColorSource,x | inx
        do
            sta CharColors,y | iny
            dec <charCount
        while ne | wend
    wend

    ldx #Pattern_Ascii | ldy #Char_Ascii | lda #Char_Chaser-Char_Ascii
    jsr SetPattern

    ldx #Pattern_Chaser | ldy #Char_Chaser | lda #Pattern_End-Char_Chaser
    jsr SetPattern

    ldx #Pattern_Man | ldy #Char_Remain | lda #4
    jsr SetPattern
rts

cseg
SetPattern: ; (y to x, a=count)
    sta <charCount

    lda #0 | sta <pSource+1
    txa
    asl a | rol <pSource+1 ;*2
    asl a | rol <pSource+1 ;*4
    asl a | rol <pSource+1 ;*8
    clc|adc #low CharPattern | sta <pSource
    lda <pSource+1 | adc #high CharPattern | sta <pSource+1

    lda #0 | sta <pDestination+1
    tya
    asl a | rol <pDestination+1 ;*2
    asl a | rol <pDestination+1 ;*4
    asl a | rol <pDestination+1 ;*8
    clc|adc #low PatternRam | sta <pDestination
    lda <pDestination+1 | adc #high PatternRam | sta <pDestination+1

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

        dec <charCount
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low VramBase | sta <pDestination
        lda #high VramBase | sta <pDestination+1
        ldx #VramHeight
        do
            lda #Color_White
            ldy #0
            do
                sta (<pDestination),y | iny
                cpy VramWidth
            while ne | wend
            lda <pDestination | clc|adc #VramWidth | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1

            dex
        while ne | wend

        lda #low VVramBack_ | sta <pDestination
        lda #high VVramBack_ | sta <pDestination+1
        ldx #VVramHeight*2
        do
            lda #Char_Space
            ldy #0
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


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVramFront_ | sta <pSource
        lda #high VVramFront_ | sta <pSource+1

        lda #low VramTop | sta <pDestination
        lda #high VramTop | sta <pDestination+1

        lda #VVramHeight | sta <yCount
        do
            ldy #0
            lda (<pSource),y
            tax
            lda CharColors-Char_Space,x
            sta (<pDestination),y
            do
                lda (<pSource),y
                cmp #Char_Space
                if eq
                    iny | lda (<pSource),y | dey
                    tax
                    lda CharColors-Char_Space,x
                endif
                iny
                sta (<pDestination),y
                cpy #VVramWidth-1
            while ne | wend

            lda <pSource | clc | adc #low VVramWidth | sta <pSource
            lda <pSource+1 | adc #high VVramWidth | sta <pSource+1

            lda <pDestination | clc | adc #low VramWidth | sta <pDestination
            lda <pDestination+1 | adc #high VramWidth | sta <pDestination+1

            dec <yCount
        while ne | wend
    pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    pha
        sty <pDestination | stx <pDestination+1
        lda Put_c
        ldy #0
        sta (<pDestination),y
        ldy <pDestination | ldx <pDestination+1
        iny
        if eq
            inx
        endif
    pla
rts


; ptr<byte> PrintC(ptr<byte> pDestination, byte c);
dseg
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
Put_@Param1: public Put_@Param1
Put_c:
	defb 0
cseg
CharTable:
    defb " 0123456789ACEFGHIKMNOPRSTUVY"
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
        ldx #Char_Space-Char_Space
        PrintC_exit:        
        txa
        clc|adc #Char_Space
        ldy #0
        sta (<pDestination),y

        ldy <pDestination | ldx <pDestination+1
        iny
        if eq
            inx
        endif
    pla
rts



; void SetPattern(byte c, byte pattern, byte count);
dseg
SetPattern_@Param1: public SetPattern_@Param1
SetPattern_pattern:
    defb 0
SetPattern_@Param2: public SetPattern_@Param2
SetPattern_count:
    defb 0
cseg
SetPattern_: public SetPattern_
    pha
        ldx SetPattern_pattern
        lda SetPattern_count
        jsr SetPattern
    pla
rts
