include "BinSize.inc"

PUTCOM equ 6e2h
PUTDAT equ 6e8h
GETDAT equ 737h

Top equ 8100h
Size equ 0ac00h-Top
SectorSize equ 256
SectorCount equ (BinSize+SectorSize+19-1)/SectorSize
SectorPerTrack equ 16

cseg
    ld a,17h | call PUTCOM ; Mode command
    ld a,0fh | call PUTDAT

    ld hl,Top
    ld de,3
    ld c,SectorCount
    do
        ld a,c
        cp SectorPerTrack
        if nc
            ld a,SectorPerTrack
        endif
        inc a
        sub e
        ld b,a

        push bc
            ld a,02h | call PUTCOM ; Read command
            ld a,b | call PUTDAT ; count
            xor a | call PUTDAT ; drive
            ld a,d | call PUTDAT ; track
            ld a,e | call PUTDAT ; sector

            ld a,03h | call PUTCOM ; Send command
            ld c,b
            do
                ld b,0
                do
                    call GETDAT
                    ld (hl),a | inc hl
                dwnz
                dec c
            while nz | wend
            ld e,1
            inc d
        pop bc
        ld a,c
        sub b
        ld c,a
    while nz | wend
jp Top
