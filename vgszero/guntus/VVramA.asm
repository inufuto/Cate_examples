include "vgszero.inc"
include "Vram.inc"
include "VVram.inc"

dseg
VVram_: public VVram_
    defs VVramWidth*VVramHeight


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld e,0
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),e | inc hl
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push af | push de
        ld l,e | ld h,0
        add hl,hl
        ld de,Ytable | add hl,de
        ld e,a | ld d,0
        ld a,(hl) | inc hl
        ld h,(hl) | ld l,a
        add hl,de
        ld de,VVram_ | add hl,de
    pop de | pop af
ret

Ytable:
defw VVramWidth*0
defw VVramWidth*1
defw VVramWidth*2
defw VVramWidth*3
defw VVramWidth*4
defw VVramWidth*5
defw VVramWidth*6
defw VVramWidth*7
defw VVramWidth*8
defw VVramWidth*9
defw VVramWidth*10
defw VVramWidth*11
defw VVramWidth*12
defw VVramWidth*13
defw VVramWidth*14
defw VVramWidth*15
defw VVramWidth*16
defw VVramWidth*17
defw VVramWidth*18
defw VVramWidth*19
defw VVramWidth*20
defw VVramWidth*21
defw VVramWidth*22
defw VVramWidth*23
