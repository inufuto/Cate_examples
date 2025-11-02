include "BinSize.inc"

cseg
    di
    ld a,20h | out (2ah),a

    ld hl,source
    ld de,BinTop
    ld bc,BinSize
    ldir
jp BinTop
source:
