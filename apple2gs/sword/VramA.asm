include "apple2.inc"
include "apple2gs.inc"
include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

VramTop equ Vram+VramRowSize*2
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

scope
pSource equ ZW0
pDestination equ ZW1

cCount equ ZB0
colorByte equ ZB1
sourceOffset equ ZB2
destinationOffset equ ZB3
xCount equ ZB4
sourceByte equ ZB5
destinationByte equ ZB6
xCount2 equ ZB7

cseg
PaletteValues:
defb	$00, $00, $0f, $00, $00, $0f, $0f, $0f
defb	$f0, $00, $ff, $00, $f0, $0f, $ff, $0f
defb	$00, $00, $09, $00, $00, $09, $09, $09
defb	$9f, $00, $f9, $00, $90, $0f, $99, $09
ColorTable:
defb 64,7 ;Ascii
defb 15,14 ;Logo
defb 2,1 ;Fence
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


    lda #MonoPattern | sta pSource
    lda #CharPatternRam | sta pDestination
    sep #$20 | a8

    ldx #0
    do
        lda ColorTable,x
    while ne
        inx
        sta cCount
        lda ColorTable,x | inx
        sta colorByte

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
        stz sourceOffset
        stz destinationOffset
        do
            ldy sourceOffset | lda (pSource),y | iny | sty sourceOffset
            sta sourceByte
            lda #VramStep | sta xCount
            do
                stz destinationByte
                lda #8/VramStep | sta xCount2
                do
                    lda destinationByte
                    asl a | asl a | asl a | asl a
                    sta destinationByte

                    asl sourceByte
                    if cs
                        lda colorByte
                        and #$0f
                        ora destinationByte
                        sta destinationByte
                    else
                        lda colorByte
                        lsr a | lsr a | lsr a | lsr a
                        ora destinationByte
                        sta destinationByte
                    endif
                    dec xCount2
                while ne | wend
                ldy destinationOffset | sta (pDestination),y | iny |sty destinationOffset

                dec xCount
            while ne | wend
            ldy sourceOffset | cpy #CharHeight
        while ne | wend
        rep #$20 | a16
        lda pSource | clc|adc #CharHeight | sta pSource
        lda pDestination | clc|adc #VramStep*CharHeight | sta pDestination
        sep #$20 | a8

        dec cCount
    while ne | wend
rts
endscope

scope
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
endscope


scope

yCount equ ZB0
xCount equ ZB1

cseg
a16 | i16
ToCharPatternRamY: public ToCharPatternRamY
    asl a | asl a | asl a | asl a | asl a ; * 32
    clc|adc #CharPatternRam
    tay
rts
Put: public Put ; (x,y)
    sep #$20 | a8
    lda #CharHeight | sta yCount
    do
        lda #VramStep/2 | sta xCount
        do
            rep #$20 | a16
            lda >0,y | iny | iny
            sta VramBankLong,x | inx | inx
            sep #$20 | a8
            dec xCount
        while ne | wend
        rep #$20 | a16
        txa | clc|adc #VramWidth-VramStep | tax
        sep #$20 | a8
        dec yCount
    while ne | wend
rts

; word Put(word vram, byte c);
Put_vram equ @zp+0
Put_c equ @zp+2
Put_return equ @zp+0
Put_: public Put_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            ldx Put_vram
            lda Put_c
            and #$00ff
            jsr ToCharPatternRamY
            jsr Put
            rep #$20 | a16
            lda Put_vram
            clc|adc #VramStep
            sta Put_return
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
        lda PrintC_c | pha
            sec|sbc #$20
            sta Put_c
            jsr Put_
        sep #$20 | a8
        pla | sta PrintC_c
        pla
    plp
rts
endscope


scope
; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            lda #MixedPattern | sta pMixedPattern
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
endscope


scope

pVram equ ZW0
pSpriteLayer equ ZW1
pBackup equ ZW2

yCount2 equ ZB2
xCount2 equ ZB3

; void EndDraw();
cseg
EndDraw_: public EndDraw_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            lda #VramTop | sta pVram
            lda #SpriteLayer | sta pSpriteLayer
            lda #Backup | sta pBackup
            sep #$20 | a8
            lda #VVramHeight | sta yCount2
            do
                lda #VVramWidth | sta xCount2
                do
                    rep #$20 | a16
                    lda (pSpriteLayer)
                    bit #$ff00
                    if eq
                        sep #$20 | a8
                        cmp (pBackup)
                        if ne
                            sta (pBackup)
                            rep #$30 | a16 | i16
                            jsr ToCharPatternRamY
                            ldx pVram
                            jsr Put
                        endif
                    else
                        rep #$30 | a16 | i16
                        tay
                        ldx pVram
                        jsr Put
                        sep #$20 | a8
                        lda #$ff | sta (pBackup)
                    endif
                    rep #$20 | a16
                    lda pVram | inc a | inc a | inc a | inc a | sta pVram
                    lda pSpriteLayer | inc a | inc a | sta pSpriteLayer
                    lda pBackup | inc a | sta pBackup

                    sep #$20 | a8
                    dec xCount2
                while ne | wend
                rep #$20 | a16
                lda pVram
                clc|adc #VramRowSize - VramStep*VVramWidth
                sta pVram

                sep #$20 | a8
                dec yCount2
            while ne | wend
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts
endscope


scope

pSpriteLayer equ ZW0
pSpritePattern equ ZW1
pCharPattern equ ZW2

spriteLayerOffset equ ZB0
spritePatternOffset equ ZB1
charPatternOffset equ ZB2
xCount equ ZB3
yCount equ ZB4
xCount2 equ ZB5
yCount2 equ ZB6
charByte equ ZB7
sourceByte equ ZW3+0

; void DrawSprite(byte x, byte y, byte pattern);
DrawSprite_x equ @zp+0
DrawSprite_y equ @zp+2
DrawSprite_pattern equ @zp+4
cseg
DrawSprite_: public DrawSprite_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$10 | i8
            
            lda DrawSprite_x
            and #$00fe | sta pSpriteLayer
            lda DrawSprite_y
            and #$00fe
            asl a | asl a | asl a | asl a | asl a ; *32
            clc|adc pSpriteLayer
            adc #SpriteLayer
            sta pSpriteLayer
            
            lda DrawSprite_pattern
            and #$00ff
            xba | lsr a
            clc|adc #SpritePattern
            sta pSpritePattern
            
            sep #$20 | a8
            stz spriteLayerOffset
            stz spritePatternOffset

            lda DrawSprite_y
            bit #1
            if eq
                lda DrawSprite_x
                bit #1
                if eq
                    lda #2 | sta yCount
                    do
                        lda #2 | sta xCount
                        do
                            jsr MakeSource
                            lda #CharHeight | sta yCount2
                            do
                                jsr MixCenter
                                dec yCount2
                            while ne | wend
                            lda spritePatternOffset | clc|adc #VramStep-CharPatternSize*2 | sta spritePatternOffset
                            jsr NextChar
                            dec xCount
                        while ne | wend
                        lda spritePatternOffset | clc|adc #CharPatternSize*2-VramStep*2 | sta spritePatternOffset
                        lda spriteLayerOffset | clc|adc #(VVramWidth-2)*2 | sta spriteLayerOffset
                        
                        dec yCount
                    while ne | wend
                else
                    lda #2 | sta yCount
                    do
                        ;left
                        jsr MakeSource
                        lda #CharHeight | sta yCount2
                        do
                            jsr MixLeft
                            dec yCount2
                        while ne | wend
                        lda spritePatternOffset | clc|adc #VramStep/2-CharPatternSize*2 | sta spritePatternOffset
                        jsr NextChar
                        ; center
                        jsr MakeSource
                        lda #CharHeight | sta yCount2
                        do
                            jsr MixCenter
                            dec yCount2
                        while ne | wend
                        lda spritePatternOffset | clc|adc #VramStep-CharPatternSize*2 | sta spritePatternOffset
                        jsr NextChar
                        ; right
                        jsr MakeSource
                        lda #CharHeight | sta yCount2
                        do
                            jsr MixRight
                            dec yCount2
                        while ne | wend
                        jsr NextChar
                        lda spritePatternOffset | clc|adc #-VramStep*3/2 | sta spritePatternOffset
                        lda spriteLayerOffset | clc|adc #(VVramWidth-3)*2 | sta spriteLayerOffset
                        
                        dec yCount
                    while ne | wend
                endif
            else
                lda DrawSprite_x
                bit #1
                if eq
                    ; top
                    lda #2 | sta xCount
                    do
                        jsr MakeSource
                        lda #CharHeight/2 | sta yCount2
                        do
                            jsr CopyBackground
                            dec yCount2
                        while ne | wend
                        lda #CharHeight/2 | sta yCount2
                        do
                            jsr MixCenter
                            dec yCount2
                        while ne | wend
                        lda spritePatternOffset | clc|adc #VramStep-CharPatternSize | sta spritePatternOffset
                        jsr NextChar
                        dec xCount
                    while ne | wend
                    lda spritePatternOffset | clc|adc #CharPatternSize-VramStep*2 | sta spritePatternOffset
                    lda spriteLayerOffset | clc|adc #(VVramWidth-2)*2 | sta spriteLayerOffset
                    ; middle
                    lda #2 | sta xCount
                    do
                        jsr MakeSource
                        lda #CharHeight | sta yCount2
                        do
                            jsr MixCenter
                            dec yCount2
                        while ne | wend
                        lda spritePatternOffset | clc|adc #VramStep-CharPatternSize*2 | sta spritePatternOffset
                        jsr NextChar
                        dec xCount
                    while ne | wend
                    lda spritePatternOffset | clc|adc #CharPatternSize*2-VramStep*2 | sta spritePatternOffset
                    lda spriteLayerOffset | clc|adc #(VVramWidth-2)*2 | sta spriteLayerOffset
                    ; bottom
                    lda #2 | sta xCount
                    do
                        jsr MakeSource
                        lda #CharHeight/2 | sta yCount2
                        do
                            jsr MixCenter
                            dec yCount2
                        while ne | wend
                        lda #CharHeight/2 | sta yCount2
                        do
                            jsr CopyBackground
                            dec yCount2
                        while ne | wend
                        lda spritePatternOffset | clc|adc #VramStep-CharPatternSize | sta spritePatternOffset
                        jsr NextChar
                        dec xCount
                    while ne | wend
                else
                    ; top-left
                    jsr MakeSource
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr CopyBackground
                        dec yCount2
                    while ne | wend
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr MixLeft
                        dec yCount2
                    while ne | wend
_deb: public _deb
                    lda spritePatternOffset | clc|adc #VramStep/2-CharPatternSize | sta spritePatternOffset
                    jsr NextChar
                    ; top-center
                    jsr MakeSource
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr CopyBackground
                        dec yCount2
                    while ne | wend
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr MixCenter
                        dec yCount2
                    while ne | wend
                    lda spritePatternOffset | clc|adc #VramStep-CharPatternSize | sta spritePatternOffset
                    jsr NextChar
                    ; top-right
                    jsr MakeSource
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr CopyBackground
                        dec yCount2
                    while ne | wend
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr MixRight
                        dec yCount2
                    while ne | wend
                    jsr NextChar
                    lda spritePatternOffset | clc|adc #-VramStep*3/2 | sta spritePatternOffset
                    lda spriteLayerOffset | clc|adc #(VVramWidth-3)*2 | sta spriteLayerOffset
                    ; middle-left
                    jsr MakeSource
                    lda #CharHeight | sta yCount2
                    do
                        jsr MixLeft
                        dec yCount2
                    while ne | wend
                    lda spritePatternOffset | clc|adc #VramStep/2-CharPatternSize*2 | sta spritePatternOffset
                    jsr NextChar
                    ; middle-center
                    jsr MakeSource
                    lda #CharHeight | sta yCount2
                    do
                        jsr MixCenter
                        dec yCount2
                    while ne | wend
                    lda spritePatternOffset | clc|adc #VramStep-CharPatternSize*2 | sta spritePatternOffset
                    jsr NextChar
                    ; middle-right
                    jsr MakeSource
                    lda #CharHeight | sta yCount2
                    do
                        jsr MixRight
                        dec yCount2
                    while ne | wend
                    jsr NextChar
                    lda spritePatternOffset | clc|adc #-VramStep*3/2 | sta spritePatternOffset
                    lda spriteLayerOffset | clc|adc #(VVramWidth-3)*2 | sta spriteLayerOffset
                    ; bottom-left
                    jsr MakeSource
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr MixLeft
                        dec yCount2
                    while ne | wend
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr CopyBackground
                        dec yCount2
                    while ne | wend
                    lda spritePatternOffset | clc|adc #VramStep/2-CharPatternSize | sta spritePatternOffset
                    jsr NextChar
                    ; bottom-center
                    jsr MakeSource
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr MixCenter
                        dec yCount2
                    while ne | wend
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr CopyBackground
                        dec yCount2
                    while ne | wend
                    lda spritePatternOffset | clc|adc #VramStep-CharPatternSize | sta spritePatternOffset
                    jsr NextChar
                    ; bottom-right
                    jsr MakeSource
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr MixRight
                        dec yCount2
                    while ne | wend
                    lda #CharHeight/2 | sta yCount2
                    do
                        jsr CopyBackground
                        dec yCount2
                    while ne | wend
                    jsr NextChar
                endif
            endif
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts
MakeSource:
    i8
    rep #$20 | a16
    
    ldy spriteLayerOffset
    lda (pSpriteLayer),y | sta pCharPattern
    lda pMixedPattern | sta (pSpriteLayer),y
    
    lda pCharPattern
    bit #$ff00
    if eq
        asl a | asl a | asl a | asl a | asl a ; *CharPatternSize
        clc|adc #CharPatternRam
        sta pCharPattern
    endif
    sep #$20 | a8
    stz charPatternOffset
rts
NextChar:
    rep #$20 | a16
    lda pMixedPattern | clc|adc #CharPatternSize | sta pMixedPattern
    sep #$20 | a8
    lda spriteLayerOffset | inc a | inc a | sta spriteLayerOffset
rts
MixByte:
    a8 | i8
    ldy charPatternOffset
    lda (pCharPattern),y
    sta charByte

    ldy spritePatternOffset
    lda (pSpritePattern),y
    iny | sty spritePatternOffset

    cmp #0
    if eq
        lda charByte
        bra MixByte_sta
    endif
    bit #$f0
    if ne
        bit #$0f
        bne MixByte_sta
        and #$f0
        sta sourceByte
        lda charByte
        and #$0f
        ora sourceByte
        bra MixByte_sta
    endif
    and #$0f
    sta sourceByte
    lda charByte
    and #$f0
    ora sourceByte
    MixByte_sta:
    ldy charPatternOffset
    sta (pMixedPattern),y
    iny | sty charPatternOffset
rts
CopyByte:
    a8 | i8
    ldy charPatternOffset
    lda (pCharPattern),y
    sta (pMixedPattern),y
    iny | sty charPatternOffset
rts
MixCenter:
    a8 | i8
    lda #VramStep | sta xCount2
    do
        jsr MixByte
        dec xCount2
    while ne | wend
    lda spritePatternOffset | clc|adc #VramStep | sta spritePatternOffset
rts
MixLeft:
    a8 | i8
    lda #VramStep/2 | sta xCount2
    do
        jsr CopyByte
        dec xCount2
    while ne | wend
    lda #VramStep/2 | sta xCount2
    do
        jsr MixByte
        dec xCount2
    while ne | wend
    lda spritePatternOffset | clc|adc #VramStep*3/2 | sta spritePatternOffset
rts
MixRight:
    a8 | i8
    lda #VramStep/2 | sta xCount2
    do
        jsr MixByte
        dec xCount2
    while ne | wend
    lda #VramStep/2 | sta xCount2
    do
        jsr CopyByte
        dec xCount2
    while ne | wend
    lda spritePatternOffset | clc|adc #VramStep*3/2 | sta spritePatternOffset
rts
CopyBackground:
    a8 | i8
    lda #VramStep | sta xCount2
    do
        jsr CopyByte
        dec xCount2
    while ne | wend
rts
endscope
