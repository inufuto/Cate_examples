cseg
SubMain: public SubMain
    call Rcv
    mov c,a
    mvi b,high SubMain
jb

SubAddress: public SubAddress
    call Rcv
    mov l,a
    call Rcv
    mov h,a
jr SubMain

SubStore: public SubStore
    call Rcv
    stax h+
jr SubMain

SubPattern: public SubPattern
    mvi c,8-1
    do
        call Rcv
        stax h+
        dcr c
    repeat
jr SubMain

SubScan: public SubScan
    mov a,pb

    ori a,80h
    mov 0e800h,a
    do
        skit f2
    repeat

    mvi e,00h
    mov 0e800h,e
jr SubMain

SubBeepOn: public SubBeepOn
    mvi a,30h
    mov 0e400h,a
jr SubMain


SubBeepOff: public SubBeepOff
    mvi a,20h
    mov 0e400h,a
jr SubMain

SubClearScreen: public SubClearScreen
    lxi h,2000h
    mvi c,3-1
    do
        push h
            lxi d,320/8*200
            ClearScreen1:
                mvi a,not 0
                stax h+
                dcx d
                mov a,e
                ora a,d
                eqi a,0
            jr ClearScreen1
        pop h
        adi h,40h
        dcr c
    repeat
jr SubMain

SubFill: public SubFill
    call Rcv
    mvi c,8-1
    do
        stax h+
        dcr c
    repeat
jr SubMain

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
