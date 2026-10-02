include "VVram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 16
FloorCount equ 6
ColumnWidth equ 2
FloorHeight equ 4
RowHeight equ FloorHeight/2

; ptr<byte> MapPtr(byte column, byte floor);
cseg
MapPtr_: public MapPtr_
    push dx
        xor dh,dh
        shl dl,1 | shl dl,1 | shl dl,1 | shl dl,1
        xor ah,ah
        add ax,dx
        add ax,StageMap_
    pop dx
ret


CellChars:
    defb Char_Space,Char_Space,Char_Space,Char_Space
    defb Char_Floor,Char_Floor,Char_Space,Char_Space
    defb Char_Ladder,Char_Ladder+1,Char_Ladder,Char_Ladder+1
    defb Char_Bomb,Char_Bomb+1,Char_Bomb+2,Char_Bomb+3
    defb Char_Flag_A,Char_Flag_A+1,Char_Flag_A+2,Char_Flag_A+3
    defb Char_Flag_B,Char_Flag_B+1,Char_Flag_B+2,Char_Flag_B+3
    defb Char_Flag_C,Char_Flag_C+1,Char_Flag_C+2,Char_Flag_C+3
    defb Char_Flag_D,Char_Flag_D+1,Char_Flag_D+2,Char_Flag_D+3

; void DrawFloor(ptr<byte> pVVram, ptr<byte> pMap);
cseg
DrawFloor_: public DrawFloor_
    push ax | push bx | push cx | push si | push di
        mov di,ax
        mov bx,dx
        mov ch,ColumnCount
        call DrawColumns
    pop di | pop si | pop cx | pop bx | pop ax
ret

; void DrawFloorShift(ptr<byte> pVVram, ptr<byte> pMap);
cseg
DrawFloorShift_: public DrawFloorShift_
    push ax | push bx | push cx | push si | push di
        mov di,ax
        mov bx,dx

        mov al,[bx] | inc bx
        push ax
            push ax
                shr al,1 | shr al,1 | shr al,1 | shr al,1
                call DrawCellRight
            pop ax
            call DrawCellRight
            add di,ColumnWidth/2-VVramWidth*FloorHeight
            mov ch,ColumnCount-1
            call DrawColumns
        pop ax
        push ax
            shr al,1 | shr al,1 | shr al,1 | shr al,1
            call DrawCellLeft
        pop ax
        call DrawCellLeft
    pop di | pop si | pop cx | pop bx | pop ax
ret

CharsPtr:
    and al,7
    xor ah,ah
    shl al,1 | shl al,1
    add ax,CellChars
    mov si,ax
ret
DrawColumns:
    do
        mov al,[bx] | inc bx
        push ax
            shr al,1 | shr al,1 | shr al,1 | shr al,1
            call DrawCell
        pop ax
        call DrawCell
        add di,ColumnWidth-VVramWidth*FloorHeight
        dec ch
    while nz | wend
ret
DrawCell: ;(di, al)
    call CharsPtr ;->bx
    mov cl,RowHeight
    do
        mov ah,ColumnWidth
        do
            mov al,[si] | inc si
            mov [di],al | inc di
            dec ah
        while nz | wend
        add di,VVramWidth-ColumnWidth
        dec cl
    while nz | wend
ret
DrawCellRight:;(di, al)
    call CharsPtr ;->bx
    mov cl,RowHeight
    do
        inc si
        mov al,[si] | inc si
        mov [di],al
        add di,VVramWidth
        dec cl
    while nz | wend
ret
DrawCellLeft:;(di, al)
    call CharsPtr ;->bx
    mov cl,RowHeight
    do
        mov al,[si] | inc si
        inc si
        mov [di],al
        add di,VVramWidth
        dec cl
    while nz | wend
ret


; void RollRight(ptr<byte> pMap);
cseg
RollRight_: public RollRight_
    push ax | push bx
        mov bx,ax
        mov al,[bx+ColumnCount-1]
        push ax
            mov ah,ColumnCount-1
            do
                mov al,[bx+ColumnCount-1-1]
                mov [bx+ColumnCount-1],al
                dec bx
                dec ah
            while nz | wend
        pop ax
        mov [bx+ColumnCount-1],al
    pop bx | pop ax
ret


; void RollLeft(ptr<byte> pMap);
cseg
RollLeft_: public RollLeft_
    push ax | push bx
        mov bx,ax
        mov al,[bx]
        push ax
            mov ah,ColumnCount-1
            do
                mov al,[bx+1]
                mov [bx],al
                inc bx
                dec ah
            while nz | wend
        pop ax
        mov [bx],al
    pop bx | pop ax
ret
