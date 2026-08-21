ext Startup
ext Handler

cseg
    defb 0,0,0,0
    jp su0
su0007:
    jp su1 
su0:    
    di
    im 1
    ld sp,0c000h
    ld hl,bytes
    ld c,0f8h
    do
        ld a,(hl)
        out (c),a
        inc hl
        inc c
    while nz | wend
    in a,(0fdh)
    jp su0007
su1:
    jp Startup
bytes:
    defb 0ffh,0ffh,0ffh,2
    defb 3,0,0b8h,10h

    defs 38h-2Ch
_Rst38h: public _Rst38h
    jp Handler
    defs 40h-38h-3
