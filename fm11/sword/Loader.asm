include "BinSize.inc"

Top equ $1000
SectorSize equ 256
SectorCount equ (BinSize+SectorSize-1)/SectorSize

ReadSector equ $5006

cseg
    clr track
    lda #2 | sta sector
    clr side
    clr drive
    clr bank
    lda #1 | sta density

    ldy #Top
    ldb #SectorCount
    do
        sty pDestination
        ldx #RCB
        pshs b,y
            do
                jsr ReadSector
            while cs | wend
        puls b,y
        lda sector
        inca
        cmpa #16+1
        if cc
            lda side
            inca
            cmpa #2
            if cc
                inc track
                clra
            endif
            sta side
            lda #1
        endif
        sta sector
        leay SectorSize,y
        decb
    while ne | wend
    lda #$01 | sta $FD93 ; Disable Boot ROM
jmp Top


dseg
RCB:
    defs 2
pDestination:
    defw 0
track:
    defb 0
sector:
    defb 0
side:
    defb 0
drive:
    defb 0
bank:
    defb 0
density:
    defb 0
