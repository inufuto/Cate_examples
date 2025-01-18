include "BinSize.inc"

DefaultSegment equ 0040h

SectorSize equ 1024
SectorCount equ 8
ReadingCount equ (BinSize+SectorSize-1)/SectorSize

cseg
defb 'IPL '
Loader: public Loader
    cli
        mov ax,cs
        mov ds,ax
        mov ss,ax
        mov sp,0
    sti
    
    mov dx,0
    mov cl,ReadingCount
    do
        mov al,[SectorNum] | add al,'0' | call PutC
        push cx
            mov dx,ControlBlock
            call 0fc00h:6
            
            mov al,[SectorNum]
            inc al
            cmp al,SectorCount+1
            if nc
                xor byte ptr [SideNum],1
                if z
                    inc byte ptr [TrackNum]
                endif
                mov al,1
            endif
            mov [SectorNum],al

            mov ax,[TargetAddress]
            add ax,SectorSize
            mov [TargetAddress],ax
        pop cx
        dec cl
    while nz | wend
jmp DefaultSegment:0000h

Command:
    defb 0,0
    defb 03h
    defb 1,0

PutC:
    push ax | push bx | push cx | push dx
        mov [Command+4],al

        mov dx,0fd05h
        do
            in al,dx
            and al,80h
        while nz | wend
        mov al,80h | out dx,al ; hold
        do
            in al,dx
            and al,80h
        while z | wend

        mov dx,0fc80h
        mov bx,Command
        mov cl,5
        do
            mov al,[bx] | inc bx
            out dx,al | inc dx
            dec cl
        while nz | wend

        mov dx,0fd05h
        mov al,00h | out dx,al ; release
    pop dx | pop cx | pop bx | pop ax
ret

ControlBlock:
    ; 0
    defw 3
TargetAddress:
    ; 2
    defw 0
    defw DefaultSegment
TrackNum:
    ; 6
    defb 0
SectorNum:
    ; 7
    defb 2
SideNum:
    defb 0
; ???
    ; 9
    defb 0
    ; 10
    defb 1
