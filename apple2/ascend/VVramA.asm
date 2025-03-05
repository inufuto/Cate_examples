include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext pStage_, StageMap_, topRow_, yMod_
ext VVram_


VisibleFloorCount equ (WindowHeight+FloorHeight-1)/FloorHeight+1
WindowHeight equ VVramHeight
FloorHeight equ 4
ColumnCount equ 16
MapWidth equ ColumnCount/4

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3


; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param0: public	VVramPtr_@Param0
VVramPtr_.x_:	defs 1
VVramPtr_@Param1: public	VVramPtr_@Param1
VVramPtr_.y_:	defs 1
cseg
VVramPtr_: public	VVramPtr_
	pha
        lda	VVramPtr_.y_
        asl a | asl a | asl a  ;*8
        sta <ZW0 | lda #0 | sta <ZW0+1
        asl <ZW0 | rol <ZW0+1 ;16
        asl <ZW0 | rol <ZW0+1 ;32
        lda VVramPtr_.x_ | clc | adc <ZW0 | sta <ZW0
        lda <ZW0+1 | adc #0 | sta <ZW0+1
        lda <ZW0 | clc|adc #low VVram_ | tay
        lda <ZW0+1 | adc #high VVram_ | tax
	pla
rts


; MapToBackGround();
height equ ZB1
row equ ZB2
ypos equ ZB3
fcount equ ZB4
byteCount equ ZB5
bitCount equ ZB6
left equ ZW0
right equ ZW0+1
pMap equ ZW1
pVVram equ ZW2

zseg
bits:
    defb 0
lower:
    defb 0

cseg
Repeat:
    pha
        do
            lda <ypos
            cmp #VVramHeight
            if cc
                ldy #0 | lda <left | sta (pVVram),y
                iny | lda <right | sta (pVVram),y
            endif
            lda <pVVram | clc|adc #VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            inc <ypos
            dex
        while ne | wend
    pla
rts

MapToBackGround_: public MapToBackGround_
    pha
        lda pStage_ | sta <ZW0
        lda pStage_+1 | sta <ZW0+1
        ldy #0
        lda (<ZW0),y
        sta <height

        lda topRow_ | sta <row
        if pl
            asl a ;*2
            asl a ;*4
            clc|adc #low StageMap_ | sta <pMap
            lda #high StageMap_ | adc #0 | sta <pMap+1
        else
            lda #low(StageMap_-4) | sta <pMap
            lda #high(StageMap_-4) | sta <pMap+1
        endif

        lda yMod_
        if ne
            eor #$ff
            clc|adc #1
        endif
        sta <ypos
        tax
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        do
            cpx #0
        while ne
            lda <pVVram | sec|sbc #VVramWidth | sta <pVVram
            lda <pVVram+1 | sbc #0 | sta <pVVram+1
            inx
        wend
        lda #VisibleFloorCount | sta <fcount
        do
            lda #MapWidth | sta <byteCount
            do
                ldx <row
                if pl
                    inx
                    cpx <height
                    if cc
                        ldy #MapWidth
                        lda (<pMap),y
                    else
                        lda #0
                    endif
                    sta <lower
                    ldy #0
                    lda (<pMap),y
                    sta <bits
                else
                    lda #0
                    sta <bits
                    ldy #MapWidth
                    lda (<pMap),y
                    sta <lower
                endif
                lda <pMap | clc|adc #1 | sta <pMap
                lda <pMap+1 | adc #0 | sta <pMap+1

                lda #4 | sta <bitCount
                do
                    lda <bits
                    and #3
                    if eq
                        lda #Char_Space | sta <left | sta <right
                        ldx #1
                        jsr Repeat

                        lda <lower
                        and #3
                        cmp #CellType_Ladder
                        if eq
                            lda #Char_Ladder_Left | sta <left
                            lda #Char_Ladder_Right | sta <right
                            ldx #3
                            jsr Repeat
                        else
                            ldx #2
                            jsr Repeat

                            cmp #CellType_Wall
                            if eq
                                lda #Char_Wall | sta <left
                                lda #Char_Floor | sta <right
                            else
                                lda #Char_Floor | sta <left | sta <right
                            endif
                            ldx #1
                            jsr Repeat
                        endif
                    else
                        cmp #CellType_Ladder
                        if eq
                            lda #Char_Ladder_Left | sta <left
                            lda #Char_Ladder_Right | sta <right
                            ldx #3
                            jsr Repeat

                            lda <lower
                            and #3
                            cmp #CellType_Ladder
                            if eq
                                lda #Char_Ladder_Left | sta <left
                                lda #Char_Ladder_Right | sta <right
                            else
                                cmp #CellType_Wall
                                if eq
                                    lda #Char_Wall | sta <left
                                    lda #Char_Floor | sta <right
                                else
                                    lda #Char_Floor | sta <left | sta <right
                                endif
                            endif
                            ldx #1
                            jsr Repeat
                        else
                            cmp #CellType_Wall
                            if eq
                                lda #Char_Wall | sta <left
                                lda #Char_Space | sta <right
                                ldx #3
                                jsr Repeat
                                
                                lda <lower
                                and #3
                                cmp #CellType_Wall
                                if eq
                                    lda #Char_Wall | sta <left
                                    lda #Char_Floor | sta <right
                                else
                                    lda #Char_Floor | sta <left | sta <right
                                endif
                                ldx #1
                                jsr Repeat
                            else
                                lda #Char_Space | sta <left | sta <right
                                ldx #4
                                jsr Repeat
                            endif
                        endif
                    endif
                    lda <pVVram | clc|adc #low (-VVramWidth*4+2) | sta <pVVram
                    lda <pVVram+1 | adc #high (-VVramWidth*4+2) | sta <pVVram+1
                    lsr <bits | lsr <bits
                    lsr <lower | lsr <lower
                    lda <ypos
                    sec|sbc #FloorHeight
                    sta <ypos
                    dec <bitCount
                while ne | wend
                dec <byteCount
            while ne | wend
            lda <pVVram | clc|adc #low (VVramWidth*(4-1)) | sta <pVVram
            lda <pVVram+1 | adc #high (VVramWidth*(4-1)) | sta <pVVram+1
            inc <row
            lda <ypos
            clc|adc #FloorHeight
            sta <ypos
            dec <fcount
        while ne | wend
    pla
rts
