include "Vram.inc"

ext StageMap_

ColumnCount equ 16

cseg
MapPtr:
    ld b,a
    rrca | and 7fh 
    ld d,a
    ld a,e
    add a,a ;*2
    add a,a ;*4
    add a,a ;*8
    add a,d
    add a,low StageMap_ | ld l,a
    ld a,high StageMap_ | adc a,0 | ld h,a
    ld a,b
    and 1
ret

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    push af | push de | push bc
        call MapPtr
    pop bc | pop de | pop af
ret


; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push af | push hl | push de | push bc
        call MapPtr
        if nz
            ld a,(hl)
            and 0fh
            sla c | sla c | sla c | sla c
        else
            ld a,(hl)
            and 0f0h
        endif
        or c
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push hl | push de | push bc
        call MapPtr
        ld a,(hl)
        if nz
            rrca | rrca | rrca | rrca
        endif
        and 0fh
    pop bc | pop de | pop hl
ret