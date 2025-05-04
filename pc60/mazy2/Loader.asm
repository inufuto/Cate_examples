OPENTAPE equ 1A61h
READTAPE equ 1A70h
CLOSETAPE equ 1AAAh
CLS equ 1DFBh
PUTC equ 1075h

cseg
    call CLS
    ld hl,StartM | call PutS

    di
        call OPENTAPE

        call ReadHeadByte

        call READTAPE | ld h,a
        add a,c | ld c,a
        call READTAPE | ld l,a
        add a,c | ld c,a
        call READTAPE
        add a,c
        jr nz,SumError
        ld (entry),hl

        do
            call ReadHeadByte
            call READTAPE
            or a
        while nz
            ld b,a
            add a,c | ld c,a
            do
                call READTAPE
                ld (hl),a | inc hl
                add a,c | ld c,a
            dwnz
            call READTAPE
            add a,c
            jr nz,SumError
        wend
        call READTAPE
        or a
        jr nz,SumError
        
        call CLOSETAPE
    ei
ld hl,(entry)
jp (hl)

SumError:
    ld hl,SumErrorM
    call PutS
    call CLOSETAPE
    ei
ret

ReadHeadByte:
    do
        call READTAPE
        cp 3ah
    while nz | wend
    call    PUTC
    ld c,0
ret

PutS:
    do
        ld a,(hl) | inc hl
        or a
    while nz
        call PUTC
    wend
ret

StartM:
    defb "PLAY CMT",0
SumErrorM:
    defb 13,10,"CHECK SUM ERROR",0
entry:
    defw 0

