include "VVram.inc"
include "Chars.inc"

ext pStage_, StageMap_, topRow_, yMod_
ext VVram_
ext DrawBlocks_

VisibleFloorCount equ (WindowHeight+FloorHeight-1)/FloorHeight+1
WindowHeight equ VVramHeight
FloorHeight equ 4
ColumnCount equ 16
MapWidth equ ColumnCount/4

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3

zseg 
tempWord:
    defw 0

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    sta <tempWord+1
    clr <tempWord
    lda #VVramWidth
    mul
    addd <tempWord
    addd #VVram_
rts


; MapToVVram();
zseg
height:
    defb 0
row:
    defb 0
ypos:
    defb 0
pMap:
    defw 0
fcount:
    defb 0
byteCount:
    defb 0
bitCount:
    defb 0
bits:
    defb 0
lower:
    defb 0
pair:
    defw 0
cseg
Repeat:
    pshs a
        do
            lda <ypos
            cmpa #VVramHeight
            if cs
                lda <pair | sta ,y
                lda <pair+1 | sta 1,y
            endif
            leay VVramWidth,y
            inc <ypos
            decb
        while ne | wend
    puls a
rts

MapToVVram_: public MapToVVram_
    pshs a,b,x,y
        lda [pStage_]
        sta <height

        lda topRow_ | sta <row
        if pl
            lsla ;*2
            lsla ;*4
            ldx #StageMap_
            leax a,x
        else
            ldx #StageMap_-4
        endif
        stx <pMap

        lda yMod_
        if ne
            nega
        endif
        sta <ypos
        ldy #VVram_
        do
            tsta
        while mi
            leay -VVramWidth,y
            inca
        wend

        lda #VisibleFloorCount | sta <fcount
        do
            lda #MapWidth | sta <byteCount
            do
                ldx <pMap
                ldb <row
                if pl
                    lda ,x
                    incb
                    cmpb <height
                    if cs
                        ldb MapWidth,x
                    else
                        clrb
                    endif
                else
                    clra
                    ldb MapWidth,x
                endif
                sta <bits
                stb <lower
                leax 1,x
                stx <pMap

                lda #4 | sta <bitCount
                do
                    lda <bits
                    anda #3
                    if eq
                        ldd #((Char_Space shl 8) or Char_Space)
                        std <pair
                        ldb #1
                        bsr Repeat

                        lda <lower
                        anda #3
                        cmpa #CellType_Ladder
                        if eq
                            ldd #((Char_Ladder_Left shl 8) or Char_Ladder_Right)
                            std <pair
                            ldb #3
                            bsr Repeat
                        else
                            ldb #2
                            bsr Repeat

                            cmpa #CellType_Wall
                            if eq
                                ldd #((Char_Wall shl 8) or Char_Floor)
                            else
                                ldd #((Char_Floor shl 8) or Char_Floor)
                            endif
                            std <pair
                            ldb #1
                            bsr Repeat
                        endif
                    else
                        cmpa #CellType_Ladder
                        if eq
                            ldd #((Char_Ladder_Left shl 8) or Char_Ladder_Right)
                            std <pair
                            ldb #3
                            bsr Repeat

                            lda <lower
                            anda #3
                            cmpa #CellType_Ladder
                            if eq
                                ldd #((Char_Ladder_Left shl 8) or Char_Ladder_Right)
                            else
                                cmpa #CellType_Wall
                                if eq
                                    ldd #((Char_Wall shl 8) or Char_Floor)
                                else
                                    ldd #((Char_Floor shl 8) or Char_Floor)
                                endif
                            endif
                            std <pair
                            ldb #1
                            bsr Repeat
                        else
                            cmpa #CellType_Wall
                            if eq
                                ldd #((Char_Wall shl 8) or Char_Space)
                                std <pair
                                ldb #3
                                bsr Repeat
                                
                                lda <lower
                                anda #3
                                cmpa #CellType_Wall
                                if eq
                                    ldd #((Char_Wall shl 8) or Char_Floor)
                                else
                                    ldd #((Char_Floor shl 8) or Char_Floor)
                                endif
                                std <pair
                                ldb #1
                                bsr Repeat
                            else
                                ldd #((Char_Space shl 8) or Char_Space)
                                std <pair
                                ldb #4
                                bsr Repeat
                            endif
                        endif
                    endif
                    leay -VVramWidth*4+2,y
                    lsr <bits | lsr <bits
                    lsr <lower | lsr <lower
                    lda <ypos
                    suba #FloorHeight
                    sta <ypos
                    dec <bitCount
                while ne | wend
                dec <byteCount
            while ne | wend
            leay VVramWidth*(4-1),y
            inc <row
            lda <ypos
            adda #FloorHeight
            sta <ypos
            dec <fcount
        while ne | wend
    puls a,b,x,y
    jsr DrawBlocks_
rts
