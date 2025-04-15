include "Vram.inc"
include "VVram.inc"

ext VVramFront_, VVramBack_
ext TerrainMap_


; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push af | push bc
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld b,0
        add hl,bc
    pop bc | pop af
ret


; void VVramBackToFront();
VVramBackToFront_: public VVramBackToFront_
    push hl | push de | push bc
        ld hl,VVramBack_
        ld de,VVramFront_
        ld bc,VVramWidth*VVramHeight
        ldir
    pop bc | pop de | pop hl
ret


; void ClearVVram();
ClearVVram_: public ClearVVram_
    push af | push hl | push de | push bc
        ld (ClearVVram_.sp+1),sp
        ld hl,VVramBack_+VVramWidth*VVramHeight
        ld de,VVramWidth*VVramHeight/2
        ld bc,0
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
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> TerrainMapPtr(byte x, byte y)
cseg
TerrainMapPtr_: public TerrainMapPtr_
    push af | push bc
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        ld b,0
        add hl,bc
        ld bc,TerrainMap_
        add hl,bc
    pop bc | pop af
ret
