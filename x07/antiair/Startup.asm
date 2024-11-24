ext InitKeys
ext InitSound
ext InitChars
ext Main_

cseg
    ld a,33h ; REPEAT KEY OFF
    call 0e428h
    ld a,38h ; CLICK OFF
    call 0e428h

    call InitKeys
    call InitSound
    call InitChars

    call Main_

    ld a,32h ; REPEAT KEY ON
    call 0e428h
    ld a,39h ; CLICK ON
    call 0e428h
ret


; void Wait(byte t);
cseg
Wait_: public Wait_
    push af | push de | push bc
        ld e,a
        do
            ld bc,1000
            do
                dec bc
                ld a,c | or b
            while nz | wend
            dec e
        while nz | wend
    pop bc | pop de | pop af
ret
