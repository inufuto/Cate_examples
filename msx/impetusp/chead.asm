include "BIOS.inc"

cseg
    defb 'AB'
    defw entry
    defw 0
    defw 0
    defw 0
    defs 6
entry:
    ld c,-1
loop:
    inc c
    ld hl,entry
    ld b,100
    do
        ld a,c
        push hl | push bc
            call RDSLT
        pop bc | pop hl
        cp (hl)
        jr nz,loop
        inc hl
    dwnz
    ld a,c
    ld hl,8000h
    call ENASLT
