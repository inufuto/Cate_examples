include "LoaderCode.inc"

ext LoaderCode

cseg
    ld hl,LoaderCode
    ld de,LoaderCode_start
    ld bc,LoaderCode_size
    ldir
jp LoaderCode_start
