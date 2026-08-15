include "BinSize.inc"

cseg
    di
    ;64K RAM
    ld a,(0e6c6h)
    or 2
    out (31h),a
    ld (0e6c6h),a

    ld hl,source
    ld de,BinTop
    ld bc,BinSize
    ldir
jp BinTop
source:
