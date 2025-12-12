include "Port.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext VVram_

PatternSize equ VramStep*CharHeight
StatusHeight equ 2

dseg
Backup: public Backup
    defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
    defs VVramWidth*VVramHeight
MixedPattern: public MixedPattern
    defs PatternSize*4*38

zseg
pVram: public pVram
    defw 0
pPattern:
    defw 0
pMixedPattern:
    defw 0
SpriteChar:
    defb 0

SpriteBytes:
    defs 8
upperCount:
    defb 0
lowerCount:
    defb 0
gap:
    defb 0

pVVram equ ZW0
pSpriteLayer equ ZW1
pBackup equ ZW2
pSpritePattern equ ZW2

xCount equ ZB0
xPos equ ZB0
yCount equ ZB1
yPos equ ZB1
cyCount equ ZB2
cxCount equ ZB3
spriteLayerOffset equ ZB4
spritePatternOffset equ ZB5
charPatternOffset equ ZB6
shiftCount equ ZB7

scope
cseg
InitVram: public InitVram
    lda #160 | sta LCD_X_Size
    lda #160 | sta LCD_Y_Size
    stz X_Scroll
    stz Y_Scroll
rts
endscope


; void ClearScreen();
scope
pDestination equ ZW0
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low VramOrg | sta pVram
        lda #high VramOrg | sta pVram+1
        ldx #$1e
        lda #0
        do
            ldy #0
            do
                sta (pVram),y
                iny
            while ne | wend
            inc pVram+1
        dex | while ne | wend

        lda #low Backup | sta pDestination
        lda #high Backup | sta pDestination+1
        jsr Clear

        lda #low VVram_ | sta pDestination
        lda #high VVram_ | sta pDestination+1
        jsr Clear
    pla
rts
Clear:
    ldx #VVramHeight
    do
        ldy #0 | tya
        do
            sta (pDestination),y
            iny
            cpy #VVramWidth
        while ne | wend
        lda pDestination | clc|adc #VVramWidth | sta pDestination
        if cs | inc pDestination+1 | endif
    dex | while ne | wend
rts
endscope

cseg
PatternPtr: ; a->pPattern
    tax
        stz pPattern+1
        asl a | rol pPattern+1 ;*2
        asl a | rol pPattern+1 ;*4
        asl a | rol pPattern+1 ;*8
        asl a | rol pPattern+1 ;*16
        sta pPattern
    txa
    cmp #Char_End
    if cc
        lda pPattern | clc|adc #low CharPattern | sta pPattern
        lda pPattern+1 | adc #high CharPattern | sta pPattern+1
    else
        lda pPattern | clc|adc #low(MixedPattern-PatternSize*Char_End) | sta pPattern
        lda pPattern+1 | adc #high(MixedPattern-PatternSize*Char_End) | sta pPattern+1
    endif
rts


Put: ;(pVram,a)
    jsr PatternPtr    
    ldx #CharHeight
    do
        ldy #0
        do
            lda (pPattern),y
            sta (pVram),y
            iny
            cpy #VramStep
        while ne | wend
        lda pPattern | clc|adc #VramStep | sta pPattern
        lda pPattern+1 | adc #0 | sta pPattern+1

        lda pVram | clc|adc #VramWidth | sta pVram
        lda pVram+1 | adc #0 | sta pVram+1

        dex
    while ne | wend
    lda pVram | clc|adc #low(VramStep-VramWidth*CharHeight) | sta pVram
    lda pVram+1 | adc #high(VramStep-VramWidth*CharHeight) | sta pVram+1
rts


scope
; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    pha
        sty pVram | stx pVram+1
        lda Put_c
        jsr Put
        ldy pVram | ldx pVram+1
    pla
rts

cseg
CharTable:
    defb " -0123456789:ABCEFGHIMNORSTUV"
; byte FromAscii(byte c);
cseg
FromAscii_: public FromAscii_
    pha
        tya
        ldy #0
        do
            cmp CharTable,y
            beq FromAscii_exit
            iny
            cpy #29
        while ne | wend
        ldy #Char_Space
        FromAscii_exit:
    pla
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    pha
        sty pVram | stx pVram+1
        ldy Put_c
        jsr FromAscii_
        tya
        jsr Put
        ldy pVram | ldx pVram+1
    pla
rts
endscope


scope
pVVram equ ZW0
pSpriteLayer equ ZW1
; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    pha
        lda #Char_End | sta SpriteChar
        lda #low MixedPattern | sta pMixedPattern
        lda #high MixedPattern | sta pMixedPattern+1

        lda #low VVram_| sta pVVram
        lda #high VVram_ | sta pVVram+1

        lda #low SpriteLayer | sta pSpriteLayer
        lda #high SpriteLayer | sta pSpriteLayer+1
        
        ldx #VVramHeight
        do
            ldy #0
            do
                lda (pVVram),y | sta (pSpriteLayer),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda pVVram | clc|adc #low VVramWidth | sta pVVram
            lda pVVram+1 | adc #0 | sta pVVram+1

            lda pSpriteLayer | clc|adc #VVramWidth | sta pSpriteLayer
            lda pSpriteLayer+1 | adc #0 | sta pSpriteLayer+1
        dex | while ne | wend
   pla
rts
endscope


scope
pSpriteLayer equ ZW0
pBackup equ ZW1
yCount equ ZB0
; void EndDraw();
cseg
EndDraw_: public EndDraw_
    pha
        lda #low Vram | sta pVram
        lda #high Vram | sta pVram+1

        lda #low SpriteLayer  | sta pSpriteLayer
        lda #high SpriteLayer | sta pSpriteLayer+1
        
        lda #low Backup | sta pBackup
        lda #high Backup | sta pBackup+1

        lda #VVramHeight | sta yCount
        do
            ldy #0
            do
                lda (pSpriteLayer),y
                cmp #Char_End
                bcs EndDraw_write
                cmp (pBackup),y
                if ne
                    EndDraw_write:
                    sta (pBackup),y
                    phy
                        jsr Put
                    ply
                else
                    lda pVram | clc|adc #VramStep | sta pVram
                    lda pVram+1 | adc #0 | sta pVram+1
                endif
                iny
                cpy #VVramWidth
            while ne | wend
            lda pVram | clc|adc #low(VramRowSize-VramStep*VVramWidth) | sta pVram
            lda pVram+1 | adc #high(VramRowSize-VramStep*VVramWidth) | sta pVram+1

            lda pSpriteLayer | clc|adc #VVramWidth | sta pSpriteLayer
            lda pSpriteLayer+1 | adc #0 | sta pSpriteLayer+1

            lda pBackup | clc|adc #VVramWidth | sta pBackup
            lda pBackup+1 | adc #0 | sta pBackup+1

            dec yCount
        while ne | wend
    pla
rts
endscope

scope
pSpriteLayer equ ZW0
pSpritePattern equ ZW1
pBackground equ ZW2
spriteLayerOffset equ ZB0
spritePatternOffset equ ZB1
yCount equ ZB2
xCount equ ZB3
cyCount equ ZB4
charPatternOffset equ ZB5
mask equ ZB6
pattern equ ZB7
; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param1: public DrawSprite_@Param1
DrawSprite_y:
    defb 0
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    pha
        lda DrawSprite_y
        lsr a | sta pSpriteLayer
        stz pSpriteLayer+1
        asl a | rol pSpriteLayer+1 ;*2
        asl a | rol pSpriteLayer+1 ;*4
        adc pSpriteLayer | if cs | inc pSpriteLayer+1 | endif ;*5
        asl a | rol pSpriteLayer+1 ;*10
        asl a | rol pSpriteLayer+1 ;*20
        adc #low SpriteLayer | sta pSpriteLayer
        lda pSpriteLayer+1 | adc #high SpriteLayer | sta pSpriteLayer+1
        tya
        lsr a
        clc|adc pSpriteLayer | sta pSpriteLayer
        if cs | inc pSpriteLayer+1 | endif
        stz spriteLayerOffset

        lda DrawSprite_pattern | stz pSpritePattern
        lsr a | ror pSpritePattern ;/2
        sta pSpritePattern+1
        lda pSpritePattern | clc|adc #low SpritePattern | sta pSpritePattern
        lda pSpritePattern+1 | adc #high SpritePattern | sta pSpritePattern+1
        stz <spritePatternOffset

        lda DrawSprite_y
        and #1
        if eq
            tya ;xPos
            and #1
            if eq
                lda #2 | sta yCount
                do
                    lda #2 | sta xCount
                    do
                        jsr MakeSource
                        lda #CharHeight | sta cyCount
                        do
                            jsr MixStraight
                        dec cyCount | while ne | wend
                        jsr NextPattern
                        lda <spritePatternOffset | clc|adc #4-64 | sta <spritePatternOffset
                        inc spriteLayerOffset
                    dec <xCount | while ne | wend
                    lda spriteLayerOffset | clc|adc #VVramWidth-2 | sta spriteLayerOffset
                    lda <spritePatternOffset | clc|adc #64-8 | sta <spritePatternOffset
                dec yCount | while ne | wend
            else
                lda #2 | sta yCount
                do
                    jsr MakeSource
                    lda #CharHeight | sta cyCount
                    do
                        jsr MixLeft
                    dec cyCount | while ne | wend
                    jsr NextPattern
                    lda <spritePatternOffset | clc|adc #-64 | sta <spritePatternOffset
                    inc spriteLayerOffset

                    jsr MakeSource
                    lda #CharHeight | sta cyCount
                    do
                        jsr MixCenter
                    dec cyCount | while ne | wend
                    jsr NextPattern
                    lda <spritePatternOffset | clc|adc #-64 | sta <spritePatternOffset
                    inc spriteLayerOffset

                    jsr MakeSource
                    lda #CharHeight | sta cyCount
                    do
                        jsr MixRight
                    dec cyCount | while ne | wend
                    jsr NextPattern
                    lda spriteLayerOffset | clc|adc #VVramWidth-2 | sta spriteLayerOffset
                dec yCount | while ne | wend
            endif
        else
            tya ;xPos
            and #1
            if eq
                lda #2 | sta xCount
                do
                    jsr MakeSource
                    jsr CopyBackground
                    lda #CharHeight/2 | sta cyCount
                    do
                        jsr MixStraight
                    dec cyCount | while ne | wend
                    jsr NextPattern
                    lda <spritePatternOffset | clc|adc #4-32 | sta <spritePatternOffset
                    inc spriteLayerOffset
                dec <xCount | while ne | wend
                lda spriteLayerOffset | clc|adc #VVramWidth-2 | sta spriteLayerOffset
                lda <spritePatternOffset | clc|adc #32-8 | sta <spritePatternOffset
                
                lda #2 | sta <xCount
                do
                    jsr MakeSource
                    lda #CharHeight | sta cyCount
                    do
                        jsr MixStraight
                        dec cyCount
                    while ne | wend
                    jsr NextPattern
                    lda <spritePatternOffset | clc|adc #4-64 | sta <spritePatternOffset
                    inc spriteLayerOffset
                dec <xCount | while ne | wend
                lda spriteLayerOffset | clc|adc #VVramWidth-2 | sta spriteLayerOffset
                lda <spritePatternOffset | clc|adc #64-8 | sta <spritePatternOffset

                lda #2 | sta <xCount
                do
                    jsr MakeSource
                    lda #CharHeight/2 | sta cyCount
                    do
                        jsr MixStraight
                    dec cyCount | while ne | wend
                    jsr CopyBackground
                    jsr NextPattern
                    lda <spritePatternOffset | clc|adc #4-32 | sta <spritePatternOffset
                    inc spriteLayerOffset
                dec <xCount | while ne | wend
            else
                ;TL
                jsr MakeSource
                jsr CopyBackground
                lda #CharHeight/2 | sta cyCount
                do
                    jsr MixLeft
                dec cyCount | while ne | wend
                jsr NextPattern
                lda <spritePatternOffset | clc|adc #-32 | sta <spritePatternOffset
                inc spriteLayerOffset
                ;TC
                jsr MakeSource
                jsr CopyBackground
                lda #CharHeight/2 | sta cyCount
                do
                    jsr MixCenter
                dec cyCount | while ne | wend
                jsr NextPattern
                lda <spritePatternOffset | clc|adc #-32 | sta <spritePatternOffset
                inc spriteLayerOffset
                ;TR
                jsr MakeSource
                jsr CopyBackground
                lda #CharHeight/2 | sta cyCount
                do
                    jsr MixRight
                dec cyCount | while ne | wend
                jsr NextPattern
                lda spriteLayerOffset | clc|adc #VVramWidth-2 | sta spriteLayerOffset
                ;CL
                jsr MakeSource
                lda #CharHeight | sta cyCount
                do
                    jsr MixLeft
                dec cyCount | while ne | wend
                jsr NextPattern
                lda <spritePatternOffset | clc|adc #-8*8 | sta <spritePatternOffset
                inc spriteLayerOffset
                ;CC
                jsr MakeSource
                lda #CharHeight | sta cyCount
                do
                    jsr MixCenter
                dec cyCount | while ne | wend
                jsr NextPattern
                lda <spritePatternOffset | clc|adc #-64 | sta <spritePatternOffset
                inc spriteLayerOffset
                ;CR
                jsr MakeSource
                lda #CharHeight | sta cyCount
                do
                    jsr MixRight
                dec cyCount | while ne | wend
                jsr NextPattern
                ; lda <spritePatternOffset | clc|adc #-4 | sta <spritePatternOffset
                lda spriteLayerOffset | clc|adc #VVramWidth-2 | sta spriteLayerOffset
                ;BL
                jsr MakeSource
                lda #CharHeight/2 | sta cyCount
                do
                    jsr MixLeft
                dec cyCount | while ne | wend
                jsr CopyBackground
                jsr NextPattern
                lda <spritePatternOffset | clc|adc #-32 | sta <spritePatternOffset
                inc spriteLayerOffset
                ;BC
                jsr MakeSource
                lda #CharHeight/2 | sta cyCount
                do
                    jsr MixCenter
                dec cyCount | while ne | wend
                jsr CopyBackground
                jsr NextPattern
                lda <spritePatternOffset | clc|adc #-32 | sta <spritePatternOffset
                inc spriteLayerOffset
                ;BR
                jsr MakeSource
                lda #CharHeight/2 | sta cyCount
                do
                    jsr MixRight
                dec cyCount | while ne | wend
                jsr CopyBackground
                jsr NextPattern
            endif
        endif
    pla
rts
MakeSource:
    ldy spriteLayerOffset
    lda (pSpriteLayer),y
    jsr PatternPtr
    lda SpriteChar
    sta (pSpriteLayer),y
    inc a
    sta SpriteChar
    stz <charPatternOffset
rts
NextPattern:
    lda pMixedPattern | clc|adc #PatternSize | sta pMixedPattern
    if cs | inc pMixedPattern+1 | endif
rts
MixByte:
    ldy spritePatternOffset
    lda (pSpritePattern),y | iny
    eor #$ff | sta mask
    lda (pSpritePattern),y | iny
    sta pattern
    sty spritePatternOffset

    ldy charPatternOffset
    lda (pPattern),y
    and mask
    ora pattern
    sta (pMixedPattern),y
    iny
    sty charPatternOffset
rts
CopyByte:
    ldy charPatternOffset
    lda (pPattern),y
    sta (pMixedPattern),y
    iny
    sty charPatternOffset
rts
MixStraight:
    ldx #2
    do
        jsr MixByte
    dex | while ne | wend
    lda spritePatternOffset | clc|adc #4 | sta spritePatternOffset
rts
MixLeft:
    jsr CopyByte
    jsr MixByte
    lda spritePatternOffset | clc|adc #6 | sta spritePatternOffset
rts
MixCenter:
    inc spritePatternOffset | inc spritePatternOffset
    ldx #2
    do
        jsr MixByte
    dex | while ne | wend
    inc spritePatternOffset | inc spritePatternOffset
rts
MixRight:
    lda spritePatternOffset | clc|adc #6 | sta spritePatternOffset
    jsr MixByte
    jsr CopyByte
rts
CopyBackground:
    ldx #2*CharHeight/2
    do
        jsr CopyByte
    dex | while ne | wend
rts
MixLeftBytes:
    ldy <charPatternOffset
    ldx #0
    do
        lda <SpriteBytes,x | inx
        eor #$ff
        and (pPattern),y
        ora <SpriteBytes,x | inx
        sta (pMixedPattern),y
        iny
        cpx #4
    while ne | wend
    sty <charPatternOffset
rts
LoadSprite4Bytes:
    ldy <spritePatternOffset
    ldx #0
    do
        lda (pSpritePattern),y | iny
        sta <SpriteBytes,x
        inx
        cpx #4
    while ne | wend
    iny | iny | iny | iny
    sty <spritePatternOffset
rts
LoadSprite8Bytes:
    ldy <spritePatternOffset
    ldx #0
    do
        lda (pSpritePattern),y | iny
        sta <SpriteBytes,x
        inx
        cpx #8
    while ne | wend
    sty <spritePatternOffset
rts
MixRightBytes:
    ldy <charPatternOffset
    ldx #0
    do
        lda <SpriteBytes+4,x | inx
        eor #$ff
        and (pPattern),y
        ora <SpriteBytes+4,x | inx
        sta (pMixedPattern),y
        iny
        cpx #4
    while ne | wend
    sty <charPatternOffset
rts
endscope


ext Status_
scope
statusOffset equ ZB0
yCount equ ZB1
xCount equ ZB2
; void StatusToVram();
cseg
StatusToVram_: public StatusToVram_
    pha
        lda #low Vram | sta pVram
        lda #high Vram | sta pVram+1
        stz statusOffset

        lda #StatusHeight | sta yCount
        do
            lda #VVramWidth | sta xCount
            do
                ldx statusOffset | lda Status_,x
                inx | stx statusOffset
                cmp #Char_Space
                if ne
                    jsr Put
                else
                    lda pVram | clc|adc #VramStep | sta pVram
                    if cs
                        inc pVram+1
                    endif
                endif
            dec xCount | while ne | wend
            lda pVram | clc|adc #low(VramRowSize-VVramWidth*VramStep) | sta pVram
            lda pVram+1 | adc #high(VramRowSize-VVramWidth*VramStep) | sta pVram+1
        dec yCount | while ne | wend
    pla
rts
endscope
