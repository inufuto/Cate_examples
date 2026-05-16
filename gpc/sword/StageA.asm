include "Vram.inc"
include "Chars.inc"
include "VVram.inc"

ext StageMap_
ext VVram_

ColumnCount equ 12
RowCount equ 7


cseg
MapPtr:
    mov b,a
    clc|rar
    clc|rar
    ; ani a,$0f
    mov d,a
    mov a,e
    add a,a       ;*2
    add a,e       ;*3
    add a,d
    adi a,low StageMap_ | mov l,a
    mvi a,high StageMap_ | aci a,0 | mov h,a
    mov a,b
ret

; void SetCell(byte column, byte row, byte cell);
cseg
SetCell_: public SetCell_
    push v | push h | push d | push b
        call MapPtr
        mvi e,$03
        ani a,3
        if sknz
            mov b,a
            dcr b
            do
                mov a,c
                clc|ral
                clc|ral
                mov c,a
                mov a,e
                clc|ral
                clc|ral
                mov e,a
                dcr b
            repeat
        endif
        mov a,e | xri a,$ff | mov e,a
        ldax h
        ana a,e
        ora a,c
        stax h
    pop b | pop d | pop h | pop v
ret

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push h | push d | push b
        call MapPtr
        mov b,a
        ldax h | mov e,a
        mov a,b
        ani a,3
        if sknz
            mov b,a
            dcr b
            do
                mov a,e
                clc|rar
                clc|rar
                mov e,a
                dcr b
            repeat
        endif
        mov a,e
        ani a,$03
    pop b | pop d | pop h
ret


; void DrawStage();
cseg
DrawStage_: public DrawStage_
    push v | push h | push d | push b
        lxi d,StageMap_
        lxi h,VVram_
        mvi c,RowCount-1
        do
            mvi b,ColumnCount/4-1
            do
                push b
                    ldax d | inx d
                    push d
                        mvi c,4-1
                        do
                            push v
                                ani a,3
                                if sknz
                                    dcr a
                                    add a,a | add a,a
                                    adi a,Char_Wall
                                    mvi b,2-1
                                    do
                                        stax h | inx h
                                        inr a
                                        stax h
                                        inr a
                                        call NextY
                                        dcr b
                                    repeat
                                else
                                    mvi a,Char_Space
                                    mvi b,2-1
                                    do
                                        stax h | inx h
                                        stax h
                                        call NextY
                                        dcr b
                                    repeat
                                endif
                                mov a,l | adi a,low(2-VVramWidth*2) | mov l,a
                                mov a,h | aci a,high(2-VVramWidth*2) | mov h,a
                            pop v
                            clc|rar
                            clc|rar
                            dcr c
                        repeat
                    pop d
                pop b
                dcr b
            repeat
                                        _deb: public _deb
            mov a,l | adi a,low(VVramWidth) | mov l,a
            mov a,h | aci a,high(VVramWidth) | mov h,a
            dcr c
        repeat
    pop b | pop d | pop h | pop v
ret
NextY:
    mov e,a
        mov a,l | adi a,low(VVramWidth-1) | mov l,a
        mov a,h | aci a,high(VVramWidth-1) | mov h,a
    mov a,e
ret
