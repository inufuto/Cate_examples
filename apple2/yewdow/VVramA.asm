include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext CellMap_
ext VVram_

MapWidth equ 16
MapHeight equ 11
MapWidthPerByte equ 8/4

Cell_Wall equ 1h
Cell_Rock equ 2h
Cell_Arrow equ 4h
Cell_NullArrow equ 0ch

pVVram equ ZW0
yCount equ ZB0
byteCount equ ZB1
bitCount equ ZB2
cell equ ZB3
char equ ZB4
yCount2 equ ZB5
xCount2 equ ZB6

; ptr<byte> VVramPtr(byte x, byte y)
dseg
VVramPtr_@Param0: public VVramPtr_@Param0
VVramPtr_x:
	defs 1
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defs 1
cseg
VVramPtr_: public VVramPtr_
	pha
        lda	VVramPtr_y
        asl a | asl a | asl a  ;*8
        sta <pVVram | lda #0 | sta <pVVram+1
        asl <pVVram | rol <pVVram+1 ;16
        asl <pVVram | rol <pVVram+1 ;32
        lda VVramPtr_x | clc|adc <pVVram | sta <pVVram
        lda <pVVram+1 | adc #0 | sta <pVVram+1
        lda <pVVram | clc|adc #low VVram_ | tay
        lda <pVVram+1 | adc #high VVram_ | tax
	pla
rts


; void MapToVVram();
MapToVVram_: public MapToVVram_
    pha
        ldx #0
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        lda #MapHeight | sta <yCount
        do
            ldy #0
            lda #MapWidth/MapWidthPerByte | sta <byteCount
            do
                lda CellMap_,x | inx | sta <cell
                lda #MapWidthPerByte | sta <bitCount
                do
                    lda <cell
                    and #$0f
                    cmp #Cell_Wall
                    if eq
                        lda #Char_Wall
                        jmp vput2
                    endif
                    cmp #Cell_Rock
                    if eq
                        lda #Char_Rock
                        jmp vput2
                    endif
                    and #$0c
                    ; cmp #Cell_NullArrow
                    ; if eq
                    ;     lda #Char_Arrow_Null
                    ;     jmp vput2
                    ; endif
                    cmp #Cell_Arrow
                    if eq
                        lda <cell
                        asl a | asl a
                        and #$0c
                        clc|adc #Char_Arrow
                        vput2:
                        sta <char
                        lda #2 | sta <yCount2
                        do
                            lda #2 | sta <xCount2
                            do
                                lda <char
                                sta (pVVram),y
                                iny
                                inc <char
                                dec <xCount2
                            while ne | wend
                            tya
                            clc|adc #VVramWidth-2
                            tay
                            dec <yCount2
                        while ne | wend
                        jmp next
                    endif
                    lda #2 | sta <yCount2
                    do
                        lda #2 | sta <xCount2
                        do
                            lda #Char_Space
                            sta (pVVram),y
                            iny
                            dec <xCount2
                        while ne | wend
                        tya
                        clc|adc #VVramWidth-2
                        tay
                        dec <yCount2
                    while ne | wend
                    next:
                    clc|adc #-VVramWidth*2+2
                    tay

                    lda <cell
                    lsr a | lsr a | lsr a | lsr a
                    sta <cell

                    dec <bitCount
                while ne | wend
                dec <byteCount
            while ne | wend
            lda <pVVram | clc|adc #low(VVramWidth*2) | sta <pVVram
            lda <pVVram+1 | adc #high(VVramWidth*2) | sta <pVVram+1

            dec <yCount
        while ne | wend
    pla
rts