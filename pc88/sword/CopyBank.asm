include "BinSize.inc"

cseg
    di
    ;64K RAM
    ld a,(0e6c2h)
    or 2
    out (31h),a
    ld (0e6c2h),a

    ld hl,source
    ld de,BinTop
    ld bc,BinSize
    ldir
jp BinTop
source:
