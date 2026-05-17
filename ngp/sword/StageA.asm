include "Vram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 10
RowCount equ 7

cseg
MapPtr: ; ->bc
    mul bc,0+(ColumnCount+4-1)/4
    ld b,a
    srl 2,b
    add c,b
    xor b,b
    add bc,StageMap_
ret

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push wa | push de | push bc
        call MapPtr
        ld d,0fch
        and a,3
        if nz
            do
                sll 2,e
                rlc 2,d
            dwnz a
        endif
        ld a,(xbc)
        and a,d
        or a,e
        ld (xbc),a
    pop bc | pop de | pop wa
ret

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push de | push bc
        call MapPtr
        ld e,(xbc)
        and a,3
        if nz
            do
                srl 2,e
            dwnz a
        endif
        ld a,e
        and a,03h
    pop bc | pop de
ret