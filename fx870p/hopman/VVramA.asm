include "VVram.inc"
include "Vram.inc"

ext VVram_
ext CellMap_,LeftX_,DotOffset_

ColumnCount equ 12*8
FloorCount equ 3
FloorHeight equ 4
CellWidth equ 2
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

Char_Floor equ &ha0
Char_Needle equ &h70
Char_Item0 equ &h30
Char_Item1 equ &hf0
Char_Item2 equ &h30
Char_Item3 equ &h00


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
	defb Char_Item0,Char_Item1
	defb Char_Item2,Char_Item3
	defb Char_Floor,Char_Floor
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle,Char_Needle
	defb Char_Floor,Char_Floor

; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    phsm $7,8
    phs $8
    phsm $15,6
        pre iz,VVram_
        ld $0,VVramWidth*StageTop
        do
            sti $31,(iz+$sx)
            sb $0,$sy
        while nz | wend
        gre iz,$12 ; pVVram

        ld $2,$sx ; xPos
        pre ix,LeftX_ | ld $0,(ix+$sx)
        bid $0
        if c
            sbw $12,$sy
            sb $2,$sy
        endif
        ld $3,$0 | an $3,3 ; xMod

        ldw $14,CellMap_
        bid $0 | bid $0
        ld $1,$sx
        adw $14,$0 ; pCell

        ld $4,FloorCount ; fCount
        do
            phsw $3
            phsw $15
                ld $0,($14) | adw $14,$sy
                ld $1,$3 ; xMod
                ad $1,$sy
                do
                    sb $1,$sy
                while nz
                    bid $0 | bid $0
                wend
                ld $5,$0 ; cellByte

                ld $6,VVramWidth/2+1 ; cCount
                do
                                                                            _deb: public _deb
                    ld $0,$5 ; cellByte
                    an $0,3
                    biu $0 | biu $0 | biu $0
                    ld $1,$sx
                    ldw $10,CellChars | adw $10,$0
                    pre ix,$10
                    
                    ld $7,FloorHeight ; yCount
                    do
                        ld $8,2 ; xCount
                        do
                            ldi $0,(ix+$sx)
                            sbc $2,VVramWidth ; xPos
                            if c
                                st $0,($12)
                            endif
                            adw $12,$sy
                            ad $2,$sy ; xPos

                            sb $8,$sy ; xCount
                        while nz | wend
                        ldw $10,VVramWidth-2 | adw $12,$10
                        sb $2,2 ; xPos

                        sb $7,$sy ; yCount
                    while nz | wend
                    ldw $10,VVramWidth*FloorHeight-2 | sbw $12,$10
                    ad $2,2 ; xPos
                    bid $5 | bid $5 ; cellByte

                    ad $3,$sy | an $3,3 ; xMod
                    if z
                        ld $5,($14) ; cellByte
                        adw $14,$sy
                    endif
                    sb $6,$sy ; cCount
                while nz | wend
                ldw $10,VVramWidth*(FloorHeight-1)-2 | adw $12,$10
            ppsw $14
            ppsw $2
            ldw $10,MapWidth | adw $14,$10

            sb $4,$sy ; fCount
        while nz | wend
    ppsm $10,6
    pps $8
    ppsm $0,8
rtn


; MAPTOVVRAM_: public MAPTOVVRAM_
;     phsw $11
;         pre ix,VVram_
;         ldw $10,VVramWidth*VVramHeight
;         do
;             sti $31,(ix+$sx)
;             sbw $10,$sy
;         while nz | wend
;     ppsw $10
; rtn
