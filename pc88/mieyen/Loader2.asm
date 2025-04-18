include "BinSize.inc"

PUTCOM equ 37CCh
PUTDAT equ 37D2h
GETDAT equ 3847h

Top equ 9000h
SectorSize equ 256
SectorCount equ (BinSize+SectorSize-1)/SectorSize

cseg
    ld a,17h | call PUTCOM ; Mode command
    ld a,0fh | call PUTDAT ; count

    ld hl,Top
    ld de,3
    ld c,SectorCount
    do
        ld a,02h | call PUTCOM ; Read command
        ld a,1 | call PUTDAT ; count
        xor a | call PUTDAT ; drive
        ld a,d | call PUTDAT ; track
        ld a,e | call PUTDAT ; sector

        ld a,06h | call PUTCOM ; send result
        call GETDAT
        and 1

        ld a,03h | call PUTCOM ; Send command
        ld b,0
        do
            call GETDAT
            ld (hl),a | inc hl
        dwnz
        inc e
        ld a,e
        cp 16+1
        if nc
            inc d
            ld e,1
        endif
        dec c
    while nz | wend
jp Top
