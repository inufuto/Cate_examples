include "Lynx.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext GroundVVram_,UfoVVram_

PatternSize equ VramStep*CharHeight

zseg
CurrentPage: public CurrentPage
    defb 0

dseg
CharRam: public CharRam
    defs PatternSize*Char_End

pSource equ ZW0
pDestination equ ZW1
pVram equ ZW1
charCount equ ZB0
color equ ZB1
yCount equ ZB1
sourceOffset equ ZB2
destinationOffset equ ZB3
sourceByte equ ZB4 
destinationByte equ ZB5
byteCount equ ZB6
bitCount equ ZB7

cseg
PaletteValues:
	defb	$00, $00, $00, $0a, $0a, $0f, $0f, $0f
	defb	$0a, $00, $0f, $00, $0f, $00, $05, $0a
	defb	$00, $f0, $0f, $ff, $0f, $ff, $0f, $f0
	defb	$f0, $0f, $0f, $55, $00, $00, $5f, $af
ColorSource:
    defb 64,5 ; Ascii
    defb 16,7 ; Logo
    defb 17,1 ; Wall
    defb 4,6 ; Dot
    defb 0
InitVram: public InitVram
    lda #low Page0Org | sta DISPADR | sta VIDBAS
    lda #high Page0Org | sta DISPADR+1 | sta VIDBAS+1
    lda #8
    sta HOFF
    sta VOFF

    lda #$62 | sta SPRSYS
    lda #$f3 | sta SPRINT
    lda #1 | sta SUZYBUSEN
    lda #$0d | sta DISPCTL

    ldx #0
    do
        lda PaletteValues,x | sta GreenColors,x
        inx
        cpx #$20
    while ne | wend

    lda #low CharRam | sta <pDestination
    lda #high CharRam | sta pDestination+1

    lda #low MonoPattern | sta <pSource
    lda #high MonoPattern | sta <pSource+1
    ldx #0
    do
        lda ColorSource,x
    while ne
        inx
        sta <charCount
        lda ColorSource,x | inx
        sta <color
        jsr MakePatternMono
    wend
    lda #low ColorPattern | sta <pSource
    lda #high ColorPattern | sta <pSource+1
    lda #Char_End-Char_Color | sta <charCount
    jsr MakePatternColor
rts

MakePatternMono:
    do
        ldy #0 | sty <sourceOffset | sty <destinationOffset
        do
            ldy <sourceOffset
            lda (<pSource),y | iny
            sty <sourceOffset
            sta <sourceByte
            lda #VramStep | sta <byteCount
            do
                stz <destinationByte
                lda #2 | sta <bitCount
                do
                    lda <destinationByte
                    asl a | asl a | asl a | asl a
                    sta <destinationByte
                    
                    lda <color
                    asl <sourceByte
                    if cs
                        and #$0f
                    else
                        and #$f0
                        lsr a | lsr a | lsr a | lsr a
                    endif
                    ora <destinationByte
                    sta <destinationByte

                    dec <bitCount
                while ne | wend
                lda <destinationByte
                ldy <destinationOffset
                sta (<pDestination),y | iny
                sty <destinationOffset

                dec <byteCount
            while ne | wend
            ldy <sourceOffset
            cpy #CharHeight
        while ne | wend
        lda <pSource | clc|adc #CharHeight | sta <pSource
        lda <pSource+1 | adc #0 | sta <pSource+1

        lda <pDestination | clc|adc #CharHeight*VramStep | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1

        dec <charCount
    while ne | wend
rts


MakePatternColor:
    do
        ldy #0
        do
            lda (<pSource),y
            sta (<pDestination),y
            iny
            cpy #CharHeight*VramStep
        while ne | wend
        lda <pSource | clc|adc #CharHeight*VramStep | sta <pSource
        lda <pSource+1 | adc #0 | sta <pSource+1

        lda <pDestination | clc|adc #CharHeight*VramStep | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1

        dec <charCount
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low BackgroundOrg | sta pDestination
        lda #high BackgroundOrg | sta pDestination+1
        ldx #high($fc00-BackgroundOrg)
        lda #0
        do
            ldy #0
            do
                sta (<pDestination),y
                iny
            while ne | wend
            inc <pDestination+1
            dex
        while ne | wend

        lda #low Page0Org | sta DISPADR
        lda #high Page0Org | sta DISPADR+1
        lda #high Page1Org | sta <CurrentPage
    pla
rts


; ptr<byte> VramPtr(byte x, byte y);
dseg
VramPtr_@Param1: public VramPtr_@Param1
VramPtr_y:
    defb 0
cseg
YTable:
    defw Vram+VramRowSize*0,Vram+VramRowSize*1,Vram+VramRowSize*2,Vram+VramRowSize*3,Vram+VramRowSize*4,Vram+VramRowSize*5,Vram+VramRowSize*6,Vram+VramRowSize*7,Vram+VramRowSize*8,Vram+VramRowSize*9,Vram+VramRowSize*10,Vram+VramRowSize*11,Vram+VramRowSize*12,Vram+VramRowSize*13,Vram+VramRowSize*14,Vram+VramRowSize*15
VramPtr_: public VramPtr_
    pha
        tya
        sta <pVram+1
        asl a
        adc <pVram+1
        sta <pVram+1

        lda VramPtr_y
        asl a
        tax
        lda YTable,x | clc|adc <pVram+1 | tay
        lda YTable+1,x | adc #0 | tax
    pla
rts


cseg
Put: ;(,a)
    sta <sourceByte
    stz <pSource+1
    asl a | rol <pSource+1 ;*2
    asl a | rol <pSource+1 ;*4
    asl a | rol <pSource+1 ;*8
    clc|adc <sourceByte | sta <pSource
    lda <pSource+1 | adc #0 | sta <pSource+1 ;*9
    lda <pSource
    asl a | rol <pSource+1 ;*18
    clc|adc #low CharRam | sta <pSource
    lda <pSource+1 | adc #high CharRam | sta <pSource+1
    
    lda #CharHeight | sta <byteCount
    do
        ldy #0
        do
            lda (<pSource),y
            sta (<pDestination),y
            iny
            cpy #VramStep
        while ne | wend
        lda <pSource | clc|adc #VramStep | sta <pSource
        lda <pSource+1 | adc #0 | sta <pSource+1

        lda <pDestination | clc|adc #VramWidth | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1

        dec <byteCount
    while ne | wend
    lda <pDestination | clc|adc #low(VramStep-VramWidth*CharHeight) | sta <pDestination
    lda <pDestination+1 | adc #high(VramStep-VramWidth*CharHeight) | sta <pDestination+1
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
        sty Put_pVram | sty <pDestination
        stx Put_pVram+1 | stx <pDestination+1
        lda Put_c
        jsr Put

        lda Put_pVram | clc|adc #VramStep | tay
        lda Put_pVram+1 | adc #0 | tax
    pla
rts


; void SwitchPage();
cseg
SwitchPage_: public SwitchPage_
    pha
        stz DISPADR
        lda <CurrentPage | sta DISPADR+1
        cmp #high Page1Org
        if cc
            lda #high Page1Org | sta <CurrentPage
        else
            lda #high Page0Org | sta <CurrentPage
        endif
    pla
rts
