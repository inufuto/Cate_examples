include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Background_, DotOffset_

TileWidth equ 2
BackgroundWidth equ VVramWidth+TileWidth

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push dx
        mov dh,al
        mov al,VVramWidth
        mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,VVram_
    pop dx
ret


; extern void BackgroundToVVram();
cseg
BackgroundToVVram_: public BackgroundToVVram_
	push ax | push cx | push si | push di
		mov si,Background_
		mov di,VVram_
        mov ah,[DotOffset_]
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[si] | inc si
                cmp al,Char_GroundUp
                if nc
                    add al,ah
                endif
                mov [di],al | inc di
				dec cl
			while nz | wend
            add si,BackgroundWidth-VVramWidth
			dec ch
		while nz | wend
	pop di | pop si | pop cx | pop ax
ret