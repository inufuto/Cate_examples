include "BinSize.inc"

Top equ 0000h
SectorSize equ 256
SectorCountPerTrack equ 16
AllSectorCount equ (BinSize+SectorSize-1)/SectorSize

ResidentRam equ 0e000h

CurrentDrive equ 0fc01h
CurrentTrack equ 0fc02h
CurrentSide equ 0fc03h
CurrentSector equ 0fc04h
SectorCountToRead equ 0fc09h
CurrentAddress equ 0fc0ah

cseg
    xor a
    ld (CurrentDrive),a
    ld (CurrentTrack),a
    ld (CurrentSide),a
    ld a,2
    ld (CurrentSector),a
    ld hl,ResidentRam
    ld (CurrentAddress),hl

    ld hl,Top
    ld de,(1 shl 8) or AllSectorCount
    do
        ld a,SectorCountPerTrack
        sub d
        cp e
        if nc
            ld a,e
        endif
        ld b,a
        ld (SectorCountToRead),a
        ld a,e
        sub b
        ld e,a
        call 07fdh
        ld a,(CurrentSide) | xor 1 | ld (CurrentSide),a
        if z
            ld a,(CurrentTrack)
            inc a
            ld (CurrentTrack),a
        endif
        ld a,(CurrentDrive) | xor 4 | ld (CurrentDrive),a
        call 07fah
        ld a,1
        ld (CurrentSector),a

        push de
            ex de,hl
                ld hl,ResidentRam
                ld c,0
                di
                    ld a,1 | out (1ch),a
                    ldir
                    xor a | out (1ch),a
                ei
            ex de,hl
        pop de

        ld d,0
        ld a,e
        or a
    while nz | wend

    ; di
    ld a,1 | out (1ch),a
jp Top
