include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"

ext CharPattern

pSource equ ZW0
wVram equ ZW1
count equ ZB0
VramH equ ZB1
shift equ ZB1
charByte equ ZB2

cseg
ColorSource:
defb 64, $f0 ; Ascii
defb 16, $70 ; Logo
defb 1, $f0 ; Knife
defb 8, $e0 ; Stair
defb 4, $b0 ; Goal
defb 4, $f0 ; Remain
defb 0
cseg
InitVram: public InitVram
    sei
        lda #0 | sta <VramH
        do
            lda #low Vram_PatternGenerator | sta VdpWritePort+1
            lda #$40 or high Vram_PatternGenerator | ora <VramH | sta VdpWritePort+1
            lda #low CharPattern | sta <pSource
            lda #high CharPattern | sta <pSource+1
            ldx #Char_End
            do
                ldy #0
                do
                    lda (<pSource),y | iny
                    sta VdpWritePort
                    jsr WaitVdp
                    cpy #8
                while ne | wend
                lda <pSource | clc|adc #8 | sta <pSource
                lda <pSource+1 | adc #0 | sta <pSource+1
                dex
            while ne | wend

            lda #low Vram_Color | sta VdpWritePort+1
            lda #$40 or high Vram_Color | ora <VramH | sta VdpWritePort+1
            ldx #0
            do
                lda ColorSource,x
            while ne
                sta <count
                inx
                lda ColorSource,x | inx
                do
                    ldy #8
                    do
                        sta VdpWritePort
                        jsr WaitVdp
                        dey
                    while ne | wend
                    dec <count
                while ne | wend
            wend
            
            lda <VramH | clc|adc #8 | sta <VramH
            cmp #8*3
        while ne | wend
    cli
WaitVdp: public WaitVdp
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        sei
            lda #low Vram_PatternName | sta VdpWritePort+1
            lda #$40 or high Vram_PatternName | sta VdpWritePort+1
            lda #Char_Space
            ldy #VramHeight
            do
                ldx #VramWidth
                do
                    sta VdpWritePort
                    jsr WaitVdp
                    dex
                while ne | wend
                dey
            while ne | wend
        cli
    pla
rts


; ptr<byte> VramAddress(byte x, byte y)
dseg
VramAddress_@Param1: public	VramAddress_@Param1
VramAddress_y:
    defb 0
cseg
VramAddress_: public VramAddress_
    pha
        sty <wVram
        lda #0 | sta <wVram+1
        lda	VramAddress_y
        asl	a ; *2
        asl	a ; *4
        asl	a | rol <wVram+1 ; *8
        asl	a | rol <wVram+1 ; *16
        asl	a | rol <wVram+1 ; *32

        clc|adc <wVram | tay
        lda <wVram+1 | adc #0 | tax

        tya clc|adc #low Vram | tay
        txa adc #high Vram | tax
	pla
rts


; ptr<byte> Put(word vram, byte c);
dseg
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Put_c:
    defb 0
cseg
Put:
    tax
    sei
        lda <wVram | sta VdpWritePort+1
        lda <wVram+1 | ora #$40 | sta VdpWritePort+1
        stx VdpWritePort
    cli
    jsr WaitVdp
    sei
        lda <wVram | sta VdpWritePort+1
        lda <wVram+1 | ora #$44 | sta VdpWritePort+1
        stx VdpWritePort
    cli
rts
Put_: public Put_
    pha
        sty <wVram | stx <wVram+1
        lda Put_c
        jsr Put
        lda <wVram | clc|adc #1 | tay
        lda <wVram+1 | adc #0 | tax
    pla
rts


; word PrintC(word vram, byte c);
PrintC_: public PrintC_
    pha
        sty <wVram | stx <wVram+1
        lda Put_c
        sec|sbc #$20
        jsr Put
        lda <wVram | clc|adc #1 | tay
        lda <wVram+1 | adc #0 | tax
    pla
rts
