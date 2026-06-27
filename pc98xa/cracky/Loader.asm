include "BinSize.inc"

DefaultSegment equ 0060h

SectorSize equ 1024
MaxSector equ 8
TrackSize equ SectorSize*MaxSector
TrackCount equ 1+(BinSize-(SectorSize*(MaxSector-2))+TrackSize-1)/TrackSize

cseg ; 1FC0:0000
    mov dx,DefaultSegment | mov es,dx
    mov di,0
    mov dx,2
    mov cx,0300h
    mov bl,TrackCount
    do
        push bx
            push ax
                mov al,MaxSector+1
                sub al,dl
                mov bh,al
                mov bl,0
                add bx,bx | add bx,bx
                mov bp,di
            pop ax
            mov ah,56h
            int 1bh

            mov dl,1
            inc dh
            cmp dh,2
            if e
                inc cl
                mov dh,0
            endif
            add di,bx
        pop bx
        dec bl
    while ne
    wend
    mov ax,DefaultSegment | mov ds,ax
    jmp DefaultSegment:0000h
