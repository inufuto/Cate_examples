ext Chars, Ascii

    cseg

ClearVram:   public ClearVram
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a

            ld a,77h
            out (0ch),a
            ld hl,08000h
            ld de,08001h
            ld bc,640/8*200-1
            ld (hl),0
            ldir
        pop af
        out (3ch),a
    ei
ret


Put8:
    ld a,11h
    do
        out (0ch),a
        ex af,af'
            ld b,8
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            ld bc,-8
            add hl,bc
        ex af,af'
        add a,a
    while p | wend
    ld bc,8
    add hl,bc
ret

Put4:
    ld a,11h
    do
        out (0ch),a
        ex af,af'
            ld b,4
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            inc de | inc de | inc de | inc de
            dec hl | dec hl | dec hl | dec hl
        ex af,af'
        add a,a
    while p | wend
    inc hl | inc hl | inc hl | inc hl
ret

Clear8:
    ld a,11h
    do
        out (0ch),a
        ex af,af'
            xor a
            ld b,8
            do
                ld (hl),a | inc hl
            dwnz
            ld bc,-8
            add hl,bc
        ex af,af'
        add a,a
    while p | wend
    ld bc,8
    add hl,bc
ret

Clear4:
    ld a,11h
    do
        out (0ch),a
        ex af,af'
            xor a
            ld b,4
            do
                ld (hl),a | inc hl
            dwnz
            dec hl | dec hl | dec hl | dec hl
        ex af,af'
        add a,a
    while p | wend
    inc hl | inc hl | inc hl | inc hl
ret


TPut: public TPut
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a
            call Put8
        pop af
        out (3ch),a
    ei
ret


TClear8: public TClear8
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a
            call Clear8
        pop af
        out (3ch),a
    ei
ret


TPut8: public TPut8
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a
            call Put8
        pop af
        out (3ch),a
    ei
ret


TClearPut: public TClearPut
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a
            call Clear4
            call Put4
        pop af
        out (3ch),a
    ei
ret


TPutClear: public TPutClear
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a
            inc de | inc de | inc de | inc de
            call Put4
            call Clear4
        pop af
        out (3ch),a
    ei
ret


TPutPut: public TPutPut
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a
            push de
                inc de | inc de | inc de | inc de
                call Put4
            pop de
            ex de,hl
                ld bc,8*3*4
                add hl,bc
            ex de,hl
            call Put4
        pop af
        out (3ch),a
    ei
ret


TPrintC: public TPrintC
    di
        in a,(22h)
        push af
            or 6
            out (3ch),a
            ld a,77h
            out (0ch),a
            ex af,af'
                ld b,8*2
                do
                    ld a,(de) | inc de
                    ld (hl),a | inc hl
                dwnz
            ex af,af'
        pop af
        out (3ch),a
    ei
ret
