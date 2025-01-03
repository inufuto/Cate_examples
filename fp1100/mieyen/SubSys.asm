include "SubLoader_.inc"
include "SubMain_.inc"

ext SubLoader_, SubMain_, SubSound_

cseg

InitSub:    public InitSub
    ld a,33
    ld b,0
    call 0b00h  ; width 40
    
    ;ld a,19
    ;ld bc,701h
    ;call 0b09h  ; color 1,0

    ld hl,21*256+4
    ld (09FD7h),hl
    call 07A4h ; locate 4,21

    ld hl,SubLoader_
    ld b,0+(SubLoader__size+7)/8
    do
        call 0077Eh ; print defchr$
    dwnz

    ld a,6Bh
    call 00AFBh

    ld bc,SubMain__size
    ld a,c
    call SendSub
    ld a,b
    call SendSub
    ld hl,SubMain_
    do
        ld a,(hl)
        inc hl
        call SendSub
        dec bc
        ld a,c
        or b
    while nz | wend
ret


SendSub: public SendSub
    push de | push bc
        ld bc,0ff80h
        do
            in e,(c)
            bit 7,e
        while z | wend
        
        ld c,0c0h
        out (c),a
        
        ld c,80h
        ld e,0C0h
        out (c),e
        ld e,20h
        out (c),e

        do
            in e,(c)
            bit 7,e
        while nz | wend
    pop bc | pop de
ret

RcvSub: public RcvSub
    push de | push bc
        ld bc,0ff80h
        do
            in a,(c)
            bit 7,a
        while z | wend
        
        ld c,80h
        ld e,0C0h
        out (c),e
        ld e,20h
        out (c),e

        do
            in e,(c)
            bit 7,e
        while nz | wend
    pop bc | pop de
ret
