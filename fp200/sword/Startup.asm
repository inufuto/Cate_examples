ext Main_
; ext InitSound
ext ClearScreen_

dseg
OldMask:
    defb 0

cseg
    di
        defb 20h ; RIM
        sta OldMask
        mvi a,0cfh
        defb 30h ; SIM
    ei
    ; call InitSound
    call Main_
    call ClearScreen_
    di
        lda OldMask
        defb 30h ; SIM
    ei
ret


; void Wait(byte t);
cseg
Wait_: public Wait_
    push psw | push d | push b
        mov e,a
        do
            lxi b,1200
            do
                dcx b
                mov a,c
                ora b
            while nz | wend
            dcr e
        while nz | wend
    pop b | pop d | pop psw
ret
