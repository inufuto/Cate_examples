include "Vram.inc"
include "Chars.inc"

ext FortDotOffset_, FortCharOffset_
ext FortPattern
ext NextPage

cseg
GroundPattern:
    defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh

; void UpdateFortChars();
cseg
UpdateFortChars_: public UpdateFortChars_
    push ax | push bx | push cx | push dx | push si | push di
                                    _deb: public _deb
        mov ax,PcgSegment | mov es,ax

        mov al,[FortCharOffset_]
        add al,Char_Fort
        mov ah,CharHeight*2 | mul ah
        mov di,ax

        mov dh,[FortDotOffset_] | and dh,7 ; upperCount
        mov dl,CharHeight | sub dl,dh ; lowerCount
        
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
            mov ah,dh
            do
                mov al,[si] | mov [es:di],al
                mov al,[si+CharHeight] | mov [es:di+1000h],al
                mov al,[si+CharHeight*2] | mov [es:di+2000h],al
                inc si
                inc di | inc di
                dec ah
            while nz | wend
        pop si
    endif
    push bx
        mov ah,dl ; lowerCount
        do
            mov al,[bx] | mov [es:di],al
            mov al,[bx+CharHeight] | mov [es:di+1000h],al
            mov al,[bx+CharHeight*2] | mov [es:di+2000h],al
            inc bx
            inc di | inc di
            dec ah
        while nz | wend
    pop bx
    add si,CharHeight*TPlaneCount
    add bx,CharHeight*TPlaneCount
ret


; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push ax | push bx | push cx
        add al,al | add al,al
        mov cl,al | xor ch,ch
        mov al,dl
        add al,16+2
        mov ah,VramRowSize | mul ah
        add ax,cx
        add ax,[NextPage]
        sub ax,VramRowSize*(16+2)
        mov bx,ax

        mov ax,TVramSegment | mov es,ax

        mov ch,7
        mov al,Char_Fort
        add al,[FortCharOffset_]
        mov ah,dl
        do
            cmp ah,VramHeight
            if c
                mov cl,6
                do
                    mov [es:bx],al
                    inc bx | inc bx | inc bx | inc bx
                    inc al
                    dec cl
                while nz | wend
                add bx,VramRowSize-6*VramStep
            else
                add al,6
                add bx,VramRowSize
            endif
            inc ah
            dec ch
        while nz | wend
    pop cx | pop bx | pop ax
ret
