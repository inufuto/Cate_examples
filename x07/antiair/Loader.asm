cseg
    ld hl,StartM
    call PutS

    ld de,0e787h
    ld iy,2c5h
    xor a
    call 0e6a8h

    in a,(0f4h)
    or 01h
    out (0f4h),a

    ld de,2c5h
    call 0e827h

    call ReadHeadByte

    call 0e8d4h | ld h,a
    add a,c | ld c,a
    call 0e8d4h | ld l,a
    add a,c | ld c,a
    call 0e8d4h
    add a,c
    jr nz,SumError
    ld (entry),hl

    do
        call ReadHeadByte
        call 0e8d4h
        or a
    while nz
        ld b,a
        add a,c | ld c,a
        do
            call 0e8d4h
            ld (hl),a | inc hl
            add a,c | ld c,a
        dwnz
        call 0e8d4h
        add a,c
        jr nz,SumError
    wend
    call 0e8d4h
    or a
    jr nz,SumError

    in a,(0f4h)
    and 0feh
    out (0f4h),a

    ld hl,(entry)
jp (hl)

ReadHeadByte:
    do
        call 0e8d4h
        cp 3ah
    while nz | wend
    call 0c1beh
    ld c,0
ret
SumError:
    ld hl,SumErrorM
    call PutS
ret
PutS:
    do
        ld a,(hl) | inc hl
        or a
    while nz
        call 0c1beh
    wend
ret
StartM:
    defb "PLAY CMT",0
SumErrorM:
    defb 13,10,"CHECK SUM ERROR",0
entry:
    defw 0
