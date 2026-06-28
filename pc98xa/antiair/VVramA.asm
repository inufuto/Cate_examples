include "VVram.inc"
include "Vram.inc"
include "Chars.inc"

ext VVram_
ext Ground_

Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    push ax | push cx | push si | push di
        mov ax,ds | mov es,ax
        mov di,VVram_
        xor ax,ax
        mov cx,VVramWidth*20/2
        do
            stosw
        wloop

        mov si,Ground_
        mov cl,VVramWidth
        do
            mov al,[si] | inc si
            mov ah,al
            and al,Ground_BombMask
            if nz
                shr al,1 | shr al,1
                dec al
                add al,Char_BlockC
                jmp DrawBackground_write
            endif
            mov al,ah | and al,Ground_BlockMask
            if nz
                dec al
                add al,Char_BlockA
                DrawBackground_write:
                mov [di],al
                inc al | inc al
                mov [di+VVramWidth],al
            else
                xor al,al
                mov [di],al
                mov [di+VVramWidth],al
            endif
            inc di
            dec cl
        while nz | wend
    pop di | pop si | pop cx | pop ax
ret
