include "Vram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 16
RowCount equ 11

cseg
MapPtr:
    mov ah,al
    shr ah,1 | shr ah,1
    mov bl,dl
    shl bl,1 | shl bl,1
    add bl,ah
    xor bh,bh
    add bx,StageMap_
ret


; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push ax | push bx | push cx
        call MapPtr
        mov ch,0fch
        and al,3
        if nz
            do
                shl cl,1 | shl cl,1
                rol ch,1 | rol ch,1
                dec al
            while nz | wend
        endif
        mov al,[bx]
        and al,ch
        or al,cl
        mov [bx],al
    pop cx | pop bx | pop ax
ret


; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push bx
        push ax
            call MapPtr
            mov bl,[bx]
            and al,3
            if nz
                do
                    shr bl,1 | shr bl,1
                    dec al
                while nz | wend
            endif
        pop ax
        mov al,bl
        and al,3
    pop bx
ret
