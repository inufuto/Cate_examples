ext InitSound
ext Main_ 

cseg
    call InitSound
jp Main_


; void Wait(byte t);
cseg
Wait_: public Wait_
    push af | push hl | push bc
        ld b,a
        do
            ld hl,300
            do
                dec hl
                ld a,l
                or h
            while nz | wend
        dwnz
    pop bc | pop hl | pop af
ret
