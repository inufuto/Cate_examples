include "ws.inc"
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
defb	10h, 75h
defb	00h, 73h
defb	00h, 73h
defb	00h, 73h

defb	10h, 75h
defb	00h, 73h
defb	00h, 73h
defb	00h, 73h

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

    cli | push ds
        mov ax,ds | mov es,ax
        mov ax,cs | mov ds,ax

        mov si,CharPattern
        mov di,2000h
        mov cx,PatternSize*Char_End/2
        do
            movsw
        wloop

        mov si,SpritePattern
        mov di,3000h
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
        mov ax,0800h
        mov bx,VramBackO
        mov cx,1000h/2
        do
            mov [bx],ax | inc bx | inc bx
        wloop

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
