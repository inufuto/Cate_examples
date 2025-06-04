include "Lynx.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "Chars.inc"
include "VVram.inc"

ext MonoPattern, ColorPattern
ext GroundVVram_,UfoVVram_

PatternSize equ VramStep*CharHeight

zseg
CurrentPage: public CurrentPage
    defb 0

dseg
Backup:
    defs VVramWidth*VVramHeight
CharRam: public CharRam
    defs PatternSize*Char_End

pSource equ ZW0
pDestination equ ZW1
pVram equ ZW1
pVVram equ ZW2
pBackup equ ZW3
charCount equ ZB0
color equ ZB1
yCount equ ZB1
sourceOffset equ ZB2
xOffset equ ZB2
destinationOffset equ ZB3
sourceByte equ ZB4 
destinationByte equ ZB5
byteCount equ ZB6
bitCount equ ZB7

cseg
PaletteValues:
	defb	$00, $03, $00, $09, $0f, $09, $0d, $0f
	defb	$00, $07, $05, $07, $07, $05, $0b, $0b
	defb	$00, $d5, $0f, $df, $00, $f3, $3f, $ff
	defb	$00, $77, $39, $7d, $00, $90, $9d, $bb
ColorSource:
    defb 64,7 ; Ascii
    defb 16,5 ; Logo
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

        lda #low Backup | sta <pDestination
        lda #high Backup | sta <pDestination+1
        ldx #VVramHeight
        do
            lda #0
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
Put: ;(pDestination,a)
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


ext VVram_

; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low(VVram_+VVramWidth+1) | sta <pVVram
        lda #high(VVram_+VVramWidth+1) | sta <pVVram+1
        lda #low(Vram+VramRowSize*StatusHeight) | sta <pDestination
        lda #high(Vram+VramRowSize*StatusHeight) | sta <pDestination+1
        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #WindowHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pVVram),y
                                ; lda #$21
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    sty <xOffset
                    jsr Put
                    ldy <xOffset
                else
                    lda <pDestination | clc | adc #low VramStep | sta <pDestination
                    lda <pDestination+1 | adc #high VramStep | sta <pDestination+1
                endif

                iny
                cpy #WindowWidth
            while ne | wend
            lda <pDestination | clc | adc #low(VramRowSize-VramStep*WindowWidth)  | sta <pDestination
            lda <pDestination+1 | adc #high(VramRowSize-VramStep*WindowWidth) | sta <pDestination+1

            lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1

            lda <pBackup | clc | adc #low VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts
