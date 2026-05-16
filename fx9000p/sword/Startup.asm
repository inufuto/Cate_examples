include "Vram.inc"

ext InitKeys
ext Main_

cseg
Startup: public Startup
    ei

    ld bc,6003h
    ld a,14 | out (c),a
    dec c
    ld a,0ffh | out (c),a

    call InitKeys
jp Main_


; void Wait(byte t);
cseg
Wait_: public Wait_
    push af | push de | push bc
        ld e,a
        do
            ld bc,1800
            do
                dec bc
                ld a,c | or b
            while nz | wend
            dec e
        while nz | wend
    pop bc | pop de | pop af
ret
