include "BinSize.inc"

DefaultSegment equ 0

SectorSize equ 512
MaxSector equ 9
TrackSize equ SectorSize*MaxSector
TrackCount equ 1+(BinSize-(SectorSize*(MaxSector-2))+TrackSize-1)/TrackSize

cseg ; 0000:7C00
    jmp boot
    defb 0
    defb 'IBMJX   '
    defs 21
boot:
    mov ax,DefaultSegment | mov es,ax
    mov bx,BinTop ; offset
    mov cx,0002h ; cylinder/sector
    mov dx,0040h ; head/drive
    mov al,MaxSector-1 ; function/count
    mov ah,TrackCount
    do
        push ax
            call PrintX
        pop ax
        push ax
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
            shl al,1 | add bh,al
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
jmp DefaultSegment:BinTop

PrintC:
    push ax | push bx
        mov ah,0eh
        mov bl,07h
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
