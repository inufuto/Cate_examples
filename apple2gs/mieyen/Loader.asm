include "BinSize.inc"

SectorSize equ 256
MaxSector equ 16
SectorCount equ (BinSize+SectorSize-1)/SectorSize
TrackCount equ (SectorCount+MaxSector-1)/MaxSector

data_ptr equ $26
slot_index equ $2b
sector equ $3d
track equ $41
read_func equ $3e
ReadSectorBase equ $c05c
MON_WAIT equ $fca8
IWM_PH0_OFF equ $c080 
IWM_PH0_ON equ $c081
IWM_MOTOR_OFF equ $c088

dseg
address:
    defw 0
count:
    defb 0
trackIndex:
    defb 0
sectorIndex:
    defb 0
currentPhase:
    defb 0
targetPhase:
    defb 0

cseg
    a8
    i8
    defb 1

    lda data_ptr+1
    cmp #9
    if eq
        lda slot_index
        lsr a | lsr a | lsr a | lsr a
        ora #high ReadSectorBase | sta read_func+1
        lda #low ReadSectorBase | sta read_func

        lda #low Entry | sta address
        lda #high Entry | sta address+1

        lda #SectorCount | sta count
        lda #0 | sta trackIndex
        lda #1 | sta sectorIndex
        
        ldx slot_index
        lda IWM_PH0_OFF,x
    endif
    lda count
    if ne
        dec count

        lda sectorIndex
        if eq
            lda track | asl a | sta currentPhase
            lda trackIndex | asl a | sta targetPhase
            do
                lda currentPhase
                cmp targetPhase
            while cc
                inc currentPhase
                lda currentPhase
                and #3
                asl a
                ora slot_index
                tax
                lda IWM_PH0_ON,x
                lda #86 | jsr MON_WAIT
                lda IWM_PH0_OFF,x
            wend
        endif
        lda trackIndex | sta track
        ldx sectorIndex | lda SectorTable,x | sta sector
                        ; lda sectorIndex | sta sector
        lda address | sta data_ptr
        lda address+1 | sta data_ptr+1
        
        inc address+1
        ldx sectorIndex | inx
        cpx #MaxSector
        if cs
            inc trackIndex
            ldx #0
        endif
        stx sectorIndex

        ldx slot_index
        jmp (read_func)
    endif
    ldx slot_index
    lda IWM_MOTOR_OFF,x
jmp Entry

SectorTable:
    defb $00,$0d,$0b,$09,$07,$05,$03,$01,$0e,$0c,$0a,$08,$06,$04,$02,$0f
