include "BinSize.inc"

SectorSize equ 256
SectorCount equ (BinSize+SectorSize-1)/SectorSize
SectorPerTrack equ 16
TrackCount equ (SectorCount+SectorPerTrack-1)/SectorPerTrack

dseg
Buffer:
    defs SectorSize*SectorPerTrack
Drive:
    defb 0
Address:
    defw 0
cseg
    di
    ld (Drive),a

    ld hl,BinTop | ld (Address),hl
    ld de,0102h
    ld bc,SectorCount+(SectorPerTrack-1)*100h
    do
        push de
            push bc
                call ToRom
                ld a,(Drive)
                ld hl,Buffer
                ld c,12h | call 41f9h
                ld c,13h | call 41f9h
                _deb: public _deb
                ld a,'-' | call PutC
                call ToRam
            pop bc
            push bc
                call ToRam
                ld de,(Address)
                ld c,0
                ldir
                ld (Address),de
            pop bc
        pop de
        
        ld a,(Drive)
        xor 80h
        ld (Drive),a
        and 80h
        if z
            inc d
        endif
        
        ld e,1
        
        ld a,c | sub b | ld c,a
        ld b,SectorPerTrack
    while nc | wend
    
    call ToRom
        ld bc,2*256 + 36
        call 5
        ld bc,40*256 + 35
        call 5
        ld bc,0fh*256 + 37
        call 5
        ld bc,3*256 + 50
        call 5
    call ToRam
jp BinTop

PutC:
    push bc
        call ToRom
        ld b,a | ld c,49
        call 5
        call ToRam
    pop bc
ret

ToRam:
    push af
        in a,(22h)
        and 02h
        or 02h
        out (3ch),a
    pop af
ret

ToRom:
    push af
        in a,(22h)
        and 01h
        or 01h
        out (3ch),a
    pop af
ret