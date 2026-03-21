include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext CellMap_,LeftX_,DotOffset_
ext pNextPage_

StageTop equ StatusHeight+2

ColumnCount equ 16*8
ColumnWidth equ 2
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

scope
pCell equ @Temp@Word

; ptr<byte> CellMapPtr(byte column, byte floor);
dseg
CellMapPtr_@Param1: public CellMapPtr_@Param1
CellMapPtr_floor:
    defb 0
cseg
CellMapPtr_: public CellMapPtr_
    psha | pshb
        lsra | lsra
        staa <pCell+1
        ldab CellMapPtr_floor | clra
        aslb | rola ;*2
        aslb | rola ;*4
        aslb | rola ;*8
        aslb | rola ;*16
        aslb | rola ;*32
        addb <pCell+1 | adca #0
        addb #low CellMap_ | adca #high CellMap_
        stab <pCell+1 | staa <pCell
        ldx <pCell
    pulb | pula
rts
endscope

scope
pCharsBase equ @Temp@Word
pCell equ @Temp@Word2
pVram equ @Temp@Word3
pChars equ @Temp@Word4
columnMod equ @Temp@Byte
leftPos equ @Temp@Byte2
leftByte equ @Temp@Byte3
rightByte equ @Temp@Byte4
xPos equ @Temp@Byte5
shiftCount equ @Temp@Byte6

; void MapToVram();
cseg
MapToVram_: public MapToVram_
    psha | pshb
        ldaa DotOffset_
        anda #3
        clrb
        lsra | rorb
        addb #low CellChars | adca #high CellChars
        stab pCharsBase+1 | staa pCharsBase

        ldaa LeftX_
        lsra
        tab
        lsra | lsra
        adda #low CellMap_ | staa <pCell+1
        ldaa #high CellMap_ | adca #0 | staa <pCell

        andb #3
        stab columnMod

        ldaa pNextPage_ | ldab pNextPage_+1
        addb #low(VramRowSize*StageTop) | adca #high(VramRowSize*StageTop)
        stab pVram+1 | staa pVram
        ldx pVram
        clrb
        ldaa LeftX_
        anda #1
        if ne
            dex
            decb
        endif
        stx pVram
        stab leftPos

        ldab #FloorCount
        do
            pshb
                ldx pCell
                ldaa 0,x | inx | staa leftByte
                ldaa 0,x | inx | staa rightByte
                stx pCell

                ldab #ColumnsPerByte
                ldaa columnMod
                do | while ne
                    lsr rightByte | ror leftByte
                    lsr rightByte | ror leftByte
                    decb
                    deca
                wend
                stab shiftCount
                ldaa leftPos | staa xPos

                ldab #WindowWidth/2+1
                do
                    pshb
                        ldab leftByte
                        andb #$0f
                        clra
                        aslb | rola ;*2
                        aslb | rola ;*4
                        aslb | rola ;*8
                        addb pCharsBase+1 | adca pCharsBase
                        stab pChars+1 | staa pChars

                        ldab #FloorHeight
                        do
                            pshb
                                ldab #ColumnWidth
                                do
                                    ldaa xPos
                                    cmpa #WindowWidth
                                    if cs
                                        ldx pChars | ldaa 0,x | inx | stx pChars
                                        ldx pVram | staa 0,x | inx | stx pVram
                                    else
                                        ldx pChars | inx | stx pChars
                                        ldx pVram | inx | stx pVram
                                    endif
                                    inc xPos
                                    decb
                                while ne | wend
                                ldaa xPos | suba #ColumnWidth | staa xPos
                                ldaa pVram+1 | adda #low(VramRowSize-2) | staa pVram+1
                                ldaa pVram | adca #high(VramRowSize-2) | staa pVram
                            pulb
                            decb
                        while ne | wend
                        ldaa xPos | adda #ColumnWidth | staa xPos
                        ldaa pVram+1 | adda #low(-VramRowSize*FloorHeight+2) | staa pVram+1
                        ldaa pVram | adca #high(-VramRowSize*FloorHeight+2) | staa pVram

                        lsr rightByte | ror leftByte
                        lsr rightByte | ror leftByte
                        ldab shiftCount
                        decb
                        if eq
                            ldx pCell
                            ldaa 0,x | inx | staa rightByte
                            stx pCell
                            ldab #ColumnsPerByte
                        endif
                        stab shiftCount
                    pulb
                    decb
                while ne | wend
                ldaa pVram+1 | adda #low(-WindowWidth-2+VramRowSize*FloorHeight) | staa pVram+1
                ldaa pVram | adca #high(-WindowWidth-2+VramRowSize*FloorHeight) | staa pVram

                ldaa shiftCount
                cmpa #ColumnsPerByte
                if eq
                    ldx pCell | dex | stx pCell
                endif
                ldaa pCell+1 | adda #low(MapWidth-(WindowWidth/2+1)/ColumnsPerByte-2) | staa pCell+1
                ldaa pCell | adca #high(MapWidth-(WindowWidth/2+1)/ColumnsPerByte-2) | staa pCell
            pulb
            decb
        while ne | wend
    pulb | pula
rts
endscope

CellChars:
; shift0
; 0
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 1
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 2
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight0, Char_Item_TopRight_Space0
defb Char_Item_BottomLeft_Item_BottomRight0, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 3
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle0, Char_Needle_Needle0
defb Char_Floor_Floor0, Char_Floor_Floor0
; 4
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 5
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 6
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight0, Char_Item_TopRight_Space0
defb Char_Item_BottomLeft_Item_BottomRight0, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 7
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle0, Char_Needle_Needle0
defb Char_Floor_Floor0, Char_Floor_Floor0
; 8
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 9
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 10
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight0, Char_Item_TopRight_Space0
defb Char_Item_BottomLeft_Item_BottomRight0, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 11
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle0, Char_Needle_Needle0
defb Char_Floor_Floor0, Char_Floor_Floor0
; 12
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 13
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 14
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight0, Char_Item_TopRight_Space0
defb Char_Item_BottomLeft_Item_BottomRight0, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 15
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle0, Char_Needle_Needle0
defb Char_Floor_Floor0, Char_Floor_Floor0
; shift1
; 0
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 1
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Space1
; 2
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight1, Char_Item_TopRight_Space1
defb Char_Item_BottomLeft_Item_BottomRight1, Char_Space
defb Char_Floor_Floor0, Char_Floor_Space1
; 3
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle1, Char_Needle_Space1
defb Char_Floor_Floor0, Char_Floor_Space1
; 4
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Floor1
; 5
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 6
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight1, Char_Item_TopRight_Space1
defb Char_Item_BottomLeft_Item_BottomRight1, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 7
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle1, Char_Needle_Space1
defb Char_Floor_Floor0, Char_Floor_Floor0
; 8
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Floor1
; 9
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 10
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight1, Char_Item_TopRight_Space1
defb Char_Item_BottomLeft_Item_BottomRight1, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 11
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle1, Char_Needle_Space1
defb Char_Floor_Floor0, Char_Floor_Floor0
; 12
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Needle1
defb Char_Space, Char_Space_Floor1
; 13
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Needle1
defb Char_Floor_Floor0, Char_Floor_Floor0
; 14
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight1, Char_Item_TopRight_Space1
defb Char_Item_BottomLeft_Item_BottomRight1, Char_Space_Needle1
defb Char_Floor_Floor0, Char_Floor_Floor0
; 15
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle1, Char_Needle_Needle1
defb Char_Floor_Floor0, Char_Floor_Floor0
; shift2
; 0
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 1
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Space2
; 2
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight2, Char_Item_TopRight_Space2
defb Char_Item_BottomLeft_Item_BottomRight2, Char_Space
defb Char_Floor_Floor0, Char_Floor_Space2
; 3
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle2, Char_Needle_Space2
defb Char_Floor_Floor0, Char_Floor_Space2
; 4
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Floor2
; 5
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 6
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight2, Char_Item_TopRight_Space2
defb Char_Item_BottomLeft_Item_BottomRight2, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 7
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle2, Char_Needle_Space2
defb Char_Floor_Floor0, Char_Floor_Floor0
; 8
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Item_BottomLeft2
defb Char_Space, Char_Space_Floor2
; 9
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Item_BottomLeft2
defb Char_Floor_Floor0, Char_Floor_Floor0
; 10
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight2, Char_Item_TopRight_Space2
defb Char_Item_BottomLeft_Item_BottomRight2, Char_Space_Item_BottomLeft2
defb Char_Floor_Floor0, Char_Floor_Floor0
; 11
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle2, Char_Needle_Item_BottomLeft2
defb Char_Floor_Floor0, Char_Floor_Floor0
; 12
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Needle2
defb Char_Space, Char_Space_Floor2
; 13
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Needle2
defb Char_Floor_Floor0, Char_Floor_Floor0
; 14
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight2, Char_Item_TopRight_Space2
defb Char_Item_BottomLeft_Item_BottomRight2, Char_Space_Needle2
defb Char_Floor_Floor0, Char_Floor_Floor0
; 15
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle2, Char_Needle_Needle2
defb Char_Floor_Floor0, Char_Floor_Floor0
; shift3
; 0
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 1
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Space3
; 2
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight3, Char_Space
defb Char_Item_BottomLeft_Item_BottomRight3, Char_Space
defb Char_Floor_Floor0, Char_Floor_Space3
; 3
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle3, Char_Space
defb Char_Floor_Floor0, Char_Floor_Space3
; 4
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Floor3
; 5
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 6
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight3, Char_Space
defb Char_Item_BottomLeft_Item_BottomRight3, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 7
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle3, Char_Space
defb Char_Floor_Floor0, Char_Floor_Floor0
; 8
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Item_TopLeft3
defb Char_Space, Char_Space_Item_BottomLeft3
defb Char_Space, Char_Space_Floor3
; 9
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Item_TopLeft3
defb Char_Space, Char_Space_Item_BottomLeft3
defb Char_Floor_Floor0, Char_Floor_Floor0
; 10
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight3, Char_Space_Item_TopLeft3
defb Char_Item_BottomLeft_Item_BottomRight3, Char_Space_Item_BottomLeft3
defb Char_Floor_Floor0, Char_Floor_Floor0
; 11
defb Char_Space, Char_Space
defb Char_Space, Char_Space_Item_TopLeft3
defb Char_Needle_Needle3, Char_Space_Item_BottomLeft3
defb Char_Floor_Floor0, Char_Floor_Floor0
; 12
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Needle_Needle3
defb Char_Space, Char_Space_Floor3
; 13
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Space, Char_Needle_Needle3
defb Char_Floor_Floor0, Char_Floor_Floor0
; 14
defb Char_Space, Char_Space
defb Char_Item_TopLeft_Item_TopRight3, Char_Space
defb Char_Item_BottomLeft_Item_BottomRight3, Char_Needle_Needle3
defb Char_Floor_Floor0, Char_Floor_Floor0
; 15
defb Char_Space, Char_Space
defb Char_Space, Char_Space
defb Char_Needle_Needle3, Char_Needle_Needle3
defb Char_Floor_Floor0, Char_Floor_Floor0
