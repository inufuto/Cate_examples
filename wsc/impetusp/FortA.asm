include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext FortDotOffset_, FortCharOffset_
ext FortPattern

cseg
GroundPattern:
	defb	44h, 44h, 44h, 44h, 4ch, 44h, 44h, 44h
	defb	44h, 44h, 44h, 44h, 44h, 44h, 4ch, 44h
	defb	44h, 44h, 44h, 44h, 4ch, 44h, 44h, 44h
	defb	44h, 44h, 44h, 44h, 44h, 44h, 4ch, 44h
    
; void UpdateFortChars();
cseg
UpdateFortChars_: public UpdateFortChars_
    push ax | push bx | push cx | push dx | push si | push di
        mov al,[FortCharOffset_]
        add al,Char_Fort
        mov ah,PatternSize | mul ah
        add ax,4000h
        mov di,ax

        mov dh,[FortDotOffset_] | and dh,7 | add dh,dh | add dh,dh ; upperCount
        mov dl,PatternSize | sub dl,dh ; lowerCount

        mov bx,FortPattern ; pLowerSource
        mov cl,6
        do
            mov si,GroundPattern ; pUpperSource
            call UpdateC
            dec cl
        while nz | wend

        mov si,FortPattern ; pUpperSource
        mov al,dl | xor ah,ah | add si,ax ; lowerCount
        mov cl,6*5
        do
            call UpdateC
            dec cl
        while nz | wend

        mov cl,6
        do
            mov bx,GroundPattern ; pLowerSource
            mov al,dh | xor ah,ah | add bx,ax ; upperCount
            call UpdateC
            dec cl
        while nz | wend
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
ret
UpdateC:
    or dh,dh ; upperCount
    if nz
        push si
            mov ch,dh | shr ch,1
            do
                mov ax,[cs:si] | inc si | inc si
                mov [di],ax | inc di | inc di
                dec ch
            while nz | wend
        pop si
    endif
    push bx
        mov ch,dl | shr ch,1 ; lowerCount
        do
            mov ax,[cs:bx] | inc bx | inc bx
            mov [di],ax | inc di | inc di
            dec ch
        while nz | wend
    pop bx
    add si,PatternSize
    add bx,PatternSize
ret


; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push ax | push bx | push cx
        mov cl,al | xor ch,ch
        mov al,dl
        add al,8+2
        mov ah,VVramWidth | mul ah
        add ax,cx
        add ax,VVram_-VVramWidth*(8+2)
        mov bx,ax

        mov al,[FortCharOffset_]
        add al,Char_Fort
        mov ah,dl

        mov ch,7
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
