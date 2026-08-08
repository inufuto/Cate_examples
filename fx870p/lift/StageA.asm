include "VVram.inc"

ext CellMap_
ext VVram_

Cell_Type_Floor equ &h08
Cell_Type_LiftBottom equ &h18

FloorCount equ 3
ColumnCount equ 12
StageTop equ 2

Char_Space equ &h00
Char_Roof_Left equ &h10
Char_Roof_Right equ &h40
Char_Roof_Center equ &hf0
Char_LiftBottom equ &hf0
Char_Floor equ &ha0


; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public CellMapPtr_
    phsw $13
        ld $10,$1
        sb $10,StageTop
        bid $10 | bid $10
        ld $12,$10
        biu $10 ;*2
        ad $10,$12 ;*3
        ld $11,$sx
        biuw $10 ;*6
        biuw $10 ;*12
        ld $12,$0
        bid $12
        ld $13,$sx
        adw $10,$12
        ldw $12,CellMap_
        adw $10,$12
    ppsw $12
rtn


; void DrawBackGround();
cseg
DrawBackGround_: public DrawBackGround_
    phsm $3,4
    phsm $13,4
        pre iz,VVram_
        ld $0,Char_Roof_Left
        sti $0,(iz+$sx)
        ldw $0,Char_Roof_Center or ((VVramWidth-2)shl 8)
        do
            sti $0,(iz+$sx)
            sb $1,$sy
        while nz | wend
        ld $0,Char_Roof_Right
        sti $0,(iz+$sx)

        ldw $0,Char_Roof_Center or (VVramWidth shl 8)
        do
            sti $0,(iz+$sx)
            sb $1,$sy
        while nz | wend
        gre iz,$10

        pre ix,CellMap_
        ld $2,FloorCount
        do
            ld $3,ColumnCount
            do
                ldi $0,(ix+$sx)
                an $0,Cell_Type_LiftBottom
                sbc $0,Cell_Type_LiftBottom
                if z
                    ld $1,Char_LiftBottom
                else
                    anc $0,Cell_Type_Floor
                    if nz
                        ld $1,Char_Floor
                    else
                        ld $1,Char_Space
                    endif
                endif
                ld $0,$sx
                pre iz,$10
                st $0,(iz+$sx)
                st $0,(iz+$sy)
                st $0,(iz+VVramWidth)
                st $0,(iz+VVramWidth+1)
                st $0,(iz+VVramWidth*2)
                st $0,(iz+VVramWidth*2+1)
                st $1,(iz+VVramWidth*3)
                st $1,(iz+VVramWidth*3+1)
                ldw $12,2 | adw $10,$12
                sb $3,$sy
            while nz | wend
            ldw $12,VVramWidth*3 | adw $10,$12
            sb $2,$sy
        while nz | wend
    ppsm $10,4
    ppsm $0,4
rtn