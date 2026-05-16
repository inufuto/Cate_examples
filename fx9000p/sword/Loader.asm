include "BinSize.inc"

BankPort equ 4ff0h
BankStart equ 4100h
BankSize equ BankPort-BankStart
BankCount equ (BinSize+BankSize-1)/BankSize

cseg
    defb 0,0,0,0

    di
    ld bc,0
    do
        dec bc
        ld a,c | or b
    while nz | wend

    exx
        ld hl,BankPort
    exx
    ld de,BinStart
    ld b,BankCount
    do
        push bc
            ld hl,BankStart
            ld bc,BankSize
            do
                exx
                    ld a,(hl)
                exx
                ld a,(hl) | inc hl
                ld (de),a | inc de
                ld a,d
                cp high BinEnd+1
                jr nc,break
                dec bc
                ld a,c | or b
            while nz | wend
            break:
        pop bc
        exx
            inc l
        exx
    dwnz
    ei
jp BinStart
LoaderEnd: public LoaderEnd