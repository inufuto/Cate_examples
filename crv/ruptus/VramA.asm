include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"

ext CharPattern

scope
pSource equ ZW0
cCode equ ZB0
charCount equ ZB1
colorCount equ ZB2
color equ ZB3
vramH equ ZB4

cseg
ColorSource:
defb $0,28, $f0 ; Ascii
defb $20,16, $70 ; Logo
defb $30,16, $f0 ; Star
defb $40,4, $a0 ; Barrier
defb $48,2, $74 ; Map
defb $50,4, $f0 ; Remain
defb $58,144, $70 ; Fort
defb $ff
cseg
InitVram: public InitVram
    sei
        lda #low CharPattern | sta pSource
        lda #high CharPattern | sta pSource+1

        ldx #0
        do
            lda ColorSource,x
            cmp #$ff
        while ne
            inx | sta cCode
            lda ColorSource,x | inx | sta charCount
            
            clc|adc #8-1
            lsr a | lsr a | lsr a
            sta colorCount

            lda ColorSource,x | inx | sta color
            
            lda #0 | sta vramH
            lda cCode
            asl a | rol vramH ;*2
            asl a | rol vramH ;*4
            asl a | rol vramH ;*8
            sta VdpWritePort+1
            lda vramH | ora #$40 | sta VdpWritePort+1
            do
                ldy #0
                do
                    lda (pSource),y | iny
                    sta VdpWritePort
                    jsr WaitVdp
                    cpy #CharHeight
                while ne | wend
                lda pSource | clc|adc #CharHeight | sta pSource
                if cs
                    inc pSource+1
                endif
                dec charCount
            while ne | wend

            lda cCode
            lsr a | lsr a | lsr a
            sta VdpWritePort+1
            lda #high Vram_Color or $40 | sta VdpWritePort+1
            lda color
            ldy colorCount
            do
                sta VdpWritePort
                jsr WaitVdp
                dey
            while ne | wend
        wend
    cli
WaitVdp: public WaitVdp
rts
endscope


scope
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
endscope


scope
wVram equ ZW1

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
endscope


scope
wVram equ ZW1

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

; ptr<byte> Put(word vram, byte c);
cseg
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
CharTable:
    defb " -0123456789ABCEGHIMNOPRSTUV"
PrintC_: public PrintC_
    pha
        sty <wVram | stx <wVram+1
        lda Put_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_exit
            inx
            cpx #28
        while ne | wend
        PrintC_exit:
        txa
        jsr Put
        lda <wVram | clc|adc #1 | tay
        lda <wVram+1 | adc #0 | tax
    pla
rts
endscope
