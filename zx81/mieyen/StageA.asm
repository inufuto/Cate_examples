include "Vram.inc"

ext CellMap_
ext pCurrentPage_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push psw | push b
        rrc | ani 7
        mov c,a | mvi b,0
        
        mov a,e
        add a ;*2
        add a ;*4
        add e ;*5
        mov l,a | mvi h,0
        
        dad b
        lxi b,CellMap_
        dad b
    pop b | pop psw
ret


Cell_RightWall equ $01
Cell_BottomWall equ $02
Cell_Dot equ $04
Cell_Food equ $08
ColumnCount equ 10
RowCount equ 7
ColumnWidth equ 3
RowHeight equ 3

Char_Space equ $00
Char_Wall equ $08

; void DrawBackground();
cseg
DotChars:
    defb $87, 0, 0, 0
FoodChars:
    defb $81, $82, $83, $83
DrawBackground_: public DrawBackground_
    push psw | push h | push d | push b
        lhld pCurrentPage_
        lxi d,VramRowSize*2
        dad d
        mvi a,Char_Wall
        mvi b,ColumnWidth*ColumnCount+1
        do
            mov m,a | inx h
            dcr b
        while nz | wend
        inx h | inx h

        lxi d,CellMap_
        mvi c,RowCount
        do
            push d
                lxi d,VramRowSize
                mvi a,Char_Wall
                mvi b,RowHeight
                do
                    mov m,a
                    dad d
                    dcr b
                while nz | wend
                lxi d,1-VramRowSize*RowHeight
                dad d
            pop d
            
            mvi b,ColumnCount/2
            do
                push b
                    ldax d | inx d
                    push d
                        mvi c,2
                        do
                            mov b,a
                            push b
                                mov c,a
                                                    _deb: public _deb
                                ani $0c
                                cpi Cell_Food
                                if z
                                    lxi d,FoodChars
                                    jmp put2s
                                endif
                                cpi Cell_Dot
                                if z
                                    lxi d,DotChars
                                    put2s:
                                    push b
                                        mvi c,2
                                        do
                                            mvi b,2
                                            do
                                                ldax d | inx d
                                                mov m,a | inx h
                                                inr a
                                                dcr b
                                            while nz | wend
                                            push d
                                                lxi d,VramRowSize-2
                                                dad d
                                            pop d
                                            dcr c
                                        while nz | wend
                                    pop b
                                    jmp nextCell
                                endif
                                lxi d,VramRowSize-2
                                mvi a,Char_Space
                                push b
                                    mvi c,2
                                    do
                                        mvi b,2
                                        do
                                            mov m,a | inx h
                                            dcr b
                                        while nz | wend
                                        dad d
                                        dcr c
                                    while nz | wend
                                pop b
                                nextCell:
                                lxi d,2-VramRowSize*2
                                dad d

                                mov a,c
                                ani Cell_RightWall
                                if nz
                                    mvi a,Char_Wall
                                else
                                    mvi a,Char_Space
                                endif
                                lxi d,VramRowSize
                                mvi b,2
                                do
                                    mov m,a
                                    dad d
                                    dcr b
                                while nz | wend
                                dcx h | dcx h

                                mov a,c
                                ani Cell_BottomWall
                                if nz
                                    mvi a,Char_Wall
                                else
                                    mvi a,Char_Space
                                endif
                                mvi b,2
                                do
                                    mov m,a | inx h
                                    dcr b
                                while nz | wend
                                mvi m,Char_Wall

                                lxi d,1-VramRowSize*2
                                dad d
                            pop b
                            mov a,b
                            rrc | rrc | rrc | rrc
                            dcr c
                        while nz | wend
                    pop d
                pop b
                dcr b
            while nz | wend
            push d
                lxi d,VramRowSize*2+2
                dad d
            pop d
            dcr c
        while nz | wend
    pop b | pop d | pop h | pop psw
ret
