include "BinSize.inc"

DefaultSegment equ 0060h

SectorSize equ 256
MaxSector equ 16
TrackSize equ SectorSize*MaxSector
TrackCount equ 1+(BinSize-(SectorSize*(MaxSector-2))+TrackSize-1)/TrackSize

cseg ; 1FC0:0000
    mov dx,DefaultSegment | mov es,dx
    mov di,0
    mov dx,3
    mov cx,0100h
    mov bl,TrackCount
    do
        push bx
            mov al,MaxSector+1
            sub al,dl
            mov bh,al
            mov bl,0
            mov bp,di
            mov ah,56h
            mov al,byte ptr [0584h]
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
