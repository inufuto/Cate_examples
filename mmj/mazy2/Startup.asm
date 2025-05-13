ext InitSound
ext Main_

cseg
    ld sp,5400h
    di
    call InitSound
jp Main_


Wait_ : public Wait_
    push af | push de | push bc
        ld e,a
        do
            ld bc,1000
            do
                dec bc
                ld a,c
                or b
            while nz | wend
            dec e
        while nz | wend
    pop bc | pop de | pop af
ret
