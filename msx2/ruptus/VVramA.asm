include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y)
cseg
VVramPtr_: public VVramPtr_
    push af | push de
        ex af,af'
            ld a,e
            add a,a ;*2
            add a,e ;*3
            ld l,a | ld h,0
            add hl,hl ;*6
            add hl,hl ;*12
            add hl,hl ;*24
        ex af,af'
        ld e,a | ld d,0
        add hl,de
        ld de,VVram_ | add hl,de
    pop de | pop af
ret


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    push af | push hl | push de | push bc
        ld (ClearVVram_.sp+1),sp
    ld hl,VVram_+VVramWidth*VVramHeight
        ld de,VVramWidth*VVramHeight/2
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
