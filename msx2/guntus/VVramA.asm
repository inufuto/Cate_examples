include "Vram.inc"

dseg
VVram_: public VVram_
    defs WindowWidth*WindowHeight


; ptr<byte> VVramPtr(byte x, byte y);
cseg
YTable:
    defw WindowWidth*0,WindowWidth*1,WindowWidth*2,WindowWidth*3,WindowWidth*4,WindowWidth*5,WindowWidth*6,WindowWidth*7,WindowWidth*8,WindowWidth*9,WindowWidth*10,WindowWidth*11,WindowWidth*12,WindowWidth*13,WindowWidth*14,WindowWidth*15,WindowWidth*16,WindowWidth*17,WindowWidth*18,WindowWidth*19,WindowWidth*20,WindowWidth*21,WindowWidth*22,WindowWidth*23
VVramOffset: public VVramOffset
    ld l,e | ld h,0
    add hl,hl ;*2
    ld de,YTable | add hl,de
    ld e,(hl) | inc hl
    ld d,(hl)
    ld l,a | ld h,0
    add hl,de
ret
VVramPtr_: public VVramPtr_
    push de
        call VVramOffset
        ld de,VVram_ | add hl,de
    pop de
ret


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    push af | push hl | push de | push bc
        ld (ClearVVram_.sp+1),sp
    ld hl,VVram_+WindowWidth*WindowHeight
        ld de,WindowWidth*WindowHeight/2
        ld bc,0
        di
            ld sp,hl
            do
                push bc
                dec de
                ld a,e
                or d
            while nz | wend
            ClearVVram_.sp:
            ld hl,0
            ld sp,hl
        ei
    pop bc | pop de | pop hl | pop af
ret
