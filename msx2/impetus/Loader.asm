include "BIOS.inc"
include "BinSize.inc"

SectorSize equ 512
SectorCount1 equ (BinSize1+SectorSize-1)/SectorSize
SectorCount2 equ (BinSize2+SectorSize-1)/SectorSize

cseg
    defb 0ebh
    defs 1dh
Entry: public Entry
    ret c
    ld sp,BinStart
    ld hl,Loader
    ld de,8000h
    ld bc,Tail-Loader
    ldir
    jp 8000h
Loader:
    xor a
    ld b,SectorCount1
    ld c,0f9h ; 720K
    ld de,1
    ld hl,BinStart
    call 4010h
    call BinStart

    xor a
    ld b,SectorCount2
    ld c,0f9h ; 720K
    ld de,SectorCount1
    ld hl,BinStart
    call 4010h
    jp BinStart
Tail:
