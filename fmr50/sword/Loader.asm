include "BinSize.inc"

DefaultSegment equ 0040h

SectorSize equ 1024
SectorCount equ 8
TrackSize equ SectorSize*SectorCount
TrackCount equ (SectorSize+BinSize+TrackSize-1)/TrackSize


cseg
defb 'IPL1'
Loader:
    mov ax,DefaultSegment | mov ds,ax
    mov di,0000h
    xor cx,cx
    mov dx,0002h
    mov al,TrackCount
    do
        push ax
            mov bx,SectorCount+1
            sub bl,dl
            mov ax,0520h
            cli
            call 0fffbh:14h
            
            mov ah,bl
            shl ah,1 | shl ah,1
            xor al,al
            add di,ax

            xor dh,01h
            if z
                inc cx
            endif
            mov dl,1
        pop ax
        dec al
    while nz | wend
jmp DefaultSegment:0000h
