include "Vram.inc"

ext StageMap_

ColumnCount equ 16
RowCount equ 11

cseg
MapPtr:
    mov b,a
    rrc | rrc | ani 0fh 
    mov d,a
    mov a,e
    add a       ;*2
    add a       ;*4
    add d
    adi low StageMap_ | mov l,a
    mvi a,high StageMap_ | aci 0 | mov h,a
    mov a,b
ret

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push psw | push h | push d | push b
        call MapPtr
        mvi e,0fch
        ani 3
        if nz
            mov b,a
            do
                mov a,c
                rlc | rlc
                mov c,a
                mov a,e
                rlc | rlc
                mov e,a
                dcr b
            while nz | wend
        endif
        mov a,m
        ana e
        ora c
        mov m,a
    pop b | pop d | pop h | pop psw
ret

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push h | push d | push b
        call MapPtr
        mov e,m
        ani 3
        if nz
            mov b,a
            do
                mov a,e
                rrc | rrc
                mov e,a
                dcr b
            while nz | wend
        endif
        mov a,e
        ani 03h
    pop b | pop d | pop h
ret