include "VVram.inc"

ext PollVSync_

dseg
VVram_: public VVram_
    defs VVramWidth*VVramHeight
SpSave:
    defw 0


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    push af | push hl | push de | push bc
        ld (SpSave),sp
        ld hl,VVram_+VVramWidth*VVramHeight
        ld de,VVramWidth*VVramHeight/2
        ld bc,0
        ld sp,hl
        do
            push bc
            dec de
            ld a,e
            or d
        while nz | wend
        ld hl,(SpSave)
        ld sp,hl
        call PollVSync_
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push de | push bc
        ex de,hl
            ld h,0
            ld c,l | ld b,h
            add hl,hl ;*2
            push hl
                add hl,bc ;*3
                add hl,hl ;*6
                add hl,hl ;*12
                add hl,hl ;*24
            pop bc
            add hl,bc ;*26
        ex de,hl
        ld l,a
        ld h,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop bc | pop de
ret


