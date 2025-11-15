include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern ;,ColorPattern
ext DisplayPage

dseg
NextPage: public NextPage
    defb 0
TerrainCharOffset: public TerrainCharOffset
    defw 0


scope
pSource equ ZW0
wVram equ ZW1
colorByte equ ZB0
charByte equ ZB1
count equ ZB2
cseg
PaletteValues:
defb	$00, $00, $07, $00, $38, $00, $3f, $00
defb	$c0, $01, $c7, $01, $f8, $01, $ff, $01
defb	$00, $00, $05, $00, $28, $00, $80, $00
defb	$40, $01, $47, $01, $78, $01, $6d, $01
ColorSource:
defb 29, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
    ldx #0
    ldy #0
    do
        sty $0403
        phy
            ldy #0
            do
                sty $0402
                lda PaletteValues,x | inx
                sta $0404
                lda PaletteValues,x | inx
                sta $0405
                iny
            while ne | wend
        ply
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
            phy
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
            ply
            dey
        while ne | wend
    wend

    ; lda #low ColorPattern | sta <pSource
    ; lda #high ColorPattern | sta <pSource+1
    ; ldx #Char_End-Char_Color
    ; do
    ;     ldy #0
    ;     do
    ;         defb $03,$02 ; st0
    ;         lda (<pSource),y | iny
    ;         sta >$0002
    ;         lda (<pSource),y | iny
    ;         sta >$0003
    ;         cpy #CharHeight*PlaneCount
    ;     while ne | wend
    ;     lda <pSource | clc|adc #CharHeight*PlaneCount | sta <pSource
    ;     lda <pSource+1 | adc #0 | sta <pSource+1
    ;     dex
    ; while ne | wend
rts
endscope


scope
; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        sei
            defb $03,$00 ; st0 Memory Address Write
            defb $13,$00 ; st1
            defb $23,$00 ; st2
            ldx #$10
            do
                ldy #0
                do
                    defb $03,$02 ; st0 Vram Data
                    defb $13,$00 ; st1
                    defb $23,$01 ; st2
                    dey
                while ne | wend
                dex
            while ne | wend
        cli

        lda #high(Vram1) | sta NextPage
        lda #TerrainCharCount | sta TerrainCharOffset
        stz DisplayPage
    pla
rts
endscope


cseg
WriteXYA:
    sei
        defb $03,$00 ; st0 Memory Address Write
        sty >$0002
        stx >$0003
        defb $03,$02 ; st0 Vram Data
        sta >$0002
        defb $23,$01 ; st2
    cli
rts

scope
wVram equ ZW0
; ptr<byte> Put(word vram, byte c);
dseg
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    pha
        lda Put_c
        jsr WriteXYA
        txa | ora #$04 | tax
        lda Put_c
        jsr WriteXYA
        iny
        if eq
            inx
        endif
        txa | and #not $04 | tax
    pla
rts

; word PrintC(word vram, byte c);
PrintC_: public PrintC_
    pha
        sty <wVram | stx <wVram+1
        ldy Put_c | jsr FromAscii_
        sty Put_c
        ldy <wVram | ldx <wVram+1
        jsr Put_
    pla
rts
endscope


; byte FromAscii(byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
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


ext Status_

scope
wVram equ ZW0
offset equ ZB0
char equ ZB1
; void StatusToVram();
StatusToVram_: public StatusToVram_
cseg
    pha
        lda #low(Vram0) | sta wVram
        lda #high(Vram0) | sta wVram+1
        stz offset
        do
            ldx offset | lda Status_,x
            inx | stx offset
            cmp #0
            if ne
                sta char
                ldy <wVram | ldx <wVram+1
                jsr WriteXYA
                txa | ora #$04 | tax
                lda char
                jsr WriteXYA
            endif
            inc wVram
            lda offset
            cmp #VramWidth*2
        while ne | wend
    pla
rts
endscope


scope
; void SwitchVram();
SwitchVram_: public SwitchVram_
    pha
        lda NextPage
        if eq
            lda #high(Vram1) | sta NextPage
            lda #TerrainCharCount | sta TerrainCharOffset
            stz DisplayPage
        else
            lda #high(Vram0) | sta NextPage
            stz TerrainCharOffset
            lda #1 | sta DisplayPage
        endif
    pla
rts
endscope
