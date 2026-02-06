include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "VVram.inc"
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
defb $0,64, $f0 ; Ascii
defb $40,1, $70 ; Wall
defb $48,4, $f0 ; Knife
defb $50,88, $f0 ; Man
defb $A8,4, $d0 ; Chaser
defb $B0,4, $80 ; Disturber
defb $B8,4, $f0 ; Goal
defb $C0,4, $b0 ; Bang
defb $C8,4, $f0 ; M
defb $D0,4, $d0 ; A
defb $D8,4, $a0 ; Z
defb $E0,4, $80 ; Y
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


dseg
Put_@Param1: public Put_@Param1
Put_c:
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
WriteVram_@Param1: public WriteVram_@Param1
WriteVram_c:
FillVram_@Param1: public FillVram_@Param1
FillVram_b:
    defb 0


scope
wVram equ ZW1

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
endscope


scope
; void WriteVram(word vram, byte b);
cseg
WriteVram_: public WriteVram_
    sei
        sty VdpWritePort+1
        txa | ora #$40 | sta VdpWritePort+1
        lda WriteVram_c
        sta VdpWritePort
    cli
rts


; byte ReadVram(word vram);
cseg
ReadVram_: public ReadVram_
    sei
        sty VdpWritePort+1
        stx VdpWritePort+1
        jsr WaitVdp
        ldy VdpReadPort
    cli
rts
endscope


scope
wCount equ ZW2

; void FillVram(word vram, byte b, word count);
dseg
FillVram_@Param2: public FillVram_@Param2
FillVram_count:
    defw 0
cseg
FillVram_: public FillVram_
    pha
        lda FillVram_count | sta <wCount
        lda FillVram_count+1 | sta <wCount+1
        sei
            sty VdpWritePort+1
            txa | ora #$40 | sta VdpWritePort+1
            ldx FillVram_b
            do
                stx VdpWritePort
                jsr WaitVdp
                lda <wCount | sec | sbc #1 | sta <wCount
                lda <wCount+1 | sbc #0 | sta <wCount+1
                ora <wCount
            while ne | wend
        cli
    pla
rts
endscope

scope
; void VVramToVram();
wSource equ ZW0
wDestination equ ZW1
yCount equ ZB0
dseg
rowBuff:
    defs VVramWidth
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVram | sta <wSource
        lda #high VVram | sta <wSource+1

        lda #low Vram | sta <wDestination
        lda #high Vram or $40 | sta <wDestination+1

        lda #VVramHeight | sta <yCount
        do
            sei
                lda <wSource | sta VdpWritePort+1
                lda <wSource+1 | sta VdpWritePort+1
                ldx #0
                do
                    jsr WaitVdp
                    lda VdpReadPort
                    sta rowBuff,x | inx
                    cpx #VVramWidth
                while ne | wend
            cli
            lda <wSource | clc|adc #VVramWidth | sta <wSource
            lda <wSource+1 | adc #0 | sta <wSource+1

            sei
                lda <wDestination | sta VdpWritePort+1
                lda <wDestination+1 | sta VdpWritePort+1
                ldx #0
                do
                    lda rowBuff,x | inx
                    sta VdpWritePort
                    jsr WaitVdp
                    cpx #VVramWidth
                while ne | wend
            cli
            lda <wDestination | clc|adc #VramWidth | sta <wDestination
            lda <wDestination+1 | adc #0 | sta <wDestination+1

            dec <yCount
        while ne | wend
    pla
rts
endscope
