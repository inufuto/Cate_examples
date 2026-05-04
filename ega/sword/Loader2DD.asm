include "BinSize.inc"

DefaultSegment equ 0000h
Entry equ 0500h

SectorSize equ 512
MaxSector equ 9
TrackSize equ SectorSize*MaxSector
SectorCount equ (BinSize+SectorSize-1)/SectorSize+2
TrackCount equ (SectorCount+MaxSector-1)/MaxSector

cseg ; 0000:7C00
    mov ax,DefaultSegment | mov es,ax
    mov bx,Entry ; offset
    mov cx,0002h ; cylinder/sector
    mov dh,00h ; head
    mov al,MaxSector-1 ; function/count
    mov ah,TrackCount
    do
        push ax
            call PrintX
        pop ax
        push ax
            call Read

            mov cl,1 ; sector
            inc dh ; head
            cmp dh,2
            if z
                inc ch ; cylinder
                mov dh,0 ; head
            endif
        pop ax
        mov al,MaxSector
        dec ah
    while nz | wend
    
    mov ax,DefaultSegment | mov ds,ax
jmp DefaultSegment:Entry

Read:
    mov ah,10
    do
        dec ah | jz exit
        push ax
            mov al,'-' | call PrintC
        pop ax
        push ax
            mov ah,2 ; function
            int 13h
            if c
                push ax
                    mov al,ah
                    call PrintX
                pop ax
                call PrintX
                stc
            endif
        pop ax
    while c | wend
    exit:
    push ax
        mov al,'|' | call PrintC
    pop ax
    add cl,5
    shl al,1 | add bh,al
ret

PrintC:
    push ax | push bx
        mov ah,0eh
        mov bx,010fh
        int 10h
    pop bx | pop ax
ret

PrintXC:
    push ax
        cmp al,10
        if c
            add al,'0'
        else
            add al,'A'-10
        endif
        call PrintC
    pop ax
ret

PrintX:
    push ax
        push ax
            shr al,1 | shr al,1 | shr al,1 | shr al,1
            call PrintXC
        pop ax
        and al,0fh
        call PrintXC
    pop ax
ret
