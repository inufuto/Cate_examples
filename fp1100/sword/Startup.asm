ext InitSub
ext InitVram
ext InitSound
ext Main_

cseg
    call InitSub
    call InitVram
    call InitSound
jp Main_


Wait_ : public Wait_
    push af | push de | push bc
        ld e,a
        do
            ld bc, 1500
            do
                dec bc
                ld a,c
                or b
            while nz | wend
            dec e
        while nz | wend
    pop bc | pop de | pop af
ret
