include "VVram.inc"

ext VVram_
ext pStage_, StageMap_, topRow_, yMod_

FloorHeight equ 4
ColumnCount equ 12
VisibleFloorCount equ (VVramHeight+FloorHeight-1)/FloorHeight+1
MapWidth equ ColumnCount/4

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3

Char_Space equ &h00
Char_Wall equ &hf0
Char_Floor equ &ha0
Char_Ladder_Left equ &he0
Char_Ladder_Right equ &hb0


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


; MapToBackGround();
cseg
Repeat:
    do
        sbc $3,VVramHeight
        if c
            stw $14,($12)
        endif
        ldw $10,VVramWidth | adw $12,$10  ; pVVram
        ad $3,$sy
        sb $9,$sy
    while nz | wend
rtn
MapToBackGround_: public MapToBackGround_
    phsm $7,8
    phsw $9
    phsm $15,6
        pre ix,pStage_
        ldw $10,(ix+$sx)
        ld $1,($10) ; height
        pre ix,topRow_ | ld $2,(ix+$sx) ; row
        anc $2,&h80
        if z
            ld $10,$2
            biu $10
            ad $10,$2
            ld $11,$sx
            ldw $12,StageMap_
            adw $10,$12
            pre iz,$10 ; pMap
        else
            pre iz,StageMap_-MapWidth ; pMap
        endif

        pre ix,yMod_ | ld $3,(ix+$sx)
        cmp $3 ; ypos
        ldw $12,VVram_ ; pVVram
        ldw $10,VVramWidth
        do
            anc $3,&h80
        while nz
            sbw $12,$10
            ad $3,$sy ; ypos
        wend

        ld $4,VisibleFloorCount ; fcount
        do
            ld $5,MapWidth ; byteCount
            do
                anc $2,&h80 ; row
                if z
                    ld $6,(iz+$sx) ; bits
                    ld $0,$2 ; row
                    ad $0,$sy
                    sbc $0,$1 ; height
                    if c
                        ld $7,(iz+MapWidth) ; lower
                    else
                        ld $7,$sx ; lower
                    endif
                else
                    ld $6,$sx ; bits
                    ld $7,(iz+MapWidth) ; lower
                endif
                ldi $0,(iz+$sx)

                ld $8,4 ; bitCount
                do
                    ld $0,$6 ; bits
                    an $0,3
                    if z
                        ldw $14,Char_Space or (Char_Space shl 8) ; pair
                        ld $9,1
                        cal Repeat

                        ld $0,$7 ; lower
                        an $0,3
                        sbc $0,CellType_Ladder
                        if z
                            ldw $14,Char_Ladder_Left or (Char_Ladder_Right shl 8) ; pair
                            ld $9,3
                            cal Repeat
                        else
                            ld $9,2
                            cal Repeat

                            sbc $0,CellType_Wall
                            if z
                                ldw $14,Char_Wall or (Char_Floor shl 8)
                            else
                                ldw $14,Char_Floor or (Char_Floor shl 8)
                            endif
                            ld $9,1
                            cal Repeat
                        endif
                    else
                        sbc $0,CellType_Ladder
                        if z
                            ldw $14,Char_Ladder_Left or (Char_Ladder_Right shl 8)
                            ld $9,3
                            cal Repeat

                            ld $0,$7 ; lower
                            an $0,3
                            sbc $0,CellType_Ladder
                            if z
                                ldw $14,Char_Ladder_Left or (Char_Ladder_Right shl 8)
                            else
                                sbc $0,CellType_Wall
                                if z
                                    ldw $14,Char_Wall or (Char_Floor shl 8)
                                else
                                    ldw $14,Char_Floor or (Char_Floor shl 8)
                                endif
                            endif
                            ld $9,1
                            cal Repeat
                        else
                            sbc $0,CellType_Wall
                            if z
                                ldw $14,Char_Wall or (Char_Space shl 8)
                                ld $9,3
                                cal Repeat

                                ld $0,$7 ; lower
                                an $0,3
                                sbc $0,CellType_Wall
                                if z
                                    ldw $14,Char_Wall or (Char_Floor shl 8)
                                else
                                    ldw $14,Char_Floor or (Char_Floor shl 8)
                                endif
                                ld $9,1
                                cal Repeat
                            else
                                ldw $14,Char_Space or (Char_Space shl 8)
                                ld $9,4
                                cal Repeat
                            endif
                        endif
                    endif
                    ldw $10,VVramWidth*4-2 | sbw $12,$10
                    bid $6 | bid $6 ; bits
                    bid $7 | bid $7 ; lower
                    sb $3,FloorHeight ; ypos

                    sb $8,$sy ; bitCount
                while nz | wend
                sb $5,$sy ; byteCount
            while nz | wend
                                                        _deb:public _deb
            ldw $10,VVramWidth*(4-1) | adw $12,$10
            ad $2,$sy ; row
            ad $3,FloorHeight ; ypos

            sb $4,$sy ; fcount
        while nz | wend
    ppsm $10,6
    ppsw $8
    ppsm $0,8
rtn