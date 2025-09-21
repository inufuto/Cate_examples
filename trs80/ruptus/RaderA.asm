include "Vram.inc"

LeftTop equ Vram+VramRowSize*10+16*VramStep

cseg
RowTable:
defb 48 | defw LeftTop+VramRowSize*0
defb 3 | defw LeftTop+VramRowSize*1
defb 12 | defw LeftTop+VramRowSize*1
defb 48 | defw LeftTop+VramRowSize*1
defb 3 | defw LeftTop+VramRowSize*2
defb 12 | defw LeftTop+VramRowSize*2
defb 48 | defw LeftTop+VramRowSize*2
defb 3 | defw LeftTop+VramRowSize*3
defb 12 | defw LeftTop+VramRowSize*3
defb 48 | defw LeftTop+VramRowSize*3
defb 3 | defw LeftTop+VramRowSize*4
defb 12 | defw LeftTop+VramRowSize*4
defb 48 | defw LeftTop+VramRowSize*4
defb 3 | defw LeftTop+VramRowSize*5
defb 12 | defw LeftTop+VramRowSize*5
defb 48 | defw LeftTop+VramRowSize*5

RowPtr:
    ld d,a
    ld a,e
    add a,a ;*2
    add a,e ;*3
    ld l,a | ld h,0
    ld bc,RowTable | add hl,bc
    ld e,(hl) | inc hl
    ld a,(hl) | inc hl
    ld h,(hl)
    ld l,a
    ld c,d | ld b,0
    add hl,bc
ret

; void SetDot(byte x, byte y);
cseg
SetDot_: public SetDot_
    push af | push hl | push de | push bc
        call RowPtr
        ld a,(hl)
        or e
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret


; void ResetDot(byte x, byte y);
cseg
ResetDot_: public ResetDot_
    push af | push hl | push de | push bc
        call RowPtr
        ld a,e
        cpl
        ld e,a
        ld a,(hl)
        and e
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret


; void InvertDot(byte x, byte y);
cseg
InvertDot_: public InvertDot_
    push af | push hl | push de | push bc
        call RowPtr
        ld a,(hl)
        xor e
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret
