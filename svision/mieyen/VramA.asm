include "Port.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
; include "Chars.inc"

ext CharPattern,SpritePattern
ext VVram_

CharPatternWidth equ 2
CharPatternSize equ CharPatternWidth*CharHeight
WindowTop equ Vram+VramRowSize*2
Sprite_End equ 13
SpritePatternWidth equ 3

dseg
Backup: public Backup
    defs VVramWidth*VVramHeight

pVram equ ZW0
pVVram equ ZW1
pLcdRam equ ZW1
pBackup equ ZW2
charPatternOffset equ ZB0
vramOffset equ ZB1
xCount equ ZB1
yCount equ ZB2
spritePatternOffset equ ZB3
vvramOffset equ ZB4
dotCount equ ZB5
byteCount equ ZB6

zseg
SpriteChar: public SpriteChar
    defb 0
xMod:
    defb 0
pMixedPattern:
    defw 0
pCharPattern:
    defw 0
patternWord:
    defw 0
pSpritePattern:
    defw 0
maskBytes:
    defs 4
patternBytes:
    defs 4


cseg
InitVram: public InitVram
    lda #160 | sta Lcd_X_Size
    lda #160 | sta Lcd_Y_Size
    stz X_Scroll
    stz Y_Scroll
rts


; void PresentVram();
PresentVram_: public PresentVram_
    pha
        stz <pVram | lda #high VramOrg | sta <pVram+1
        stz <pLcdRam | lda #high LcdRamTop | sta <pLcdRam+1
        ldx #DmaLengthValue/16
        do
            ldy #0
            do
                lda (<pVram),y | sta (<pLcdRam),y
                iny
            while ne | wend
            inc <pVram+1
            inc <pLcdRam+1
            dex
        while ne | wend
    pla
rts


; void ClearScreen();
cseg
Clear:
    sta pVram+1 | stz pVram
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
rts
ClearScreen_: public ClearScreen_
    pha
        lda #high VramOrg | ldx #$14 | jsr Clear
        lda #high LcdRam | ldx #$1e | jsr Clear

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1
        ldx #VVramHeight
        do
            ldy #0 | tya
            do
                sta (<pBackup),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pBackup | clc|adc #VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #0 | sta <pBackup+1
            dex
        while ne | wend

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
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
    pla
rts


cseg
CharPatternPtr:
    sta <pCharPattern | stz <pCharPattern+1
    asl a | rol <pCharPattern+1 ;*2
    clc|adc <pCharPattern | sta <pCharPattern
    lda #0 | adc <pCharPattern+1 | sta <pCharPattern+1 ;*3
    lda <pCharPattern
    asl a | rol <pCharPattern+1 ;*6
    asl a | rol <pCharPattern+1 ;*12
    sta <pCharPattern
    lda <pCharPattern | clc|adc #low CharPattern | sta <pCharPattern
    lda <pCharPattern+1 | adc #high CharPattern | sta <pCharPattern+1
rts

PutL:
    jsr CharPatternPtr
    stz <charPatternOffset
    stz <vramOffset
    ldx #CharHeight
    do
        ldy <charPatternOffset
        lda (<pCharPattern),y | iny
        sta <patternWord
        lda (<pCharPattern),y | iny
        sta <patternWord+1
        sty <charPatternOffset
        
        ldy <vramOffset
        lda <patternWord | sta (<pVram),y | iny
        lda (<pVram),y
        and #$f0 | ora <patternWord+1
        sta (<pVram),y
        tya | clc|adc #VramWidth-1 | sta <vramOffset
        dex
    while ne | wend
rts

PutR:
    jsr CharPatternPtr
    stz <charPatternOffset
    stz <vramOffset
    ldx #CharHeight
    do
        ldy <charPatternOffset | lda (<pCharPattern),y | iny
        sta <patternWord
        lda (<pCharPattern),y | iny | sty <charPatternOffset
        sta <patternWord+1 | lda <patternWord
        asl a | rol <patternWord+1
        asl a | rol <patternWord+1
        asl a | rol <patternWord+1
        asl a | rol <patternWord+1
        sta <patternWord

        ldy <vramOffset | lda (<pVram),y
        and #$0f | ora <patternWord
        sta (<pVram),y | iny
        lda <patternWord+1 | sta (<pVram),y
        tya | clc|adc #VramWidth-1 | sta <vramOffset
        dex
    while ne | wend
rts


; word Put(word vram, byte c);
dseg
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
zseg
xPos:
    defb 0
yPos:
    defb 0
cseg
YTable:
    defw Vram+$0,Vram+$120,Vram+$240,Vram+$360,Vram+$480,Vram+$5A0,Vram+$6C0,Vram+$7E0,Vram+$900,Vram+$A20,Vram+$B40,Vram+$C60,Vram+$D80,Vram+$EA0,Vram+$FC0,Vram+$10E0,Vram+$1200
Put_: public Put_
    pha
        stx <yPos | sty <xPos
        
        txa | asl a | tax
        lda YTable,x | sta <pVram
        lda YTable+1,x | sta <pVram+1

        lda <xPos
        asl a ;*2
        adc <xPos ;*3
        lsr a ;/2
        clc|adc <pVram | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1

        lda <xPos
        and #1
        if ne
            lda Put_c
            jsr PutR
        else
            lda Put_c
            jsr PutL
        endif
        ldy <xPos | ldx <yPos
        iny
        if eq
            inx
        endif
    pla
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pha
        lda #low WindowTop | sta <pVram
        lda #high WindowTop | sta <pVram+1

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #VVramHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pVVram),y
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    phy
                        jsr PutL
                    ply
                endif
                lda <pVram | clc|adc #1 | sta <pVram
                lda <pVram+1 | adc #0 | sta <pVram+1
                iny

                lda (<pVVram),y
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    phy
                        jsr PutR
                    ply
                endif
                lda <pVram | clc|adc #2 | sta <pVram
                lda <pVram+1 | adc #0 | sta <pVram+1
                iny
                
                cpy #VVramWidth
            while ne | wend
            lda <pVram | clc|adc #low(VramRowSize-3*VVramWidth/2) | sta <pVram
            lda <pVram+1 | adc #high(VramRowSize-3*VVramWidth/2) | sta <pVram+1

            lda <pVVram | clc|adc #VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            lda <pBackup | clc|adc #VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #0 | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts

CoordShift equ 1
CoordRate equ 1 shl CoordShift
CoordMask equ CoordRate-1

dseg
Param_x:
    defb 0
DrawSprite_@Param1: public DrawSprite_@Param1
EraseBackup_@Param1: public EraseBackup_@Param1
Param_y:
    defb 0
DrawSprite_@Param2: public DrawSprite_@Param2
Param_pattern:
    defb 0

cseg
; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    pha
        sty Param_x
        lda #2 | sta <xCount | sta <yCount
        lda #0 | sta <pBackup+1
        
        lda Param_y | tay
        and #CoordMask
        if ne
            inc <yCount
        endif
        tya
        and #not CoordMask | sta <pBackup
        lsr a | clc|adc <pBackup ;*3
        asl a | rol <pBackup+1 ;*6
        asl a | rol <pBackup+1 ;*12
        asl a | rol <pBackup+1 ;*24
        clc|adc #low Backup | sta <pBackup
        lda <pBackup+1 | adc #high Backup | sta <pBackup+1

        lda Param_x | tax
        and #CoordMask
        if ne
            inc <xCount
        endif
        txa
        lsr a
        clc|adc <pBackup | sta <pBackup
        lda <pBackup+1 | adc #0 | sta <pBackup+1

        do
            lda #$ff
            ldy #0
            ldx <xCount
            do
                sta (<pBackup),y | iny
                dex
            while ne | wend
            lda <pBackup | clc|adc #VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #0 | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts


; void DrawSprite(byte x, byte y, byte pattern);
cseg
Multi9:
    sta 0,x | stz 1,x
    asl a | rol 1,x ;*2
    asl a | rol 1,x ;*4
    asl a | rol 1,x ;*8
    clc|adc 0,x | sta 0,x
    lda 1,x | adc #0 | sta 1,x ;*9
rts
DrawSprite_: public DrawSprite_
    pha
        sty Param_x
        lda Param_y
        ldx #pVram | jsr Multi9
        lda <pVram
        asl a | rol <pVram+1 ;*18
        asl a | rol <pVram+1 ;*36
        asl a | rol <pVram+1 ;*72
        asl a | rol <pVram+1 ;*144
        sta <pVram
        lda Param_x
        asl a ;*2
        clc|adc Param_x ;*3
        tax
        lsr a ;/2
        lsr a ;/4
        clc|adc <pVram | sta <pVram
        lda <pVram+1 | adc #0 | sta <pVram+1
        lda <pVram | clc|adc #low Vram | sta <pVram
        lda <pVram+1 | adc #high Vram | sta <pVram+1
        txa

        asl a ;*6
        and #7
        sta <xMod

        lda Param_pattern
        ldx #pSpritePattern | jsr Multi9
        lda <pSpritePattern
        asl a | rol <pSpritePattern+1 ;*18
        asl a | rol <pSpritePattern+1 ;*36
        asl a | rol <pSpritePattern+1 ;*72
        clc|adc #low SpritePattern | sta <pSpritePattern
        lda <pSpritePattern+1 | adc #high SpritePattern | sta <pSpritePattern+1
        stz <spritePatternOffset

        lda #CharHeight*2 | sta <yCount
        do
            ldy <spritePatternOffset
            ldx #0
            do
                lda (<pSpritePattern),y | iny
                sta <maskBytes,x
                lda (<pSpritePattern),y | iny
                sta <patternBytes,x
                inx | cpx #3
            while ne | wend
            stz <maskBytes,x | stz <patternBytes,x
            sty <spritePatternOffset

            ldx <xMod
            if ne
                do
                    asl <maskBytes+0 | rol <maskBytes+1 | rol <maskBytes+2 | rol <maskBytes+3
                    asl <patternBytes+0 | rol <patternBytes+1 | rol <patternBytes+2 | rol <patternBytes+3
                    dex
                while ne | wend
            endif

            ldx #0 | ldy #0
            do
                lda <maskBytes,x
                if ne
                    eor #$ff | and (<pVram),y | ora <patternBytes,x | sta (<pVram),y
                endif
                inx | iny
                cpy #4
            while ne | wend
            lda <pVram | clc|adc #VramWidth | sta <pVram
            lda <pVram+1 | adc #0 | sta <pVram+1

            dec <yCount
        while ne | wend
    pla
rts
