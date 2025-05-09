cseg
    ld hl,6080h | ld (vramPos),hl
    ld hl,StartM | call PutS

    di
        call 4863h ; 454eh
        call 4775h ; 445fh
        call 44deh ; 41d4h

        call ReadHeadByte

        call Read1 | ld h,a
        add a,c | ld c,a
        call Read1 | ld l,a
        add a,c | ld c,a
        call Read1
        add a,c
        jr nz,SumError
        ld (entry),hl

        do
            call ReadHeadByte
            call Read1
            or a
        while nz
            ld b,a
            add a,c | ld c,a
            do
                call Read1
                ld (hl),a | inc hl
                add a,c | ld c,a
            dwnz
            call Read1
            add a,c
            jr nz,SumError
        wend
        call Read1
        or a
        jr nz,SumError
        
        call 486ah; 4555h
    ei
ld hl,(entry)
jp (hl)

SumError:
    ld hl,(vramPos)
    do
        ld a,l
        and 1fh
    while nz
        inc hl
    wend
    ld (vramPos),hl
    ld hl,SumErrorM
    call PutS
    call 486ah; 4555h
    ei
ret

Read1:
    push hl | push bc
        call 444bh ; 413eh
    pop bc | pop hl
ret

ReadHeadByte:
    do
        call Read1
        cp 3ah
    while nz | wend
    call    PutC
    ld c,0
ret

PutC:
    push hl
        ld hl,(vramPos)
        ld (hl),a | inc hl
        ld (vramPos),hl
    pop hl
ret

PutS:
    do
        ld a,(hl) | inc hl
        or a
    while nz
        call PutC
    wend
ret

StartM:
    defb "PLAY CMT",0
SumErrorM:
    defb "CHECK SUM ERROR",0
vramPos:
    defw 0
entry:
    defw 0

