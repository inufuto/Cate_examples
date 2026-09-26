include "VVram.inc"

ext StageMap_

ColumnCount equ 16

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    push dx
        mov dh,al
        mov al,ColumnCount/2
        mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,StageMap_
    pop dx
ret


cseg
MapPtr: ;(al, dl)->bx
    mov ah,al
    shr ah,1
    mov bl,dl
    shl bl,1 | shl bl,1 | shl bl,1
    add bl,ah
    xor bh,bh
    add bx,StageMap_
    and al,1
ret

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push ax | push bx | push cx
        call MapPtr
        if nz
            mov al,[bx]
            and al,0fh
            shl cl,1 | shl cl,1 | shl cl,1 | shl cl,1
        else
            mov al,[bx]
            and al,0f0h
            and cl,0fh
        endif
        or al,cl
        mov [bx],al
    pop cx | pop bx | pop ax
ret


; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push bx
        call MapPtr
        if nz
            mov al,[bx]
            shr al,1 | shr al,1 | shr al,1 | shr al,1
        else
            mov al,[bx]
            and al,0fh
        endif
    pop bx
ret
