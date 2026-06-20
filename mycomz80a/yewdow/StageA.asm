ext CellMap_


cseg
CellPtr:
    ex de,hl
    ld h,0
    ld d,0
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,hl ;*8
    ld e,a
    srl e
    add hl,de
    ld de,CellMap_ | add hl,de
ret

; byte GetCell(byte x, byte y);
cseg
GetCell_: public GetCell_
    push hl | push de
        call CellPtr
        and 1
        ld a,(hl)
        if nz
            rrca | rrca | rrca | rrca
        endif
        and 0fh
    pop de | pop hl
ret


; byte SetCell(byte x, byte y, byte cell);
SetCell_: public SetCell_
    push af | push hl | push de | push bc
        call CellPtr
        and 1
        ld a,c
        if nz
            rlca | rlca | rlca | rlca
            and 0f0h
            ld c,a
            ld a,(hl)
            and 0fh
        else
            and 0fh
            ld c,a
            ld a,(hl)
            and 0f0h
        endif
        or c
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret
