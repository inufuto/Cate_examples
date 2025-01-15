include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern,ColorPattern

VramTop equ Vram+VramRowSize*2

pSource equ ZW0
wVram equ ZW1

colorByte equ ZB0
charByte equ ZB1
count equ ZB2


dseg
CharOffset: public CharOffset
    defb 0

cseg
PaletteValues:
	defb	$00, $00, $07, $00, $38, $00, $7f, $01
	defb	$78, $01, $ff, $01, $f8, $01, $c7, $01
	defb	$47, $01, $38, $00, $f8, $01, $12, $00
	defb	$c0, $01, $00, $00, $ba, $00, $7d, $01
ColorSource:
defb 64, 5 ; Ascii
defb 16, 8 ; Logo
defb 16, 1 ; Wall
defb 4, 6 ; Dot
defb 0
InitVram: public InitVram
    ldx #0
    ldy #0
    do
        sty $0403
        defb $5a ; phy
            ldy #0
            do
                sty $0402
                lda PaletteValues,x | inx
                sta $0404
                lda PaletteValues,x | inx
                sta $0405
                iny
            while ne | wend
        defb $7a ; ply
        iny
        cpy #2
    while ne | wend
    
    defb $03,$00 ; st0
    defb $13,low CharPatternRam ; st1
    defb $23,high CharPatternRam ; st2

    lda #low MonoPattern | sta <pSource
    lda #high MonoPattern | sta <pSource+1
    ldx #0
    do
        lda ColorSource,x
    while ne
        tay | inx
        lda ColorSource,x | inx
        sta <colorByte
        do
            defb $5a ; phy
                ldy #0
                do
                    defb $03,$02 ; st0
                    lda <colorByte
                    and #$01
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    sta <charByte
                    lda <colorByte
                    and #$10
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    ora <charByte
                    sta >$0002
                    lda <colorByte
                    and #$02
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    sta <charByte
                    lda <colorByte
                    and #$20
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    ora <charByte
                    sta >$0003
                    iny
                    cpy #8
                while ne | wend
                ldy #0
                do
                    defb $03,$02 ; st0
                    lda <colorByte
                    and #$04
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    sta <charByte
                    lda <colorByte
                    and #$40
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    ora <charByte
                    sta >$0002
                    lda <colorByte
                    and #$08
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    sta <charByte
                    lda <colorByte
                    and #$80
                    if ne
                        lda (<pSource),y
                    else
                        lda #0
                    endif
                    ora <charByte
                    sta >$0003
                    iny
                    cpy #CharHeight
                while ne | wend
                lda <pSource | clc|adc #CharHeight | sta <pSource
                lda <pSource+1 | adc #0 | sta <pSource+1
            defb $7a ; ply
            dey
        while ne | wend
    wend

    lda #low ColorPattern | sta <pSource
    lda #high ColorPattern | sta <pSource+1
    ldx #Char_End-Char_Color
    do
        ldy #0
        do
            defb $03,$02 ; st0
            lda (<pSource),y | iny
            sta >$0002
            lda (<pSource),y | iny
            sta >$0003
            cpy #CharHeight*PlaneCount
        while ne | wend
        lda <pSource | clc|adc #CharHeight*PlaneCount | sta <pSource
        lda <pSource+1 | adc #0 | sta <pSource+1
        dex
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        sei
            defb $03,$00 ; st0
            defb $13,$00 ; st1
            defb $23,$00 ; st2
            ldx #10
            do
                ldy #0
                do
                    defb $03,$02 ; st0
                    defb $13,$00 ; st1
                    defb $23,$01 ; st2
                    dey
                while ne | wend
                dex
            while ne | wend
        cli

        stz CharOffset
    pla
rts


; ptr<byte> VramAddress(byte x, byte y)
dseg
VramAddress_@Param1: public	VramAddress_@Param1
    defs 1
cseg
VramAddress_: public VramAddress_
    pha
        stz <wVram+1
        lda	VramAddress_@Param1
        asl	a ; *2
        asl	a ; *4
        asl	a | rol <wVram+1 ; *8
        asl	a | rol <wVram+1 ; *16
        asl	a | rol <wVram+1 ; *32
        sta <wVram

        tya | clc|adc wVram | tay
        lda <wVram+1 | adc #0 | tax
	pla
rts


; word Put(word vram, byte c);
dseg
Put_@Param1: public Put_@Param1
    defb 0
cseg
Put_: public Put_
    pha
        sty <wVram | stx <wVram+1
        sei
            defb $03,$00 ; st0
            lda <wVram | sta >$0002
            lda <wVram+1 | sta >$0003
            defb $03,$02 ; st0
            lda Put_@Param1 | sta >$0002
            defb $23,$01 ; st2
        cli
        lda <wVram | clc|adc #1 | tay
        lda <wVram+1 | adc #0 | tax
    pla
rts


; byte ReadVram(word vram);
ReadVram_: public ReadVram_
    pha
        sty <wVram | stx <wVram+1
        sei
            defb $03,$01 ; st0
            lda wVram | sta >$0002
            lda wVram+1 | sta >$0003
            defb $03,$02 ; st0
            ldy >$0002
            lda >$0003
        cli
    pla
rts
