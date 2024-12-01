include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern
ext VVram_

VramTop equ Vram+VramRowSize*0

dseg
Backup:
	defs VVramWidth*VVramHeight


cseg
InitVram: public InitVram
ret

; void ClearScreen();
cseg
ClearScreen_:  public ClearScreen_
	push ax | push cx | push dx | push bx
		mov ax,VramSegment | mov es,ax
		xor ax,ax
		xor bx,bx
		mov cx,8000h/2
		do
			mov es:[bx],ax
			add bx,2
		wloop

		xor ax,ax
		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax
			add bx,2
		wloop
	pop bx | pop dx | pop cx | pop ax
ret


cseg
Put:
; in
;   ax: pPattern
;   es:di: vram address
    push cx | push si
		mov si,ax
		mov ch,CharHeight
		do
			mov al,[si] | inc si
			mov [es:di],al
			add di,VramWidth
			dec ch
		while ne | wend
    pop si | pop cx
ret


; void Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax
        mov al,CharHeight | mul dl
		add ax,CharPattern
        call Put
	pop di | pop ax
	inc ax
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
        mov ax,VramSegment | mov es,ax
        mov bx,VVram_
		mov si,Backup
		mov di,Vram+VramTop
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[bx] | inc bx
				cmp al,[si]
				if ne
					mov [si],al
					mov ah,CharHeight | mul ah
					add ax,CharPattern
					call Put
					add di,-VramWidth*CharHeight*VramStep
				endif
				inc di
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-VVramWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret
