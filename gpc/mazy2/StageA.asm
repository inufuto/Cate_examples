include "VVram.inc"
include "Chars.inc"

ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push v | push b
        mov c,a
        mov a,e
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        add a,c
        adi a,low CellMap_ | mov l,a
        mvi a,0 | aci a,high CellMap_ | mov h,a
    pop b | pop v
ret


ext VVram_
ext xCount,yCount

ColumnCount equ 8
RowCount equ 5
CellSize equ 3
Cell_RightWall equ $01
Cell_BottomWall equ $02
Cell_LeftWall equ $10
Cell_TopWall equ $20
Cell_Visible equ $80
Cell_TypeMask equ $0c

; void MapToVVram();
cseg
Chars:
    defb Char_Space, Char_Space, Char_Space, Char_Space
    defb  Char_StairUp, Char_StairUp + 1, Char_StairUp + 2, Char_StairUp + 3
    defb  Char_StairDown, Char_StairDown + 1, Char_StairDown + 2, Char_StairDown + 3
    defb  Char_Goal, Char_Goal + 1, Char_Goal + 2, Char_Goal + 3
MapToVVram_: public MapToVVram_
    push v | push h | push d | push b
        lxi h,VVram_
        mvi a,Char_Space
        mvi b,1+CellSize*ColumnCount-1
        do
            stax h | inx h
            dcr b
        repeat
        mov a,l | adi a,low(-(1+CellSize*ColumnCount)) | mov l,a
        mov a,h | aci a,high(-(1+CellSize*ColumnCount)) | mov h,a

        lxi d,CellMap_
        mvi a,RowCount-1 | staw yCount
        do
            push d
                mvi b,1+CellSize-1
                do
                    mvi a,Char_Space | stax h
                    mov a,l | adi a,low VVramWidth | mov l,a
                    mov a,h | aci a,high VVramWidth | mov h,a
                    dcr b
                repeat
                mov a,l | adi a,low(-VVramWidth*(CellSize+1)) | mov l,a
                mov a,h | aci a,high(-VVramWidth*(CellSize+1)) | mov h,a
            pop d
            mvi a,ColumnCount-1 | staw xCount
            do
                push b
                    ldax d | inx d
                    push d
                        mov e,a
                        if oni a,Cell_Visible
                            mvi a,Char_Wall_C
                            stax h | inx h
                            
                            mov a,e
                            if oni a,Cell_TopWall
                                mvi a,Char_Wall_H
                            else
                                mvi a,Char_Space
                            endif
                            mvi b,CellSize-1-1
                            do
                                stax h | inx h
                                dcr b
                            repeat
                            
                            mvi a,Char_Wall_C
                            stax h
                            mov a,l | adi a,low(VVramWidth-CellSize) | mov l,a
                            mov a,h | aci a,high(VVramWidth-CellSize) | mov h,a
                            
                            mov a,e
                            if oni a,Cell_LeftWall
                                mvi c,Char_Wall_V
                            else
                                mvi c,Char_Space
                            endif
                            mvi b,CellSize-1-1
                            do
                                mov a,c
                                stax h
                                mov a,l | adi a,low VVramWidth | mov l,a
                                mov a,h | aci a,high VVramWidth | mov h,a
                                dcr b
                            repeat
                            mov a,l | adi a,low(1-VVramWidth*(CellSize-1)) | mov l,a
                            mov a,h | aci a,high(1-VVramWidth*(CellSize-1)) | mov h,a
                            push d
                                mov a,e
                                ani a,Cell_TypeMask
                                adi a,low Chars | mov e,a
                                mvi a,high Chars | aci a,0 | mov d,a
                                mvi b,CellSize-1-1
                                do
                                    ldax d | inx d
                                    stax h | inx h
                                    ldax d | inx d
                                    stax h
                                    mov a,l | adi a,low(VVramWidth-1) | mov l,a
                                    mov a,h | aci a,high(VVramWidth-1) | mov h,a
                                    dcr b
                                repeat
                                mov a,l | adi a,low(CellSize-1-VVramWidth*(CellSize-1)) | mov l,a
                                mov a,h | aci a,high(CellSize-1-VVramWidth*(CellSize-1)) | mov h,a
                            pop d
                            mov a,e
                            if oni a,Cell_RightWall
                                mvi c,Char_Wall_V
                            else
                                mvi c,Char_Space
                            endif
                            mvi b,CellSize-1-1
                            do
                                mov a,c
                                stax h
                                mov a,l | adi a,low VVramWidth | mov l,a
                                mov a,h | aci a,high VVramWidth | mov h,a
                                dcr b
                            repeat
                            mov a,l | adi a,low(-CellSize) | mov l,a
                            mov a,h | aci a,high(-CellSize) | mov h,a
                            
                            mvi a,Char_Wall_C
                            stax h |inx h

                            mov a,e
                            if oni a,Cell_BottomWall
                                mvi a,Char_Wall_H
                            else
                                mvi a,Char_Space
                            endif
                            mvi b,CellSize-1-1
                            do
                                stax h | inx h
                                dcr b
                            repeat

                            mvi a,Char_Wall_C
                            stax h

                            mov a,l | adi a,low(-VVramWidth*CellSize) | mov l,a
                            mov a,h | aci a,high(-VVramWidth*CellSize) | mov h,a
                        else
                            mov a,l | adi a,low(VVramWidth+1) | mov l,a
                            mov a,h | aci a,high(VVramWidth+1) | mov h,a
                            mvi c,CellSize-1
                            do
                                mvi b,CellSize-1
                                do
                                    mvi a,Char_Space
                                    stax h | inx h
                                    dcr b
                                repeat
                                mov a,l | adi a,low(VVramWidth-CellSize) | mov l,a
                                mov a,h | aci a,high(VVramWidth-CellSize) | mov h,a
                                dcr c
                            repeat
                            mov a,l | adi a,low(CellSize-1-VVramWidth*(CellSize+1)) | mov l,a
                            mov a,h | aci a,high(CellSize-1-VVramWidth*(CellSize+1)) | mov h,a
                        endif
                    pop d
                pop b
                dcrw xCount
            repeat
            mov a,l | adi a,low(VVramWidth*CellSize-(CellSize*ColumnCount)) | mov l,a
            mov a,h | aci a,high(VVramWidth*CellSize-(CellSize*ColumnCount)) | mov h,a
            dcrw yCount
        repeat
    pop b | pop d | pop h | pop v
ret
