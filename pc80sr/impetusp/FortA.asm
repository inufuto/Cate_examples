include "VVram.inc"
include "Chars.inc"

ext VVramBack_

; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push af | push hl | push de | push bc
        ld c,a ; x
        ld a,e ; y
        add a,16+2
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld b,0
        add hl,bc
        ld bc,VVramBack_-VVramWidth*(16+2) | add hl,bc

        ld d,Char_Fort
        ld c,6
        do
            ld a,e ;y
            cp VVramHeight
            if c
                ld b,6
                do
                    ld (hl),d | inc hl
                    inc d
                dwnz
                ld a,l | add a,VVramWidth-6 | ld l,a
                ld a,h | adc a,0 | ld h,a
            else
                ld a,d | add a,6 | ld d,a
                ld a,l | add a,VVramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            endif
            inc e
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
