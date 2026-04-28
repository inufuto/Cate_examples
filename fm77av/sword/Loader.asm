include "BinSize.inc"

SectorSize equ 256
SectorCount equ (Size+SectorSize-1)/SectorSize

dseg
RCB:
RQNO: 
    defb 0
RCBSTA:
    defb 0
RCBDBA:
    defw 0
RCBTRK:
    defb 0
RCBSCT:
    defb 0
RCBSID:
    defb 0
RCBUNT:
    defb 0

cseg
    lda #24 | sta RQNO
    ldx #RCB
    jsr [$fbfa]

    lda #10 | sta RQNO
    clr RCBTRK
    lda #2 | sta RCBSCT
    clr RCBSID
    clr RCBUNT
    ldy #Top
    ldb #SectorCount
    do
        sty RCBDBA
        ldx #RCB
        pshs b,y
            jsr [$fbfa]
        puls b,y
        lda RCBSCT
        inca
        cmpa #16+1
        if cc
            lda RCBSID
            inca
            cmpa #2
            if cc
                inc RCBTRK
                clra
            endif
            sta RCBSID
            lda #1
        endif
        sta RCBSCT
        leay SectorSize,y
        decb
    while ne | wend
jmp Top
