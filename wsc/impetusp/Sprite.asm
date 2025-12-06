include "wsc.inc"
include "Vram.inc"
include "Chars.inc"

Sprite_End equ 29
_y equ 0
_x equ 1
_pattern equ 2
unitSize equ 3
InvalidPattern equ 0ffh
Left equ VramX*8-1
Top equ VramY*8+CharHeight*0

dseg
Sprites: public Sprites
    defs unitSize*Sprite_End
FirstIndex:
    defs 1
FirstAddress:
    defs 2


cseg
InitSprites: public InitSprites
    push ax
        xor al,al | out REG_SPR_FIRST,al
        mov al,Sprite_End*4 | out REG_SPR_COUNT,al
    pop ax
jmp HideAllSprites_


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public ShowSprite_
	push ax | push di
		mov al,[bx+2] ; index
        mov ah,unitSize
        mul ah
        add ax,Sprites
        mov di,ax

		mov al,[bx+0] ; x
        add al,Left
        mov [di+_x],al

		mov al,[bx+1] ; y
        add al,Top
        mov [di+_y],al

        mov al,dl
        add al,al
        add al,al
        mov [di+_pattern],al ; pattern
	pop di | pop ax
ret


; void ShowSpriteXY(byte index, byte x, byte y, byte pattern);
dseg
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
    defb 0
cseg
ShowSpriteXY_: public ShowSpriteXY_
    push ax | push di
        mov ah,unitSize
        mul ah
        add ax,Sprites
        mov di,ax

		mov al,dl ; x
        add al,Left
        mov [di+_x],al

		mov al,cl ; y
        add al,Top
        mov [di+_y],al

        mov al,[ShowSpriteXY_@Param3]
        add al,al
        add al,al
        mov [di+_pattern],al ; pattern
	pop di | pop ax
ret


; void HideSprite(byte sprite);
cseg
HideSprite_: public HideSprite_
	push ax | push bx
        mov ah,unitSize
        mul ah
        add ax,Sprites
        mov bx,ax
        mov byte ptr[bx+_pattern],InvalidPattern
	pop bx | pop ax
ret


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
	push ax | push bx | push cx
        mov bx,Sprites
        mov al,InvalidPattern
        mov cl,Sprite_End
        do
            mov [bx+_pattern],al
            add bx,unitSize
            dec cl
        while nz | wend
        mov byte ptr [FirstIndex],0
        mov word ptr [FirstAddress],Sprites
	pop cx | pop bx | pop ax
ret


cseg
next:
    add si,unitSize
    inc ch
    cmp ch,Sprite_End
    if nc
        mov si,Sprites
        xor ch,ch
    endif
ret
UpdateSprites: public UpdateSprites
    push ax | push bx | push cx | push dx | push si | push di
        mov ah,11h
        mov di,0e00h
        mov si,[FirstAddress]
        mov ch,[FirstIndex]
        mov cl,Sprite_End
        do
            mov al,[si+_pattern]
            cmp al,InvalidPattern
            if ne
                mov bx,[si+_y]
                mov dh,2
                do
                    mov dl,2
                    do
                        mov [di+0],ax
                        mov [di+2],bx
                        add di,4
                        inc al
                        add bh,8
                        dec dl
                    while nz | wend
                    sub bh,8*2
                    add bl,8
                    dec dh
                while nz | wend
            endif
            call next
            dec cl
        while nz | wend
        
        mov bx,200
        do
            cmp di,0e00h+4*4*Sprite_End
        while nz
            mov [di+2],bx
            add di,4
        wend

        mov si,[FirstAddress]
        mov ch,[FirstIndex]
        call next
        mov [FirstAddress],si
        mov [FirstIndex],ch
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
ret
