ext InitKeys_
ext Main_
ext InitSound

cseg
Startup:
    di

    lxi sp,Startup
    mvi a,1 | sta 7dffh ; ASCII mode

    ; mvi a,0b2h | sta 7dffh ; 8255(BS)
    ; mvi a,92h | out 0fbh ; 8255(TK-80)
    ; mvi a,70h | out 0fah ; 8255(TK-80)

    call InitKeys_
    call InitSound
jmp Main_


; void Wait(byte t);
cseg
Wait_: public Wait_
    push psw | push d | push b
        mov e,a
        do
            lxi b,1000
            do
                dcx b
                mov a,c
                ora b
            while nz | wend
            dcr e
        while nz | wend
    pop b | pop d | pop psw
ret
