include "Lynx.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
zext pVramBack

PatternSize equ VramStep*CharHeight

zseg
CurrentPage: public CurrentPage
    defb 0

dseg
CharRam: public CharRam
    defs PatternSize*Char_End
Backup:
    defs WindowWidth*BackHeight
VVram: public VVram
    defs WindowWidth*BackHeight

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
defb	$00, $00, $00, $00, $0f, $0f, $0f, $0f
defb	$00, $00, $00, $05, $0a, $0a, $0a, $0a
defb	$00, $f0, $0f, $ff, $00, $f0, $0f, $ff
defb	$00, $a0, $0a, $00, $00, $f0, $0f, $aa
ColorSource:
defb 29,7 ; Ascii
defb 15,5 ; Logo
defb 1,7 ; Remain
defb 0
InitVram: public InitVram
    lda #low Page0 | sta DISPADR | sta VIDBAS
    lda #high Page0 | sta DISPADR+1 | sta VIDBAS+1
    lda #HOffset | sta HOFF
    lda #VOffset | sta VOFF

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
        lda #low Page0 | sta pDestination
        lda #high Page0 | sta pDestination+1
        ldx #high($fc00-Page0)
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

        lda #low Backup | sta <pDestination
        lda #high Backup | sta <pDestination+1
        ldx #BackHeight*2
        do
            ldy #0 | tya
            do
                sta (<pDestination),y
                iny
                cpy #WindowWidth
            while ne | wend
            lda <pDestination | clc|adc #WindowWidth | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1
            dex
        while ne | wend

        lda #low Page0 | sta DISPADR
        lda #high Page0 | sta DISPADR+1
        lda #high Page1 | sta <CurrentPage

        stz pVramBack
        lda #high(VramBackOrg) | sta pVramBack+1
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
PrintC_@Param1: public PrintC_@Param1
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

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    pha
        sty Put_pVram | sty <pDestination
        stx Put_pVram+1 | stx <pDestination+1

        lda Put_c
        ldy #0
        do
            cmp CharTable,y
            beq FromAscii_exit
            iny
            cpy #29
        while ne | wend
        ldy #Char_Space
        FromAscii_exit:
        tya
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
        cmp #high Page1
        if cc
            lda #high Page1 | sta <CurrentPage
        else
            lda #high Page0 | sta <CurrentPage
        endif
    pla
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VramBack | sta <pDestination
        lda #high VramBack | sta <pDestination+1

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #low(VVram) | sta <pVVram
        lda #high(VVram) | sta <pVVram+1
        
        lda #BackHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pVVram),y
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    phy
                        jsr Put
                    ply
                else
                    lda <pDestination | clc|adc #VramStep | sta <pDestination
                    lda <pDestination+1 | adc #0 | sta <pDestination+1
                endif
                iny
                cpy #WindowWidth
            while ne | wend
            lda <pDestination | clc | adc #low(VramRowSize-VramStep*WindowWidth)  | sta <pDestination
            lda <pDestination+1 | adc #high(VramRowSize-VramStep*WindowWidth) | sta <pDestination+1

            lda <pVVram | clc | adc #low WindowWidth | sta <pVVram
            lda <pVVram+1 | adc #high WindowWidth | sta <pVVram+1

            lda <pBackup | clc | adc #low WindowWidth | sta <pBackup
            lda <pBackup+1 | adc #high WindowWidth | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts
