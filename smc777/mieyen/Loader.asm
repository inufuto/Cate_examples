include "BinSize.inc"

Top equ 0100h
SectorSize equ 256
SectorCount equ (BinSize+SectorSize-1)/SectorSize
SectorPerTrack equ 16
TrackCount equ (SectorCount+SectorPerTrack-1)/SectorPerTrack

Port_Status equ 30h
Port_Command equ Port_Status
Port_Track equ 31h
Port_Sector equ 32h
Port_Data equ 33h
Port_Drive equ 34h
Port_Rq equ Port_Drive

Command_Restore equ 0fh
Command_Seek equ 1fh
Command_Read equ 92h

cseg
    retry:
    di
        xor a | out (Port_Drive),a
        call Wait
        ld a,Command_Restore
        call Command
        
        ld hl,Top
        ld de,0002h
        do
            ld a,d ; track
            out (33h),a
            ; out (Port_Track),a

            call Wait
            ld a,Command_Seek
            call Command

            in a,(Port_Status)
            and 91h
            jr nz,retry

            ld a,e ; sector
            out (Port_Sector),a

            call Read
            
            inc d
            ld e,1

            ld a,d
            cp TrackCount
        while c | wend
    ;ei
jp Top


Wait:
    do
        in a,(Port_Status)
        and 81h
    while nz | wend
ret


Command:
    out (Port_Command),a
    nop
    do
        in a,(Port_Rq)
        rlca
    while nc | wend
ret

Read:
    ld a,Command_Read
    ld c,Port_Rq
    out (Port_Command),a
    nop
    Read_loop:
    in b,(c)
    jr z,Read_done
    ret m
    in b,(c)
    jr nz,Read_loop
    Read_done:
    in a,(Port_Data)
    ld (hl),a | inc hl
    in b,(c)
    jr nz,Read_loop
jr Read_done
