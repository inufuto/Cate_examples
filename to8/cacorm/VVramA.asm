include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_
ext LineRed_

MapWidth equ VVramWidth/2
MapHeight equ VVramHeight/2

Cell_Wall equ 10h
Cell_Item equ 20h
Cell_Mask equ 0f0h

zseg 
Dp.Word0:
    defw 0

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    sta <Dp.Word0+1
    clr <Dp.Word0
    lda #VVramWidth
    mul
    addd <Dp.Word0
    addd #VVram_
rts


; void MapToVVram();
cseg
LineChars:
    defb Char_Space, Char_Space, Char_Space, Char_Space ; none
    defb Char_Line_Bottom, Char_Space, Char_Line_Top, Char_Space ; left
    defb Char_Space, Char_Line_Bottom, Char_Space, Char_Line_Top ; right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_Top, Char_Line_Top ; left right
    defb Char_Line_Right, Char_Line_Left, Char_Space, Char_Space ; top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_Top, Char_Space ; top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Space, Char_Line_Top ; top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_Top, Char_Line_Top ; top left right
    defb Char_Space, Char_Space, Char_Line_Right, Char_Line_Left ; bottom
    defb Char_Line_Bottom, Char_Space, Char_Line_RightTop, Char_Line_Left ; bottom left
    defb Char_Space, Char_Line_Bottom, Char_Line_Right, Char_Line_LeftTop ; bottom right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom left right
    defb Char_Line_Right, Char_Line_Left, Char_Line_Right, Char_Line_Left ; bottom top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_RightTop, Char_Line_Left ; bottom top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Line_Right, Char_Line_LeftTop ; bottom top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom top left right

MapToVVram_: public MapToVVram_
    pshs a,b,x,y
        ldy #VVram_
        ldx #CellMap_
        ldb #MapHeight
        do
            pshs b
                ldb #MapWidth
                do
                    pshs b
                        lda ,x+
                        cmpa #Cell_Wall
                        if eq
                            lda #Char_Block
                            bra byChar
                        endif
                        cmpa #Cell_Item
                        if eq
                            lda #Char_Item
                            byChar:
                            ldb #2
                            do
                                pshs b
                                    ldb #2
                                    do
                                        sta ,y+
                                        inca
                                        decb
                                    while ne | wend
                                    leay VVramWidth-2,y
                                puls b
                                decb
                            while ne | wend
                            bra nextCell
                        endif
                        anda #$0f
                        lsla | lsla
                        pshs x
                            ldx #LineChars
                            leax a,x
                            ldb #2
                            do
                                pshs b
                                    ldb #2
                                    do
                                        lda ,x+
                                        if ne
                                            tst LineRed_
                                            if ne
                                                adda #Char_Line_Red-Char_Line_Normal
                                            endif
                                        endif
                                        sta ,y+
                                        decb
                                    while ne | wend
                                    leay VVramWidth-2,y
                                puls b
                                decb
                            while ne | wend
                        puls x
                        nextCell:
                        leay 2-VVramWidth*2,y
                    puls b
                    decb
                while ne | wend
                leay VVramWidth,y
            puls b
            decb
        while ne | wend
    puls a,b,x,y
rts
