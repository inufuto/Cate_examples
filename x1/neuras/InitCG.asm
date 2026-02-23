include 'X1.inc'
include 'Chars.inc'

extrn Chars, Ascii
ext WaitVSyncIn_,WaitVSyncOut_

InitCG: public InitCG
    ld bc,Atributes
    ld a,Attribute_PCG or 7
    out (c),a

    ld e,Char_Wall
    ld hl,Chars
    do
        ld bc,VRAM
        out (c),e
        call FillVramExtra
        ld bc,1500h
        do 
            call WriteCG
            inc b
            ld a,b
            cp 18h
        while nz | wend
        inc e
        ld a,e
        cp Char_End
    while nz | wend

    ld e,20h
    ld hl,Ascii
    do
        ld bc,VRAM
        out (c),e
        call FillVramExtra
        ld bc,1500h
        do 
            push hl
                call WriteCG
            pop hl
            inc b
            ld a,b
            cp 18h
        while nz | wend
        ld bc,8
        add hl,bc
        inc e
        ld a,e
        cp 60h
    while nz | wend
ret 

WriteCG:
    ld d,8
    di
            exx
                call WaitVSyncOut_
                call WaitVSyncIn_
            exx
        WriteCG0:
            ld a,(hl)
            out (c),a
            inc hl
            inc bc
            nop
            inc hl
            dec hl
            ld a,13
            WriteCG1:
                dec a
            jp nz,WriteCG1
            dec d
        jp nz,WriteCG0
    ei
ret


FillVramExtra:
    ld bc,VRAM+VramWIdth*VramHeight
    ld d,20h
    do
        out (c),e
        res 4,b
        out (c),d
        set 4,b
        inc bc
        ld a,c
        or a
    while nz | wend
ret