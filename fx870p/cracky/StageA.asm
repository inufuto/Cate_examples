include "VVram.inc"

ext VVram_
ext CellMap_

ColumnCount equ 12
FloorCount equ 4
ColumnsPerByte equ 2
FloorHeight equ 4
ColumnWidth equ 2

Cell_Space equ 0
Cell_LowerMask equ 3
Cell_CrackedFloor equ 1
Cell_HardFloor equ 3
Cell_LadderDown equ 2
Cell_UpperMask equ &h0c
Cell_BrokenFloor equ 4
Cell_LadderUp equ 8
Cell_Item equ &h0c

Char_Space equ 0
Char_ItemLT equ &h60
Char_ItemRT equ &h90
Char_ItemLB equ &h90
Char_ItemRB equ &h60
Char_HoleL equ &h80
Char_HoleR equ &h00
Char_HardFloor equ &hf0
Char_LadderL equ &he0
Char_LadderR equ &hb0
Char_CrackL equ &he0
Char_CrackR equ &h70


; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    phsw $13
        ld $10,$1
        biu $10 ;*2
        ad $10,$1 ;*3
        biu $10 ;*6
        ld $11,$sx
        ld $12,$0
        bid $12
        ld $13,$sx
        adw $10,$12
        ldw $12,CellMap_
        adw $10,$12
    ppsw $12
rtn


; void MapToVVram();
cseg
MapToVVram_Row:
    stw $10,($12)
    ldw $14,VVramWidth | adw $12,$14
rtn
MapToVVram_Rows:
    do
        cal MapToVVram_Row
        sb $5,$sy
    while nz | wend
rtn
MapToVVram_: public MapToVVram_
    phsm $5,6
    phsm $15,6
        pre ix,CellMap_
        ldw $12,VVram_
        ld $1,FloorCount
        do
            ld $2,ColumnCount/ColumnsPerByte
            do
                ldi $0,(ix+$sx)
                ld $3,ColumnsPerByte
                do
                    ld $4,$0 | an $4,Cell_UpperMask ; upper
                    sbc $4,Cell_BrokenFloor
                    if z
                        ldw $10,Char_Space or (Char_Space shl 8)
                        ld $5,3
                        cal MapToVVram_Rows
                        ldw $10,Char_HoleL or (Char_HoleR shl 8)
                        cal MapToVVram_Row
                        jr nextColumn
                    endif
                    sbc $4,Cell_Item
                    if z
                        ldw $10,Char_Space or (Char_Space shl 8)
                        cal MapToVVram_Row
                        ldw $10,Char_ItemLT or (Char_ItemRT shl 8)
                        cal MapToVVram_Row
                        ldw $10,Char_ItemLB or (Char_ItemRB shl 8)
                        cal MapToVVram_Row
                        ldw $10,Char_HardFloor or (Char_HardFloor shl 8)
                        cal MapToVVram_Row
                        jp nextColumn                        
                    endif
                    sbc $4,Cell_LadderUp
                    if z
                        ldw $10,Char_LadderL or (Char_LadderR shl 8)
                        ld $5,3
                        cal MapToVVram_Rows
                        ld $4,$0 | an $4,Cell_LowerMask ; lower
                        sbc $4,Cell_LadderDown
                        if nz
                            ldw $10,Char_HardFloor or (Char_HardFloor shl 8)
                        endif
                        cal MapToVVram_Row
                        jp nextColumn
                    endif
                    ldw $10,Char_Space or (Char_Space shl 8)
                    ld $5,2
                    cal MapToVVram_Rows

                    ld $4,$0 | an $4,Cell_LowerMask ; lower
                    sbc $4,Cell_LadderDown
                    if z
                        ldw $10,Char_LadderL or (Char_LadderR shl 8)
                        ld $5,2
                        cal MapToVVram_Rows
                        jp nextColumn
                    endif
                    ldw $10,Char_Space or (Char_Space shl 8)
                    cal MapToVVram_Row

                    sbc $4,Cell_CrackedFloor
                    if z
                        ldw $10,Char_CrackL or (Char_CrackR shl 8)
                    else
                        sbc $4,Cell_HardFloor
                        if z
                            ldw $10,Char_HardFloor or (Char_HardFloor shl 8)
                        endif
                    endif
                    cal MapToVVram_Row

                    nextColumn:
                    ldw $14,-VVramWidth*FloorHeight+2
                    adw $12,$14

                    bid $0 | bid $0 | bid $0 | bid $0

                    sb $3,$sy
                while nz | wend
                sb $2,$sy
            while nz | wend
            ldw $14,VVramWidth*(FloorHeight-1)
            adw $12,$14

            sb $1,$sy
        while nz | wend
    ppsm $10,6
    ppsm $0,6
rtn
