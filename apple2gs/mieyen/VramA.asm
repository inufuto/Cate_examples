include "apple2.inc"
include "apple2gs.inc"
include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

VramTop equ Vram+VramRowSize*1
CharPatternSize equ VramStep*CharHeight

dseg
Backup: public Backup
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*(VVramHeight+2)
CharPatternRam: public CharPatternRam
    defs CharPatternSize*Char_End
MixedPattern: public MixedPattern
    defs CharPatternSize*9*32
zseg
pMixedPattern:
    defw 0


sourceOffset equ ZB0
yCount equ ZB0
destinationOffset equ ZB1
yCount2 equ ZB1
cCount equ ZB2
xMod equ ZB2
colorByte equ ZB3
yMod equ ZB3
sourceByte equ ZB4
xCount equ ZB5
xOffset equ ZB5
xCount2 equ ZB6
destinationByte equ ZB7

pSource equ ZW0
pCharPattern equ ZW0
pDestination equ ZW1
pVram equ ZW1
pVVram equ ZW1
pBackup equ ZW2
pSpritePattern equ ZW2
pSpriteLayer equ ZW3


cseg
PaletteValues:
defb	$00, $00, $0f, $00, $00, $0f, $bf, $0f
defb	$b0, $0f, $ff, $0f, $f0, $0f, $ff, $00
defb	$bf, $00, $00, $0f, $f0, $0f, $05, $05
defb	$f0, $00, $00, $00, $55, $0f, $bb, $0f
ColorTable:
defb 64,5 ;Ascii
defb 16,7 ;Logo
defb 16,1 ;Wall
defb 4,6 ;Dot
defb 0
InitVram: public InitVram
    sep #$30 | a8 | i8

    lda CLOCKCTL
    and #$f0
    sta CLOCKCTL

    lda NEWVIDEO
    ora #$c0
    sta NEWVIDEO

    lda #$00
    ldx #0
    do
        sta SCB,x
        inx
        cpx #200
    while ne | wend

    rep #$20 | a16
    ldx #0
    do
        lda PaletteValues,x
        sta Palettes,x
        inx | inx
        cpx #16*2
    while ne | wend


    lda #MonoPattern | sta <pSource
    lda #CharPatternRam | sta <pDestination
    sep #$20 | a8

    ldx #0
    do
        lda ColorTable,x
    while ne
        inx
        sta <cCount
        lda ColorTable,x | inx
        sta <colorByte

        jsr InitMono
    wend

    rep #$30 | a16 | i16
    ldx #0
    do
        lda ColorPattern,x
        sta CharPatternRam+CharPatternSize*Char_Color,x
        inx | inx
        cpx #CharPatternSize*(Char_End-Char_Color)
    while ne | wend
rts

InitMono:
    a8 | i8
    do
        stz <sourceOffset
        stz <destinationOffset
        do
            ldy <sourceOffset | lda (<pSource),y | iny | sty <sourceOffset
            sta <sourceByte
            lda #VramStep | sta <xCount
            do
                stz <destinationByte
                lda #8/VramStep | sta <xCount2
                do
                    lda <destinationByte
                    asl a | asl a | asl a | asl a
                    sta <destinationByte

                    asl <sourceByte
                    if cs
                        lda <colorByte
                        and #$0f
                        ora <destinationByte
                        sta <destinationByte
                    else
                        lda <colorByte
                        lsr a | lsr a | lsr a | lsr a
                        ora <destinationByte
                        sta <destinationByte
                    endif
                    dec <xCount2
                while ne | wend
                ldy <destinationOffset | sta (<pDestination),y | iny |sty <destinationOffset

                dec <xCount
            while ne | wend
            ldy <sourceOffset | cpy #CharHeight
        while ne | wend
        rep #$20 | a16
        lda <pSource | clc|adc #CharHeight | sta <pSource
        lda <pDestination | clc|adc #VramStep*CharHeight | sta <pDestination
        sep #$20 | a8

        dec <cCount
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    php
        rep #$30 | a16 | i16
        pha | phx
            lda #0
            ldx #0 | txa
            do
                sta VramBankLong+Vram,x
                inx | inx
                cpx #VramRowSize*VramHeigth
            while ne | wend

            ldx #0
            do
                sta VVram_,x
                inx | inx
                cpx #VVramWidth*VVramHeight
            while ne | wend
            ldx #0
            do
                sta Backup,x
                inx | inx
                cpx #VVramWidth*VVramHeight
            while ne | wend
        plx | pla
    plp
rts


; word Put(word vram, byte c);
cseg
ToCharPatternRamY:
    asl a | asl a | asl a | asl a | asl a ; * 32
    clc|adc #CharPatternRam
    tay
rts
Put: ; (x,y)
    sep #$20 | a8
    lda #CharHeight | sta <yCount
    do
        lda #VramStep/2 | sta <xCount
        do
            rep #$20 | a16
            lda >0,y | iny | iny
            sta VramBankLong,x | inx | inx
            sep #$20 | a8
            dec <xCount
        while ne | wend
        rep #$20 | a16
        txa | clc|adc #VramWidth-VramStep | tax
        sep #$20 | a8
        dec <yCount
    while ne | wend
rts
Put_vram equ @zp+0
Put_c equ @zp+2
Put_return equ @zp+0
Put_: public Put_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            ldx <Put_vram
            lda <Put_c
            and #$00ff
            jsr ToCharPatternRamY
            jsr Put
            rep #$20 | a16
            lda <Put_vram
            clc|adc #VramStep
            sta <Put_return
        ply | plx | pla
    plp
rts


; word PrintC(word vram, byte c);
PrintC_vram equ @zp+0
PrintC_c equ @zp+2
PrintC_return equ @zp+0
cseg
PrintC_: public PrintC_
    php
        sep #$20 | a8
        pha
        lda <PrintC_c | pha
            sec|sbc #$20
            sta <Put_c
            jsr Put_
        sep #$20 | a8
        pla | sta <PrintC_c
        pla
    plp
rts


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            lda #MixedPattern | sta <pMixedPattern
            sep #$20 | a8
            ldx #0 | ldy #0
            do
                lda VVram_,x | inx
                sta SpriteLayer,y | iny
                lda #0
                sta SpriteLayer,y | iny
                cpx #VVramWidth*VVramHeight
            while ne | wend
        rep #$20 | a16
        ply | plx | pla
    plp
rts


; void EndDraw();
cseg
EndDraw_: public EndDraw_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            lda #VramTop | sta <pVram
            lda #SpriteLayer | sta <pSpriteLayer
            lda #Backup | sta <pBackup
            sep #$20 | a8
            lda #VVramHeight | sta <yCount2
            do
                lda #VVramWidth | sta <xCount2
                do
                    rep #$20 | a16
                    lda (<pSpriteLayer)
                    bit #$ff00
                    if eq
                        sep #$20 | a8
                        cmp (<pBackup)
                        if ne
                            sta (<pBackup)
                            rep #$30 | a16 | i16
                            jsr ToCharPatternRamY
                            ldx <pVram
                            jsr Put
                        endif
                    else
                        rep #$30 | a16 | i16
                        tay
                        ldx <pVram
                        jsr Put
                        sep #$20 | a8
                        lda #$ff | sta (<pBackup)
                    endif
                    rep #$20 | a16
                    lda <pVram | inc a | inc a | inc a | inc a | sta <pVram
                    lda <pSpriteLayer | inc a | inc a | sta <pSpriteLayer
                    lda <pBackup | inc a | sta <pBackup

                    sep #$20 | a8
                    dec <xCount2
                while ne | wend
                rep #$20 | a16
                lda <pVram
                clc|adc #VramRowSize - VramStep*VVramWidth
                sta <pVram

                sep #$20 | a8
                dec <yCount2
            while ne | wend
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts


; void DrawSprite(byte x, byte y, byte pattern);
DrawSprite_x equ @zp+0
DrawSprite_y equ @zp+2
DrawSprite_pattern equ @zp+4
cseg
DrawSprite_: public DrawSprite_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            lda <DrawSprite_x
            sta <xMod

            lsr a
            rep #$20 | a16
            and #$003e | sta <pSpriteLayer
            sep #$20 | a8
            lda <DrawSprite_y
            rep #$20 | a16
            asl a | asl a | asl a | asl a
            and #$0fc0 | clc|adc <pSpriteLayer
            adc #SpriteLayer
            sta <pSpriteLayer
            
            sep #$20 | a8
            lda <DrawSprite_y | and #3 | asl a | sta <yMod
            rep #$20 | a16

            sep #$20 | a8
            lda <DrawSprite_pattern
            rep #$20 | a16
            and #$00ff
            xba | lsr a
            clc|adc #SpritePattern
            ldx <yMod
            if ne
                do
                    sec|sbc #VramStep*2
                    dex
                while ne | wend
            endif
            sta <pSpritePattern

            sep #$20 | a8
            lda <xMod | and #3 | sta <xMod
            if ne
                rep #$10 | i16
                ldx <pSpritePattern
                do
                    dex
                    dec a
                while ne | wend
                stx <pSpritePattern
                sep #$10 | i8
            endif
            
            stz <xOffset
            rep #$20 | a16
            ;TopLeft
            jsr MakeSource
            ldx #0
            jsr CopyUpper
            jsr MixLowerLeft
            jsr NextColumn
            ;TopCenter
            jsr MakeSource
            ldx #0
            jsr CopyUpper
            jsr MixLowerCenter
            jsr NextColumn
            ; TopRight
            jsr MakeSource
            ldx #0
            jsr CopyUpper
            jsr MixLowerRight

            jsr NextRow
            stz <xOffset
            ;CenterLeft
            jsr MakeSource
            ldx #0
            jsr MixLowerLeft
            jsr NextColumn
            ;CenterCenter
            jsr MakeSource
            ldx #0
            jsr MixLowerCenter
            jsr NextColumn
            ;CenterRight
            jsr MakeSource
            ldx #0
            jsr MixLowerRight

            jsr NextRow
            stz <xOffset
            ; BottomLeft
            jsr MakeSource
            ldx #0
            jsr MixUpperLeft
            jsr CopyLower
            jsr NextColumn
            ; BottomCenter
            jsr MakeSource
            ldx #0
            jsr MixUpperCenter
            jsr CopyLower
            jsr NextColumn
            ; BottomRight
            jsr MakeSource
            ldx #0
            jsr MixUpperRight
            jsr CopyLower
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts
MakeSource:
    i8 | a16
    ldy <xOffset
    lda (<pSpriteLayer),y
    bit #$ff00
    if eq
        asl a | asl a | asl a | asl a | asl a
        clc|adc #CharPatternRam
    endif
    sta <pCharPattern
    lda <pMixedPattern
    sta (<pSpriteLayer),y
    iny | iny
    sty <xOffset
    sep #$20 | a8
rts
MixByte:
    a8 | i8
    lda (<pSpritePattern),y
    if eq
        lda (<pCharPattern),y
        bra MixByte_sta
    endif
    bit #$f0
    if ne
        bit #$0f
        bne MixByte_sta
        and #$f0
        sta <sourceByte
        lda (<pCharPattern),y
        and #$0f
        ora <sourceByte
        bra MixByte_sta
    endif
    and #$0f
    sta <sourceByte
    lda (<pCharPattern),y
    and #$f0
    ora <sourceByte
    MixByte_sta:
    sta (<pMixedPattern),y
    iny
rts
CopyByte:
    a8 | i8
    lda (<pCharPattern),y
    sta (<pMixedPattern),y
    iny
rts
NextY:
    rep #$20 | a16
    lda <pSpritePattern | clc|adc #VramStep*2 | sta <pSpritePattern
    lda <pCharPattern | clc|adc #VramStep | sta <pCharPattern
    lda <pMixedPattern | clc|adc #VramStep | sta <pMixedPattern
    sep #$20 | a8
rts
NextColumn:
    rep #$20 | a16
    lda <pSpritePattern
    clc|adc #VramStep-VramStep*2*CharHeight
    sta <pSpritePattern
rts
NextRow:
    rep #$20 | a16
    lda <pSpritePattern
    clc|adc #-VramStep*2
    sta <pSpritePattern

    lda <pSpriteLayer
    clc|adc #VVramWidth*2
    sta <pSpriteLayer
rts
CopyUpper:
    a8 | i8
    lda <yMod
    if ne
        do
            ldy #0
            do
                jsr CopyByte
                cpy #VramStep
            while ne | wend
            jsr NextY
            inx
            cpx <yMod
        while cc | wend
    endif
rts
CopyLower:
    a8 | i8
    do
        ldy #0
        do
            jsr CopyByte
            cpy #VramStep
        while ne | wend
        jsr NextY
        inx
        cpx #CharHeight
    while cc | wend
rts
MixLowerLeft:
    a8 | i8
    do
        ldy #0
        lda <xMod
        if ne
            do
                jsr CopyByte
                cpy <xMod
            while cc | wend
        endif
        do
            jsr MixByte
            cpy #VramStep
        while ne | wend
        jsr NextY
        inx
        cpx #CharHeight
    while ne | wend
rts
MixLowerCenter:
    a8 | i8
    do
        ldy #0
        do
            jsr MixByte
            cpy #VramStep
        while ne | wend
        jsr NextY
        inx
        cpx #CharHeight
    while ne | wend
rts
MixLowerRight:
    a8 | i8
    do
        ldy #0
        lda <xMod
        if ne
            do
                jsr MixByte
                cpy <xMod
            while cc | wend
        endif
        do
            jsr CopyByte
            cpy #VramStep
        while ne | wend
        jsr NextY
        inx
        cpx #CharHeight
    while ne | wend
rts
MixUpperLeft:
    a8 | i8
    lda <yMod
    if ne
        do
            ldy #0
            lda <xMod
            if ne
                do
                    jsr CopyByte
                    cpy <xMod
                while cc | wend
            endif
            do
                jsr MixByte
                cpy #VramStep
            while ne | wend
            jsr NextY
            inx
            cpx <yMod
        while cc | wend
    endif
rts
MixUpperCenter:
    a8 | i8
    lda <yMod
    if ne
        do
            ldy #0
            do
                jsr MixByte
                cpy #VramStep
            while ne | wend
            jsr NextY
            inx
            cpx <yMod
        while cc | wend
    endif
rts
MixUpperRight:
    a8 | i8
    lda <yMod
    if ne
        do
            ldy #0
            lda <xMod
            if ne
                do
                    jsr MixByte
                    
                    cpy <xMod
                while cc | wend
            endif
            do
                jsr CopyByte
                cpy #VramStep
            while ne | wend
            jsr NextY
            inx
            cpx <yMod
        while cc | wend
    endif
rts
