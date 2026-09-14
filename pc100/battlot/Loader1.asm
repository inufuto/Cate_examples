include "Loader.inc"

ext ReadDisk

TargetSegment equ 0f00h

cseg
    xor ax,ax | mov ds,ax
    mov ax,1800h
    mov [3feh],ax
    mov ds,ax

    mov al,1 | out 38h,al
    mov al,72h | out 3ah,al

    mov ax,TargetSegment | mov es,ax
    xor di,di
    xor ch,ch ; head
    mov dx,0200h ; sector,track
    call ReadDisk
defb 0eah ; jmp far
defw 0,TargetSegment
