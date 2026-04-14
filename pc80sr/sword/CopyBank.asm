include "BinSize.inc"

cseg
    di
    ;64K RAM
    ld a,1eh
    out (31h),a

    ld hl,source
    ld de,BinTop
    ld bc,BinSize
    ldir
jp BinTop
source:
