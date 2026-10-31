ext CellMap_

cseg
CellPtr:
    push ax
        shr al,1
        mov bl,dl
        xor bh,bh
        shl bx,1 | shl bx,1 | shl bx,1 ; *8
        xor ah,ah
        add bx,ax
        add bx,CellMap_
    pop ax
ret


; byte GetCell(byte x, byte y);
cseg
GetCell_: public GetCell_
    push bx
        call CellPtr
        test al,1
        mov al,[bx]
        if nz
            shr al,1 | shr al,1 | shr al,1 | shr al,1
        endif
        and al,0fh
    pop bx
ret


; byte SetCell(byte x, byte y, byte cell);
SetCell_: public SetCell_
    push ax | push bx
        call CellPtr
        mov ah,cl
        test al,1
        if nz
            shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
            and ah,0f0h
            mov al,[bx]
            and al,0fh
        else
            and ah,0fh
            mov al,[bx]
            and al,0f0h
        endif
        or al,ah
        mov [bx],al
    pop bx | pop ax
ret
