include "SubMainBin.inc"

cseg
SubLoader:  public SubLoader
    di
    lxi sp,0

    lxi h,SubMain_start
    call Rcv
    mov c,a
    call Rcv
    mov b,a
    do
        call Rcv
        stax H+
        dcx b
        mov a,c
        ora a,b
        eqi a,0
    repeat
jmp SubMain

Rcv:
    mvi e,80h
    mov 0e800h,e
    do
        skit f2
    repeat
    mov a,0e800h
    mvi e,00h
    mov 0e800h,e
ret
