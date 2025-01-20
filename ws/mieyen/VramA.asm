include "ws.inc"
include "Vram.inc"
include "Chars.inc"

ext CharPattern

dseg
CharPalettes: public CharPalettes
    defs Char_End

cseg
PaletteValues:
defb	10h, 75h
defb	00h, 73h
defb	00h, 73h
defb	00h, 73h

defb	00h, 73h
defb	00h, 75h
defb	00h, 73h
defb	00h, 73h

CharPaletteTable:
defb 64, 4 ; Ascii
defb 40, 0 ; BG
defb 88, 4 ; Sprite
defb 0
InitVram: public InitVram
    mov ax,6420h | out REG_PALMONO_POOL_0,ax
    mov ax,0fca8h | out REG_PALMONO_POOL_2,ax

    mov dx,REG_PALMONO_0
    mov ch,2
    do
        mov bx,PaletteValues
        mov cl,8
        do
            mov ax,[cs:bx] | inc bx | inc bx
            out dx,ax | inc dx | inc dx
            dec cl
        while nz | wend
        dec ch
    while nz | wend

    mov si,CharPaletteTable
    mov di,CharPalettes
    do
		mov cl,[cs:si]
		or cl,cl
	while nz
		inc si
		mov ch,[cs:si] | inc si
        add ch,ch
        do
            mov [di],ch | inc di
            dec cl
        while nz | wend
    wend

    cli | push ds
        mov ax,ds | mov es,ax
        mov ax,cs | mov ds,ax
        mov si,CharPattern
        mov di,2000h
        mov cx,CharHeight*Char_End
        do
            movsw
        wloop
    pop ds | sti
ret


; void ClearScreen();
cseg
ClearScreen_:  public ClearScreen_
	push ax | push cx | push bx
        mov ax,0800h
        mov bx,VramBackO
        mov cx,1000h/2
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
    push bx | push dx
        mov bx,CharPalettes
        xor dh,dh
        add bx,dx
        mov dh,[bx]
        mov bx,ax
        mov [bx],dx
    pop dx | pop bx
    inc ax | inc ax
ret


; byte ReadVram(ptr<byte> pVram);
ReadVram_: public ReadVram_
    push bx
        mov bx,ax
        mov al,[bx]
    pop bx
ret
