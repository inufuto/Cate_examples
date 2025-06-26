include "S1.inc"
include "BinSize.inc"

FDC equ $ff00
FDC_Status equ FDC+0
FDC_Command equ FDC+0
FDC_Track equ FDC+1
FDC_Sector equ FDC+2
FDC_Data equ FDC+3
DRIVESEL equ $ff04

SeekCommand equ $10
ReadCommand equ $80
DriveSelValue equ $28

SectorSize equ 256
SectorCount equ 16

Vram equ $1000

dseg
count:
    defb 0
side: ; $00 or $20
    defb 0
track: ; 0-39
    defb 0
sector: ; 1-16
    defb 0
digitCount:
    defb 0

cseg
    ldx #MAP0+(BinTop+$fff)/$1000
    ldb #(BinSize+$1fff)/$1000
    lda #$89
    do
        sta ,x+
        inca
        decb
    while ne | wend
    lda #$bc | sta MAP1 ; Vram

    pshs cc | orcc #$50
        ldx #BinTop
        clr track
        clr side
        bsr Seek

        lda #3 | sta sector
        ldb #(BinSize+SectorSize-1)/SectorSize | stb count
        do
            ldb count
            ldy #Vram+2
            bsr PrintX2

            lda sector | coma | sta FDC_Sector
            lda track | coma | sta FDC_Track
            lda #not ReadCommand
            sta FDC_Command
            nop
            read_next:
                do
                    lda DRIVESEL
                    asra
                    bcc read_end
                    lda DRIVESEL
                while mi | wend
                lda FDC_Data
                coma
                sta ,x+
            bra read_next
            read_end:
            lda sector
            inca
            sta sector
            cmpa #SectorCount+1
            if cc
                lda #1
                sta sector
                lda side
                eora #$10
                sta side
                if eq
                    inc track
                endif
                bsr Seek
            endif
            ldy #Vram+3+5
            bsr PrintX4

            dec count
        while ne | wend
    puls cc
jmp BinTop
; lll:
;     bra lll


Seek:
    lda track
    coma
    sta FDC_Data

    lda side
    ora #DriveSelValue
    sta DRIVESEL
    nop

    lda #not SeekCommand | sta FDC_Command
    sync
    lda FDC_Status
    coma
    anda #$18
    bne SeekError
; bra Wait

Wait:
    do
        lda FDC_Status
        coma
        anda #$81
    while ne | wend
rts

PrintX4:
    lda #4 | sta digitCount
    tfr x,d
    do
        bsr PrintX1
        lsra | rorb
        lsra | rorb
        lsra | rorb
        lsra | rorb
        dec digitCount
    while ne | wend
rts
PrintX2:
    lda #2 | sta digitCount
    do
        bsr PrintX1
        rorb
        rorb
        rorb
        rorb
        dec digitCount
    while ne | wend
rts
PrintX1:
    pshs b
        andb #$0f
        cmpb #10
        if cs
            addb #$30
        else
            addb #$41-10
        endif
        stb ,-y
    puls b
rts

SeekError:
    ldx #SeekErrorM
; bra ShowError
ShowError:
    ldy #Vram+80
    do
        lda ,x+
    while ne
        sta ,y+
    wend
eee: bra eee
SeekErrorM:
    defb "Seek Error",0
