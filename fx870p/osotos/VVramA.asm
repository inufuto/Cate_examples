include "VVram.inc"
include "Vram.inc"

ext VVram_
ext CellMap_


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public	VVramPtr_
    phsw $13
        ld $10,$1
        biu $10 ;*2
        ad $10,$1 ;*3
        ld $11,$sx
        biuw $10 ;*6
        biuw $10 ;*12
        biuw $10 ;*24
        ld $12,$0
        ld $13,$sx
        adw $10,$12
        ldw $12,VVram_
        adw $10,$12
    ppsw $12
rtn


ColumnCount equ 12
FloorCount equ 4
FloorHeight equ 4

Cell_Down equ 1
Cell_Up equ 2
Cell_Block equ 8
Cell_Ceiling equ 4
Cell_Item equ 4

Char_Floor equ &ha0 
Char_LadderL equ &he0
Char_LadderR equ &hb0
Char_Space equ &h00

; void DrawBackground();
cseg
FloorChars:
    defb Char_Floor, Char_Floor, Char_Space, Char_Space
LadderChars:
    defb Char_LadderL, Char_LadderR, Char_LadderL, Char_LadderR
BlockChars:
    defb &he0, &hb0, &hd0, &h70
ItemChars:
    defb &h60, &h90, &h90, &h60

DrawBackground_: public DrawBackground_
    phsm $7,8
    phsm $17,8
        ldw $10,CellMap_
        ldw $12,VVram_-VVramWidth*TopMargin
        ld $4,-TopMargin ;yPos
        ld $5,VVramHeight
        ld $3,FloorCount
        do
            ld $2,ColumnCount
            do
                ld $1,($10) | adw $10,$sy
                sbc $4,$5
                if c
                    ld $0,Cell_Block | anc $1,$0
                    if nz
                        ldw $14,BlockChars
                        cal VPut2S
                        jr lower
                    endif
                    ld $0,Cell_Ceiling | anc $1,$0
                    if nz
                        ldw $14,FloorChars
                        cal VPut2S
                        jr lower
                    endif
                    ld $0,Cell_Down or Cell_Up | anc $1,$0
                    if nz
                        ldw $14,LadderChars
                        cal VPut2S
                        jr lower
                    endif
                    cal VErase2
                else
                    ldw $16,VVramWidth*2 | adw $12,$16
                endif
                lower:
                bid $1 | bid $1 | bid $1 | bid $1

                ld $0,Cell_Block | anc $1,$0
                if nz
                    ldw $14,BlockChars
                    cal VPut2S
                    jr next
                endif
                ld $0,Cell_Item | anc $1,$0
                if nz
                    ldw $14,ItemChars
                    cal VPut2S
                    jr next
                endif
                ld $0,Cell_Down or Cell_Up | anc $1,$0
                if nz
                    ldw $14,LadderChars
                    cal VPut2S
                    jr next
                endif
                cal VErase2

                next:
                                                _deb: public _deb
                ldw $16,2-VVramWidth*4 | adw $12,$16

                sb $2,$sy
            while nz | wend
            ldw $16,VVramWidth*(4-1) | adw $12,$16

            ld $0,4 | ad $4,$0

            sb $3,$sy
        while nz | wend

        ld $0,Char_Floor
        ld $6,VVramWidth
        do
            st $0,($12) | adw $12,$sy
            sb $6,$sy
        while nz | wend

        ldw $12,VVram_
        ld $0,Char_Space
        ld $6,VVramWidth
        do
            st $0,($12) | adw $12,$sy
            sb $6,$sy
        while nz | wend
    ppsm $10,8
    ppsm $0,8
rtn
VPut2S:
    ld $7,2
    do
        ld $6,2
        do
            ld $0,($14) | adw $14,$sy
            st $0,($12) | adw $12,$sy
            sb $6,$sy
        while nz | wend
        ldw $16,VVramWidth-2 | adw $12,$16
        sb $7,$sy
    while nz | wend
rtn
VErase2:
    ld $0,$sx
    ld $7,2
    do
        ld $6,2
        do
            st $0,($12) | adw $12,$sy
            sb $6,$sy
        while nz | wend
        ldw $16,VVramWidth-2 | adw $12,$16
        sb $7,$sy
    while nz | wend
rtn
