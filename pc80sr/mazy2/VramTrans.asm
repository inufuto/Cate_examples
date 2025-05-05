include "Vram.inc"
include "Chars.inc"

cseg

ClearVram: public ClearVram
    di
        ld a,0c4h | out (33h),a
        xor a | out (34h),a
        ld a,80h | out (35h),a

        ld hl,VramBack
        ld de,VramBack+1
        ld bc,8000-1
        ld (hl),0ffh
        ldir

        ld hl,VramFront
        ld de,VramFront+1
        ld bc,8000-1
        ld (hl),0ffh
        ldir

        ld a,90h | out (35h),a
        ld a,84h | out (33h),a
    ei
ret


WriteVram: public WriteVram
    ld c,5ch
    do
        push hl
            out (c),a
            ld b,8
            do
                ld a,(de)
                ;ld a,055h
                inc de
                ld (hl),a
                push bc
                    ld bc,40
                    add hl,bc
                pop bc
            dwnz
        pop hl
        inc c
        ld a,c
        cp 5fh
    while nz | wend
    out (5fh),a
ret


InitChar:
    ld c,5ch
    do
        push hl
            out (c),a
            ld b,8
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
        pop hl
        inc c
        ld a,c
        cp 5fh
    while nz | wend
    out (5fh),a
ret

InitOffscreen: public InitOffscreen
    ld hl,Offscreen
    ld de,PatternRam+Char_Space*CharHeight*3
    call InitChar

    ld hl,Offscreen+CharHeight
    ld de,PatternRam+Char_Wall*CharHeight*3
    call InitChar
ret


FromOffscreen: public FromOffscreen
    ld a,0c4h | out (33h),a
    ld b,CharHeight
    do
        ld a,(de) | inc de
        ld (hl),a
        push bc
            ld bc,40
            add hl,bc
        pop bc
    dwnz
    ld a,094h | out (33h),a
ret
