include "wsc.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext VVram_

TerrainCharCount equ Char_Terrain1-Char_Terrain0

dseg
TerrainCharOffset: public TerrainCharOffset
    defb 0

cseg
PaletteValues:
	defb	00h, 00h, 0fh, 00h, 00h, 0fh, 0fh, 0fh
	defb	0f0h, 00h, 0ffh, 00h, 0f0h, 0fh, 0ffh, 0fh
	defb	00h, 00h, 0ah, 00h, 00h, 0ah, 50h, 00h
	defb	0a0h, 00h, 0afh, 00h, 0a0h, 0fh, 0aah, 0ah
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
        mov cx,PatternSize*Char_End
        do
            movsw
        wloop

        mov si,SpritePattern
        mov di,6000h
        mov cx,PatternSize*4*Pattern_End
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

                            _deb: public _deb
        mov byte ptr[TerrainCharOffset],TerrainCharCount
    pop bx | pop cx | pop ax
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


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
	push bx
		push ax
            mov bx,CharTable
            mov ax,29 shl 8
            do
                cmp dl,[cs:bx]
                jz PrintC_break
                inc bx
                inc al
                dec ah
            while nz | wend
            xor al,al
            PrintC_break:
        pop bx
        mov [bx],al
		mov ax,bx
	pop bx
    inc ax | inc ax
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push ax | push cx | push si | push dx
        mov ax,ds | mov es,ax
        mov si,VVram_
        mov di,VramBack
        xor ah,ah
        mov ch,VVramHeight
        do
            mov cl,VVramWidth
            do
                mov al,[si] | inc si
                mov [di],ax | inc di | inc di
                dec cl
            while nz | wend
            add di,VramRowSize-VVramWidth*2
            dec ch
        while nz | wend

        mov al,[TerrainCharOffset]
        xor al,TerrainCharCount
        mov [TerrainCharOffset],al
    pop di | pop si | pop cx | pop ax
ret
