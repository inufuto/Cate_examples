include "Port.inc"
include "Vram.inc"
include "VVram.inc"

LeftX equ VVramWidth*VramStep
TopY equ 12

; word RaderAddress(byte x, byte y);
cseg
RaderAddress_: public RaderAddress_
    push af | push de
        ld d,0
        ld l,e | ld h,d
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,de ;*5
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,hl ;*40
        add hl,hl ;*80
        ld e,a
        add hl,de ;*80 + x
        ld de,Vram+VramRowSize*TopY+LeftX
        add hl,de
    pop de | pop af
ret

; ToggleDot(byte x, byte y);
cseg
ToggleDot_: public ToggleDot_
    push af | push hl | push de | push bc
        ld b,a | ld c,e
        srl a
        srl e | srl e
        call RaderAddress_
        ld a,l | out (VramAddressLow),a
        ld a,h | out (VramAddressHigh),a

        ld a,b | and 1
        if nz
            ld b,10h
        else
            ld b,01h
        endif
        ld a,c
        and 3
        do | while nz
            sla b
            dec a
        wend

        in a,(VramData)
        xor b
        out (VramData),a
    pop bc | pop de | pop hl | pop af
ret