include "Vram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 10
RowCount equ 7

cseg
MapPtr:
    ld b,a
    rrca | rrca | and a,0fh 
    ld d,a
    ld a,e
    add a,a ;*2
    add a,e ;*3
    add a,d
    add a,low StageMap_ | ld l,a
    ld a,high StageMap_ | adc a,0 | ld h,a
    ld a,b
    and a,3
ret

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push af | push hl | push de | push bc
        call MapPtr
        ld e,0fch
        or a,a
        do | while nz
            sla c | sla c
            rlc e | rlc e
            dec a
        wend
        ld a,(hl)
        and a,e
        or a,c
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push hl | push de | push bc
        call MapPtr
        ld e,(hl)
        or a,a
        do | while nz
            srl e | srl e
            dec a
        wend
        ld a,e
        and a,03h
    pop bc | pop de | pop hl
ret