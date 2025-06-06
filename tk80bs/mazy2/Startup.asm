ext InitKeys_
ext Main_
ext InitSound

cseg
Startup:
    di

    lxi sp,Startup
    mvi a,1 | sta $7dff ; ASCII mode

    ; mvi a,$b2 | sta $7dff ; 8255(BS)
    ; mvi a,$92 | out $fb ; 8255(TK-80)
    ; mvi a,$70 | out $fa ; 8255(TK-80)

    call InitKeys_
    call InitSound
jmp Main_


; void Wait(byte t);
cseg
Wait_: public Wait_
    push psw | push d | push b
        mov e,a
        do
            lxi b,800
            do
                dcx b
                mov a,c
                ora b
            while nz | wend
            dcr e
        while nz | wend
    pop b | pop d | pop psw
ret
