include "BinSize.inc"

DefaultSegment equ 0900h

SectorSize equ 1024
SectorCount equ 8
TrackSize equ SectorSize*SectorCount
TrackCount equ (SectorSize+BinSize+TrackSize-1)/TrackSize

cseg
jmp Loader
Loader:
    ; mov dl,0
    ; mov ah,2
    ; int 51h

    ; xor bl,bl
    ; mov ah,3
    ; int 51h

    mov si,0
    mov di,DefaultSegment*16
    xor al,al ; side
    mov bx,200h ; sector,track?
    mov cx,TrackSize-SectorSize
    do
        mov dx,0200h
        mov ah,4
        int 51h ;8268
        add di,cx
        adc si,0
        xor al,1
        if z
            inc bl
        endif
        mov cx,TrackSize
        mov bh,1
        cmp bl,TrackCount
    while nz | wend

jmp DefaultSegment:0000h
