include "BinSize.inc"

cseg
        ld bc,2*256 + 36
        call 5
        ld bc,40*256 + 35
        call 5
        ld bc,0fh*256 + 37
        call 5
    di
    
    in a,(22h)
    and 03h
    or 02h
    out (3ch),a

    ld hl,source
    ld de,BinTop
    ld bc,BinSize
    ldir
jp BinTop
source:
