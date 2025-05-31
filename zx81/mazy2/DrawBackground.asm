include "Vram.inc"

ext CellMap_
ext pCurrentPage_

ColumnCount equ 10
RowCount equ 7
CellSize equ 3
RightWall equ $01
BottomWall equ $02
LeftWall equ $10
TopWall equ $20
Cell_TypeMask equ $0c

Char_Space equ $00
Char_Wall equ $08

; void DrawBackground();
cseg
Chars:
    defb 0,0,0,0
    defb	$80, $84, $82, $81, $00, $87, $87, $80
	defb	$80, $84, $80, $81
WallA:
    ora a
    if p
        mvi a,Char_Space
    else
        mvi a,Char_Wall
    endif
ret
LeftEnd:
    ldax d
    call WallA
    lxi d,VramRowSize
    mvi b,CellSize
    do
        mov m,a
        dad d
        dcr b
    while nz | wend
ret
DrawBackground_: public DrawBackground_
    push psw | push h | push d | push b
        lhld pCurrentPage_
        lxi d,VramRowSize*2
        dad d
        lxi b,((1+CellSize*ColumnCount) shl 8) or Char_Space
        do
            mov m,c | inx h
            dcr b
        while nz | wend
        lxi d,-(1+CellSize*ColumnCount) | dad d

        lxi d,CellMap_
        mvi c,RowCount
        do
            push d
                lxi d,VramRowSize
                mvi b,1+CellSize
                do
                    mvi m,Char_Space
                    dad d
                    dcr b
                while nz | wend
                lxi d,-VramRowSize*(CellSize+1) | dad d
            pop d
            mvi b,ColumnCount
            do
                push b
                    ldax d | inx d
                    push d
                        ora a
                        if m
                            mvi m,Char_Wall | inx h
                            mov b,a
                                ani TopWall
                                if nz
                                    mvi c,Char_Wall
                                else
                                    mvi c,Char_Space
                                endif
                            mov a,b
                            mvi b,CellSize-1
                            do
                                mov m,c | inx h
                                dcr b
                            while nz | wend
                            mvi m,Char_Wall
                            lxi d,VramRowSize-CellSize | dad d
                            mov b,a
                                ani LeftWall
                                if nz
                                    mvi c,Char_Wall
                                else
                                    mvi c,Char_Space
                                endif
                            mov a,b
                            lxi d,VramRowSize
                            mvi b,CellSize-1
                            do
                                mov m,c
                                dad d
                                dcr b
                            while nz | wend
                            lxi d,1-VramRowSize*(CellSize-1) | dad d
                            push psw
                                ani Cell_TypeMask
                                adi low Chars | mov e,a
                                mvi a,high Chars | aci 0 | mov d,a
                                mvi b,CellSize-1
                                do
                                    ldax d | inx d
                                    mov m,a | inx h
                                    ldax d | inx d
                                    mov m,a
                                    push d
                                        lxi d,VramRowSize-1 | dad d
                                    pop d
                                    dcr b
                                while nz | wend
                                lxi d,CellSize-1-VramRowSize*(CellSize-1) | dad d
                            pop psw
                            mov b,a
                                ani RightWall
                                if nz
                                    mvi c,Char_Wall
                                else
                                    mvi c,Char_Space
                                endif
                            mov a,b
                            lxi d,VramRowSize
                            mvi b,CellSize-1
                            do
                                mov m,c
                                dad d
                                dcr b
                            while nz | wend
                            lxi d,-CellSize | dad d
                            mvi m,Char_Wall | inx h
                            mov b,a
                                ani BottomWall
                                if nz
                                    mvi c,Char_Wall
                                else
                                    mvi c,Char_Space
                                endif
                            mov a,b
                            mvi b,CellSize-1
                            do
                                mov m,c | inx h
                                dcr b
                            while nz | wend
                            mvi m,Char_Wall
                            lxi d,-VramRowSize*CellSize | dad d
                        else
                                            _deb: public _deb
                            lxi d,VramRowSize+1 | dad d
                            lxi d,VramRowSize-CellSize
                            mvi c,CellSize
                            do
                                mvi b,CellSize
                                do
                                    mvi m,Char_Space | inx h
                                    dcr b
                                while nz | wend
                                dad d
                                dcr c
                            while nz | wend
                            lxi d,CellSize-1-VramRowSize*(CellSize+1) | dad d
                        endif
                    pop d
                pop b
                dcr b
            while nz | wend
            push d
                lxi d,VramRowSize*CellSize-(CellSize*ColumnCount) | dad d
            pop d
            dcr c
        while nz | wend
    pop b | pop d | pop h | pop psw
ret
