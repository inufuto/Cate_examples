include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_

VramTop equ Vram+VramWidth*2


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,VramTop
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push bc
                ld bc,VramRowSize-VVramWidth
                add hl,bc
            pop bc
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret