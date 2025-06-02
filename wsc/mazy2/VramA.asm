include "wsc.inc"
include "Vram.inc"
include "Chars.inc"

ext CharPattern

cseg
PaletteValues:
	defb	00h, 00h, 3dh, 05h, 00h, 0fh, 9dh, 0fh
	defb	0f0h, 00h, 9fh, 03h, 0f0h, 0fh, 0ffh, 0fh
	defb	00h, 00h, 77h, 07h, 53h, 09h, 77h, 0dh
	defb	70h, 00h, 59h, 00h, 0b9h, 0dh, 0bbh, 0bh
InitVram: public InitVram
    cli | push ds
        mov ax,ds | mov es,ax
        mov ax,cs | mov ds,ax
        mov di,0fe00h
        mov bl,16
        do
            mov si,PaletteValues
            mov cx,16
            do
                movsw
            wloop
            dec bl
        while nz | wend

        mov si,CharPattern
        mov di,4000h
        mov cx,CharHeight*4*Char_End
        do
            movsw
        wloop
    pop ds | sti
ret


; void ClearScreen();
cseg
ClearScreen_:  public ClearScreen_
	push ax | push cx | push bx
        xor ax,ax
        mov bx,VramBackO
        mov cx,32*32*2
        do
            mov [bx],ax | inc bx | inc bx
        wloop
    pop bx | pop cx | pop ax
ret


; word VramOffset(byte x, byte y);
cseg
VramOffset_: public VramOffset_
    push dx
        mov dh,al
            mov al,32
            mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,ax
    pop dx
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push bx
        mov bx,ax
        mov [bx],dl
    pop bx
    inc ax | inc ax
ret
