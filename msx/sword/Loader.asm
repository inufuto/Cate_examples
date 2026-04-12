include "BIOS.inc"
include "BinSize.inc"

SectorSize equ 512
SectorCount equ (BinSize+SectorSize-1)/SectorSize

cseg
    defb 0ebh
    defs 1dh
Entry: public Entry
    ret c
    ld hl,Loader
    ld de,8000h
    ld bc,Tail-Loader
    ldir
    jp 8000h
Loader:
    xor a
    ld b,SectorCount
    ld c,0f9h ; 720K
    ld de,1
    ld hl,8200h
    call 4010h

    jp 8200h
Tail:
