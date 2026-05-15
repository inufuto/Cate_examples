ext Main_
ext InitSound

MASK equ 17h
LCDSTAT equ 40h

cseg
    in a,(MASK)
    push af
        and not 7
        out (MASK),a
        ld a,40h
        out (LCDSTAT),a
        call InitSound
        call Main_
    pop af
    out (MASK),a
ret


; void Wait(byte t);
cseg
Wait_: public Wait_
    push af | push de | push bc
        ld e,a
        do
            ld bc,5000
            do
                dec bc
                ld a,c | or b
            while nz | wend
            dec e
        while nz | wend
    pop bc | pop de | pop af
ret
