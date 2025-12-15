include "VVram.inc"
include "Chars.inc"

ext VVramPtr, VPutFront

; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push af | push hl | push de | push bc
        ld b,a
        ld d,e
        ld a,e | add a,16+2 | ld e,a
        ld a,b
        call VVramPtr
        ld bc,-VVramRowSize*(16+2) | add hl,bc
        

        ld e,Char_Fort
        ld c,6
        do
            ld a,d ;y
            cp VVramHeight
            if c
                ld b,6
                do
                    call VPutFront
                    inc e
                dwnz
                ld a,l | add a,VVramRowSize-VVramStep*6 | ld l,a
                ld a,h | adc a,0 | ld h,a
            else
                ld a,e | add a,6 | ld e,a
                ld a,l | add a,VVramRowSize | ld l,a
                ld a,h | adc a,0 | ld h,a
            endif
            inc d
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
