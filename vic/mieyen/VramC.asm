include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext CharPattern
ext CharColors

cseg
PatternRamAddress: public PatternRamAddress
    sta 0,x
    lda #0 | sta 1,x
    asl 0,x | rol 1,x ; *2
    asl 0,x | rol 1,x ; *4
    asl 0,x | rol 1,x ; *8
    lda 0,x | clc | adc #low(PatternRam) | sta 0,x
    lda 1,x | adc #high(PatternRam) | sta 1,x
rts

zseg
pVram defw 0
pDestionationPattern defw 0
leftMask defb 0
rightMask defb 0
dseg
shiftCount defb 0
vramOffset defb 0
char defb 0

; void LocatePattern(ptr<byte> pVram, byte xMod, byte c);
dseg
LocatePattern_@Param1: public LocatePattern_@Param1
LocatePattern_xMod:
    defb 0
LocatePattern_@Param2: public LocatePattern_@Param2
LocatePattern_c:
    defb 0
cseg
LocatePattern_: public LocatePattern_
    pha
        sty <pVram
        stx <pVram+1

        lda #0 | sta vramOffset
        lda #$00 | sta <leftMask
        lda #$fc | sta <rightMask

        lda LocatePattern_xMod
        and #3
        asl a   ;*2
        sta shiftCount
        if ne
            tax
            do
                lda <leftMask
                asl a
                ora #$01
                sta <leftMask
                asl <rightMask
                dex
            while ne | wend
        endif

        lda LocatePattern_c
        sta char
        ldx #pDestionationPattern
        jsr PatternRamAddress
    pla
rts


; void PutPattern(byte pattern);
pSourcePattern equ ZW0
existingPatternMask equ ZB0
sourceShiftCount equ ZB1
pExsitingPattern equ ZW1
cseg
PutPattern_: public PutPattern_
    lda #0 | sta <pSourcePattern+1
    tya
    asl a | rol <pSourcePattern+1 ;*2
    asl a | rol <pSourcePattern+1 ;*4
    asl a | rol <pSourcePattern+1 ;*8
    clc|adc #low CharPattern | sta <pSourcePattern
    lda <pSourcePattern+1 | adc #high CharPattern | sta pSourcePattern+1;

    lda <leftMask
    if ne
        eor #$ff
        sta <existingPatternMask
        lda #8 | sec | sbc shiftCount | sta <sourceShiftCount
        
        ldy vramOffset
        lda (<pVram),y
        ldx #pExsitingPattern | jsr PatternRamAddress
        ldy #0
        do
            lda (<pExsitingPattern),y
            and <existingPatternMask
            sta (<pDestionationPattern),y
            
            lda (<pSourcePattern),y
            ldx <sourceShiftCount
            do
                lsr a
                dex
            while ne | wend                    

            and <leftMask
            ora (<pDestionationPattern),y
            sta (<pDestionationPattern),y
            iny
            cpy #8
        while ne | wend

        lda char
        ldy vramOffset
        sta (<pVram),y
        inc char
        iny | sty vramOffset

        lda <pDestionationPattern | clc | adc #8 | sta <pDestionationPattern
        lda <pDestionationPattern+1 | adc #0 | sta <pDestionationPattern+1
    endif

    lda <rightMask
    if ne
        eor #$ff
        sta <existingPatternMask

        ldy vramOffset
        lda (<pVram),y
        ldx #pExsitingPattern | jsr PatternRamAddress

        ldy #0
        do
            lda (<pExsitingPattern),y
            and <existingPatternMask
            sta (<pDestionationPattern),y

            lda (<pSourcePattern),y
            ldx shiftCount
            if ne
                do
                    asl a
                    dex
                while ne | wend
            endif

            and <rightMask
            ora (<pDestionationPattern),y
            sta (<pDestionationPattern),y
            iny
            cpy #8
        while ne | wend

        lda char
        ldy vramOffset
        sta (<pVram),y
    endif

    lda shiftCount
    clc | adc #2 | and #7
    sta shiftCount

    lda <leftMask
    asl a | asl a
    ora #$03
    cmp #$ff
    if eq
        lda #0
    endif
    sta <leftMask

    lda <rightMask
    if ne
        asl a | asl a
    else
        lda #$fc
    endif
    sta <rightMask
rts


; void SetSpriteColor(byte sprite, byte color);
dseg
SetSpriteColor_@Param1: public SetSpriteColor_@Param1
SetSpriteColor_color:
    defb 0
cseg
SetSpriteColor_: public SetSpriteColor_
    pha
        tya
        sta <ZB0
        asl a ;*2
        adc <ZB0 ;*3
        asl a ;*6
        adc #Char_Sprite
        tay
        lda SetSpriteColor_color
        ldx #6
        do
            sta CharColors,y | iny
            dex
        while ne | wend
    pla
rts


; void PutColor(ptr<byte> pVram, byte color, byte count);
dseg
PutColor_@Param1: public PutColor_@Param1
PutColor_color:
    defb 0
PutColor_@Param2: public PutColor_@Param2
PutColor_count:
    defb 0
cseg
PutColor_: public PutColor_
    pha
        sty <pVram
        txa | clc|adc #high(ColorMap-Vram) | sta <pVram+1
        
        lda PutColor_color
        ldy #0
        ldx PutColor_count
        do
            sta (<pVram),y | iny
            dex
        while ne | wend        
    pla
rts
