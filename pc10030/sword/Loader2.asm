include "Loader.inc"
include "BinSize.inc"

ext ReadDisk
ext SendCommand,ReceiveResult

TargetSegment equ 0040h

AllTrackCount equ (BinSize+TrackSize+SectorSize*3)/TrackSize

cseg
    xor ax,ax | mov ds,ax
    mov ax,1800h
    mov [3feh],ax
    mov ds,ax

    mov ax,TargetSegment | mov es,ax
    xor di,di
    xor ch,ch ; head
    mov dx,0400h ; sector,track
    mov bx,AllTrackCount or (1 shl 8)
    do
        call ReadDisk
        mov dh,1
        inc ch
        cmp ch,2
        if nc
            xor ch,ch
            inc dl
            call Seek
        endif
        dec bl
    while nz | wend
    call Recalibrate
defb 0eah ; jmp far
defw 0,TargetSegment

Seek:
    push cx | push dx
        mov byte ptr[19eh],0fh
        mov [1a0h],dl
        mov bp,3
        call SendCommand
        call ReceiveResult
    pop dx | pop cx
ret

Recalibrate:
    push cx | push dx
        mov byte ptr[19eh],07h
        mov bp,2
        call SendCommand
        call ReceiveResult
    pop dx | pop cx
ret
