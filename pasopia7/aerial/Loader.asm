include "BinSize.inc"

SectorSize equ 256
SectorCount equ (BinSize+SectorSize-1)/SectorSize
SectorPerTrack equ 16
TrackCount equ (SectorCount+SectorPerTrack-1)/SectorPerTrack

dseg
Drive:
    defb 0
cseg
Loader:
    di
    ld hl,0d000h
    ld de,Loader
    ld bc,100h
    ldir
    jp LoaderTop
LoaderTop:
    ld (Drive),a

    ld hl,BinTop
    ld de,0102h
    ld bc,SectorCount+(SectorPerTrack-1)*100h
    do
        push bc
            ld a,(Drive)
            ld c,12h | call 41f9h
            ld c,13h | call 41f9h
            ld a,'-' | call PutC
        pop bc
        ld a,h | add a,b | ld h,a
        
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
    
    ; ld bc,2*256 + 36
    ; call 5
    ; ld bc,40*256 + 35
    ; call 5
    ; ld bc,0fh*256 + 37
    ; call 5
    ; ld bc,3*256 + 50
    ; call 5
    ei
jp BinTop

PutC:
    push bc
        ld b,a | ld c,49
        call 5
    pop bc
ret
