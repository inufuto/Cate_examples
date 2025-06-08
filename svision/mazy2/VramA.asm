include "Port.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext BackgroundPattern, SpritePattern
ext VVram_

PatternSize equ VramStep*CharHeight
WindowTop equ Vram+VramRowSize*2

dseg
Backup: public Backup
    defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
    defs VVramWidth*VVramHeight
MixedPattern: public MixedPattern
    defs PatternSize*4*Sprite_End

zseg
SpriteChar:
    defb 0
pMixedPattern:
    defw 0
SpriteBytes:
    defs 8
upperCount:
    defb 0
lowerCount:
    defb 0
gap:
    defb 0

pVVram equ ZW0
pVram equ ZW0
pSpriteLayer equ ZW1
pBackup equ ZW2
pSpritePattern equ ZW2
pPattern equ ZW3

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

cseg
InitVram: public InitVram
    lda #160 | sta LCD_X_Size
    lda #160 | sta LCD_Y_Size
    stz X_Scroll
    stz Y_Scroll

rts


; void ClearScreen();
cseg
Clear:
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
rts
ClearScreen_: public ClearScreen_
    pha
        lda #low VramOrg | sta pVram
        lda #high VramOrg | sta pVram+1
        ldx #$1e
        lda #0
        do
            ldy #0
            do
                sta (<pVram),y
                iny
            while ne | wend
            inc <pVram+1
            dex
        while ne | wend

        lda #low Backup | sta <pVVram
        lda #high Backup | sta <pVVram+1
        jsr Clear

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        jsr Clear
    pla
rts


cseg
PatternPtr:
    tax
        stz <pPattern+1
        asl a | rol <pPattern+1 ;*2
        asl a | rol <pPattern+1 ;*4
        asl a | rol <pPattern+1 ;*8
        asl a | rol <pPattern+1 ;*16
        sta <pPattern
    txa
    cmp #Char_End
    if cc
        lda <pPattern | clc|adc #low BackgroundPattern | sta <pPattern
        lda <pPattern+1 | adc #high BackgroundPattern | sta <pPattern+1
    else
        lda <pPattern | clc|adc #low(MixedPattern-PatternSize*Char_End) | sta <pPattern
        lda <pPattern+1 | adc #high(MixedPattern-PatternSize*Char_End) | sta <pPattern+1
    endif
rts
Put: ;(,a)
    jsr PatternPtr    
    ldx #CharHeight
    do
        ldy #0
        do
            lda (<pPattern),y
            sta (<pVram),y
            iny
            cpy #VramStep
        while ne | wend
        lda <pPattern | clc|adc #VramStep | sta <pPattern
        lda <pPattern+1 | adc #0 | sta <pPattern+1

        lda <pVram | clc|adc #VramWidth | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1

        dex
    while ne | wend
    lda <pVram | clc|adc #low(VramStep-VramWidth*CharHeight) | sta <pVram
    lda <pVram+1 | adc #high(VramStep-VramWidth*CharHeight) | sta <pVram+1
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_@Param1: public Put_@Param1
Put_c:
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
    defb 0
cseg
Put_: public Put_
    pha
        sty <pVram
        stx <pVram+1

        lda Put_c
        jsr Put

        ldy <pVram
        ldx <pVram+1
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    pha
        sty <pVram
        stx <pVram+1
        
        lda PrintC_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_break
            inx
            cpx #29
        while ne | wend
        PrintC_break:
        txa
        jsr Put

        ldy <pVram
        ldx <pVram+1
    pla
rts


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    pha
        lda #Char_End | sta <SpriteChar
        lda #low MixedPattern | sta <pMixedPattern
        lda #high MixedPattern | sta <pMixedPattern+1

        lda #low VVram_| sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        lda #low SpriteLayer | sta <pSpriteLayer
        lda #high SpriteLayer | sta <pSpriteLayer+1
        
        ldx #VVramHeight
        do
            ldy #0
            do
                lda (<pVVram),y | sta (<pSpriteLayer),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVVram | clc|adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            lda <pSpriteLayer | clc|adc #VVramWidth | sta <pSpriteLayer
            lda <pSpriteLayer+1 | adc #0 | sta <pSpriteLayer+1

            dex
        while ne | wend
   pla
rts


; void EndDraw();
cseg
EndDraw_: public EndDraw_
    pha
        lda #low WindowTop | sta <pVram
        lda #high WindowTop | sta <pVram+1

        lda #low SpriteLayer  | sta <pSpriteLayer
        lda #high SpriteLayer | sta <pSpriteLayer+1
        
        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #VVramHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pSpriteLayer),y
                cmp #Char_End
                bcs EndDraw_write
                cmp (<pBackup),y
                if ne
                    EndDraw_write:
                    sta (<pBackup),y
                    phy
                        jsr Put
                    ply
                else
                    lda <pVram | clc|adc #VramStep | sta <pVram
                    lda <pVram+1 | adc #0 | sta <pVram+1
                endif
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVram | clc|adc #low(VramRowSize-VramStep*VVramWidth) | sta <pVram
            lda <pVram+1 | adc #high(VramRowSize-VramStep*VVramWidth) | sta <pVram+1

            lda <pSpriteLayer | clc|adc #VVramWidth | sta <pSpriteLayer
            lda <pSpriteLayer+1 | adc #0 | sta <pSpriteLayer+1

            lda <pBackup | clc|adc #VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #0 | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param1: public DrawSprite_@Param1
DrawSprite_y:
    defb 0
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
cseg
SYTable:
defw SpriteLayer+VVramWidth*0,SpriteLayer+VVramWidth*1,SpriteLayer+VVramWidth*2,SpriteLayer+VVramWidth*3,SpriteLayer+VVramWidth*4,SpriteLayer+VVramWidth*5,SpriteLayer+VVramWidth*6,SpriteLayer+VVramWidth*7,SpriteLayer+VVramWidth*8,SpriteLayer+VVramWidth*9,SpriteLayer+VVramWidth*10,SpriteLayer+VVramWidth*11,SpriteLayer+VVramWidth*12,SpriteLayer+VVramWidth*13,SpriteLayer+VVramWidth*14,SpriteLayer+VVramWidth*15
DrawSprite_: public DrawSprite_
    pha
        lda DrawSprite_y | sta <yPos
        lsr a | and #$fe | tax
        lda SYTable,x | sta <pSpriteLayer
        lda SYTable+1,x | sta <pSpriteLayer+1
        tya | sta <xPos
        lsr a | lsr a
        clc|adc <pSpriteLayer | sta <pSpriteLayer
        lda <pSpriteLayer+1 | adc #0 | sta <pSpriteLayer+1
        stz <spriteLayerOffset

        lda DrawSprite_pattern | stz <pSpritePattern
        lsr a | ror <pSpritePattern ;/2
        sta <pSpritePattern+1
        lda <pSpritePattern | clc|adc #low SpritePattern | sta <pSpritePattern
        lda <pSpritePattern+1 | adc #high SpritePattern | sta <pSpritePattern+1
        stz <spritePatternOffset

        asl <xPos | asl <xPos
        asl <yPos

        lda <yPos
        and #$07
        if eq
            lda <xPos
            and #$0f
            if eq
                lda #2 | sta <yCount
                do
                    lda #2 | sta <xCount
                    do
                        jsr MakeSource
                        lda #CharHeight | sta <cyCount
                        do
                            jsr MixStraight
                            dec <cyCount
                        while ne | wend
                        jsr NextPattern
                        lda <spritePatternOffset | clc|adc #4-64 | sta <spritePatternOffset
                        inc <spriteLayerOffset

                        dec <xCount
                    while ne | wend
                    lda <spriteLayerOffset | clc|adc #VVramWidth-2 | sta <spriteLayerOffset
                    lda <spritePatternOffset | clc|adc #64-8 | sta <spritePatternOffset

                    dec <yCount
                while ne | wend
            else
                sta <shiftCount
                lda #2 | sta <yCount
                do
                    jsr MakeSource
                    lda #CharHeight | sta <cyCount
                    do
                        jsr MixLeft
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern
                    
                    lda <spritePatternOffset | clc|adc #-64 | sta <spritePatternOffset
                    inc <spriteLayerOffset

                    jsr MakeSource
                    lda #CharHeight | sta <cyCount
                    do
                        jsr MixCenter
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern
                    
                    lda <spritePatternOffset | clc|adc #4-64 | sta <spritePatternOffset
                    inc <spriteLayerOffset

                    jsr MakeSource
                    lda #CharHeight | sta <cyCount
                    do
                        jsr MixRight
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern

                    lda <spriteLayerOffset | clc|adc #VVramWidth-2 | sta <spriteLayerOffset
                    lda <spritePatternOffset | clc|adc #-4 | sta <spritePatternOffset

                    dec <yCount
                while ne | wend
            endif
        else
            sta <upperCount
            lda #CharHeight
            sec|sbc <upperCount
            sta <lowerCount
            asl a | asl a | asl a | sta <gap

            lda <xPos
            and #$0f
            if eq
                lda #2 | sta <xCount
                do
                    lda <spritePatternOffset
                    pha
                        jsr MakeSource
                        lda <upperCount | sta <cyCount
                        do
                            jsr CopyBackground
                            dec <cyCount
                        while ne | wend
                        lda <lowerCount | sta <cyCount
                        do
                            jsr MixStraight
                            dec <cyCount
                        while ne | wend
                        jsr NextPattern
                    pla
                    clc|adc #4 | sta <spritePatternOffset
                    inc <spriteLayerOffset

                    dec <xCount
                while ne | wend
                
                lda <spriteLayerOffset | clc|adc #VVramWidth-2 | sta <spriteLayerOffset
                lda <gap | sta <spritePatternOffset
                
                lda #2 | sta <xCount
                do
                    jsr MakeSource
                    lda #CharHeight | sta <cyCount
                    do
                        jsr MixStraight
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern
                    lda <spritePatternOffset | clc|adc #4-64 | sta <spritePatternOffset
                    inc <spriteLayerOffset

                    dec <xCount
                while ne | wend
                
                lda <spriteLayerOffset | clc|adc #VVramWidth-2 | sta <spriteLayerOffset
                lda <spritePatternOffset | clc|adc #64-8 | sta <spritePatternOffset

                lda #2 | sta <xCount
                do
                    jsr MakeSource
                    lda <spritePatternOffset
                    pha
                        lda <upperCount | sta <cyCount
                        do
                            jsr MixStraight
                            dec <cyCount
                        while ne | wend
                        lda <lowerCount | sta <cyCount
                        do
                            jsr CopyBackground
                            dec <cyCount
                        while ne | wend
                        jsr NextPattern
                    pla
                    clc|adc #4 | sta <spritePatternOffset
                    inc <spriteLayerOffset

                    dec <xCount
                while ne | wend
            else
                sta <shiftCount

                lda <spritePatternOffset
                pha
                    jsr MakeSource
                    lda <upperCount | sta <cyCount
                    do
                        jsr CopyBackground
                        dec <cyCount
                    while ne | wend
                    lda <lowerCount | sta <cyCount
                    do
                        jsr MixLeft
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern
                pla
                sta <spritePatternOffset
                inc <spriteLayerOffset

                lda <spritePatternOffset
                pha
                    jsr MakeSource
                    lda <upperCount | sta <cyCount
                    do
                        jsr CopyBackground
                        dec <cyCount
                    while ne | wend
                    lda <lowerCount | sta <cyCount
                    do
                        jsr MixCenter
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern
                pla
                clc|adc #4 | sta <spritePatternOffset
                inc <spriteLayerOffset

                jsr MakeSource
                lda <upperCount | sta <cyCount
                do
                    jsr CopyBackground
                    dec <cyCount
                while ne | wend
                lda <lowerCount | sta <cyCount
                do
                    jsr MixRight
                    dec <cyCount
                while ne | wend
                jsr NextPattern
                lda <spriteLayerOffset | clc|adc #VVramWidth-2 | sta <spriteLayerOffset
                
                lda <gap | sta <spritePatternOffset

                jsr MakeSource
                lda #CharHeight | sta <cyCount
                do
                    jsr MixLeft
                    dec <cyCount
                while ne | wend
                jsr NextPattern

                lda <spritePatternOffset | clc|adc #-64 | sta <spritePatternOffset
                inc <spriteLayerOffset

                jsr MakeSource
                lda #CharHeight | sta <cyCount
                do
                    jsr MixCenter
                    dec <cyCount
                while ne | wend
                jsr NextPattern
                
                lda <spritePatternOffset | clc|adc #4-64 | sta <spritePatternOffset
                inc <spriteLayerOffset

                jsr MakeSource
                lda #CharHeight | sta <cyCount
                do
                    jsr MixRight
                    dec <cyCount
                while ne | wend
                jsr NextPattern

                lda <spritePatternOffset | clc|adc #-4 | sta <spritePatternOffset
                lda <spriteLayerOffset | clc|adc #VVramWidth-2 | sta <spriteLayerOffset

                jsr MakeSource
                lda <spritePatternOffset
                pha
                    lda <upperCount | sta <cyCount
                    do
                        jsr MixLeft
                        dec <cyCount
                    while ne | wend
                    lda <lowerCount | sta <cyCount
                    do
                        jsr CopyBackground
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern
                pla
                sta <spritePatternOffset
                inc <spriteLayerOffset

                jsr MakeSource
                lda <spritePatternOffset
                pha
                    lda <upperCount | sta <cyCount
                    do
                        jsr MixCenter
                        dec <cyCount
                    while ne | wend
                    lda <lowerCount | sta <cyCount
                    do
                        jsr CopyBackground
                        dec <cyCount
                    while ne | wend
                    jsr NextPattern
                pla
                clc|adc #4 | sta <spritePatternOffset
                inc <spriteLayerOffset

                jsr MakeSource
                lda <upperCount | sta <cyCount
                do
                    jsr MixRight
                    dec <cyCount
                while ne | wend
                lda <lowerCount | sta <cyCount
                do
                    jsr CopyBackground
                    dec <cyCount
                while ne | wend
                jsr NextPattern
            endif
        endif
    pla
rts
MakeSource:
    ldy <spriteLayerOffset
    lda (<pSpriteLayer),y
    jsr PatternPtr
    lda <SpriteChar
    sta (<pSpriteLayer),y
    inc a
    sta <SpriteChar
    stz <charPatternOffset
rts
NextPattern:
    lda <pMixedPattern | clc|adc #PatternSize | sta <pMixedPattern
    lda <pMixedPattern+1 | adc #0 | sta <pMixedPattern+1
rts
LoadSprite4Bytes:
    ldy <spritePatternOffset
    ldx #0
    do
        lda (<pSpritePattern),y | iny
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
        lda (<pSpritePattern),y | iny
        sta <SpriteBytes,x
        inx
        cpx #8
    while ne | wend
    sty <spritePatternOffset
rts
MixLeftBytes:
    ldy <charPatternOffset
    ldx #0
    do
        lda <SpriteBytes,x | inx
        eor #$ff
        and (<pPattern),y
        ora <SpriteBytes,x | inx
        sta (<pMixedPattern),y
        iny
        cpx #4
    while ne | wend
    sty <charPatternOffset
rts
MixRightBytes:
    ldy <charPatternOffset
    ldx #0
    do
        lda <SpriteBytes+4,x | inx
        eor #$ff
        and (<pPattern),y
        ora <SpriteBytes+4,x | inx
        sta (<pMixedPattern),y
        iny
        cpx #4
    while ne | wend
    sty <charPatternOffset
rts
CopyBackground:
    ldy <charPatternOffset
    lda (<pPattern),y
    sta (<pMixedPattern),y
    iny
    lda (<pPattern),y
    sta (<pMixedPattern),y
    iny
    sty <charPatternOffset
rts
MixStraight:
    jsr LoadSprite4Bytes
    jsr MixLeftBytes
rts
MixLeft:
    jsr LoadSprite4Bytes
    ldx <shiftCount
    do
        asl <SpriteBytes | rol <SpriteBytes+2
        asl <SpriteBytes+1 | rol <SpriteBytes+3
        dex
    while ne | wend
    jsr MixLeftBytes
rts
MixCenter:
    jsr LoadSprite8Bytes
    ldx <shiftCount
    do
        asl <SpriteBytes | rol <SpriteBytes+2 | rol <SpriteBytes+4 | rol <SpriteBytes+6
        asl <SpriteBytes+1 | rol <SpriteBytes+3 | rol <SpriteBytes+5 | rol <SpriteBytes+7
        dex
    while ne | wend
    jsr MixRightBytes
rts
MixRight:
    jsr LoadSprite4Bytes
    stz <SpriteBytes+4
    stz <SpriteBytes+5
    stz <SpriteBytes+6
    stz <SpriteBytes+7
    ldx <shiftCount
    do
        asl <SpriteBytes | rol <SpriteBytes+2 | rol <SpriteBytes+4 | rol <SpriteBytes+6
        asl <SpriteBytes+1 | rol <SpriteBytes+3 | rol <SpriteBytes+5 | rol <SpriteBytes+7
        dex
    while ne | wend
    jsr MixRightBytes
rts
