include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext FortDotOffset_
ext VVram_

; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push ax | push bx | push cx
        mov cl,al | xor ch,ch
        mov al,dl
        add al,16+2
        mov ah,VVramWidth | mul ah
        add ax,cx
        add ax,VVram_-VVramWidth*(16+2)
        mov bx,ax

        mov al,[FortDotOffset_]
        or al,al
        if z
            mov ch,6
            mov al,Char_Fort0
        else
            mov ch,7
            mov al,Char_Fort1
        endif
        mov ah,dl

        do
            cmp ah,VVramHeight
            if c
                mov cl,6
                do
                    mov [bx],al | inc bx
                    inc al
                    dec cl
                while nz | wend
                add bx,VVramWidth-6
            else
                add al,6
                add bx,VVramWidth
            endif
            inc ah
            dec ch
        while nz | wend
    pop cx | pop bx | pop ax
ret
