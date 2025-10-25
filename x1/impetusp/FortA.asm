include "Vram.inc"
include "Chars.inc"

ext PageOffset
ext FortDotOffset_

; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push af | push hl | push de | push bc
        ld c,a ; x
        ld a,e ; y
        add a,16+2
        ld l,a
        add a,a ;*2
        add a,a ;*4
        add a,l ;*5
        ld l,a | ld h,0
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,hl ;*40
        ld b,0
        add hl,bc
        ld bc,Vram0-VramRowSize*(16+2) | add hl,bc
        ld c,l
        ld a,(PageOffset)
        add a,h
        ld b,a

        ld a,(FortDotOffset_)
        or a
        if nz
            ld l,7
            ld d,Char_Fort1
        else
            ld l,6
            ld d,Char_Fort0
        endif
        do
            ld a,e ;y
            cp VramHeight
            if c
                ld h,6
                do
                    out (c),d | inc bc
                    inc d
                    dec h
                while nz | wend
                ld a,c | add a,VramRowSize-6 | ld c,a
                ld a,b | adc a,0 | ld b,a
            else
                ld a,d
                add a,6
                ld d,a
                ld a,c | add a,VramRowSize | ld c,a
                ld a,b | adc a,0 | ld b,a
            endif
            inc e
            dec l
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
