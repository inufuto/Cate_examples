include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_,LeftX_
ext @Temp@Word

ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

StageTop equ 4

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    sta <@Temp@Word+1
    clr <@Temp@Word
    lda #VVramWidth
    mul
    addd <@Temp@Word
    addd #VVram_
rts


zseg
xMod:
    defb 0
xLeft:
    defb 0
fCount:
    defb 0
cCount:
    defb 0
cellByte:
    defb 0
xPos:
    defb 0
yCount:
    defb 0
xCount:
    defb 0
cseg
CellChars:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor,Char_Floor
	; 2
	defb Char_Space,Char_Space
	defb Char_Item+0,Char_Item+1
	defb Char_Item+2,Char_Item+3
	defb Char_Floor,Char_Floor
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle,Char_Needle
	defb Char_Floor,Char_Floor


; void MapToVVram();
MapToVVram_: public MapToVVram_
    pshs a,b,x,y
        ldy #VVram_
        do
            clr ,y+
            cmpy #VVram_+VVramWidth*StageTop
        while ne | wend
        ldb LeftX_
        lsrb | lsrb | lsrb
        clra
        addd #CellMap_
        tfr d,x

        clrb
        lda LeftX_
        bita #1
        if ne
            leay -1,y
            decb
        endif
        stb <xLeft
        
        ldb #FloorCount | stb <fCount
        do
            lda <xLeft | sta <xPos
            lda LeftX_ | lsra | anda #3 | sta <xMod

            lda ,x+
            ldb <xMod
            do | while ne
                lsra | lsra
                decb
            wend
            sta <cellByte

            ldb #VVramWidth/2+1 | stb <cCount
            do
                lda <cellByte | anda #3
                ldb #8 | mul
                addd #CellChars
                pshs x
                    tfr d,x
                    ldb #4 | stb <yCount
                    do
                        ldb #2 | stb <xCount
                        do
                            lda ,x+
                            ldb <xPos
                            cmpb #VVramWidth
                            if cs
                                sta ,y
                            endif
                            leay 1,y
                            inc <xPos
                            dec <xCount
                        while ne | wend
                        leay VVramWidth-2,y
                        dec <xPos | dec <xPos
                        dec <yCount
                    while ne | wend
                    leay -VVramWidth*FloorHeight+2,y
                    inc <xPos | inc <xPos
                puls x
                lda <cellByte
                lsra | lsra
                sta <cellByte
                
                lda <xMod
                inca | anda #3
                sta <xMod
                if eq
                    lda ,x+ | sta <cellByte
                endif
                dec <cCount
            while ne | wend
            leay -VVramWidth-2+VVramWidth*FloorHeight,y
            
            lda <xMod
            if eq
                leax -1,x
            endif
            leax MapWidth-(VVramWidth/2+1)/ColumnsPerByte-1,x
            dec <fCount
        while ne | wend
    puls a,b,x,y
rts
