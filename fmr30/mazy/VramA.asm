include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern
ext VVram_

CharPatternSize equ VramStep*CharHeight

dseg
CharPatternW: public CharPatternW
    defs CharPatternSize*Char_End
Backup:
	defs VVramWidth*VVramHeight


cseg
InitVram: public InitVram
    mov dx,308h
    mov ax,0071h
    out dx,ax

	mov dx,308h+1
	xor al,al | out dx,al

	mov si,CharPattern
	mov di,CharPatternW
	mov cx,CharHeight*Char_End
	do
		mov al,[si] | inc si
		call MakeDouble
		mov [di],dx
		inc di | inc di
	wloop
ret

MakeDouble:
	xor dx,dx
	mov bl,8
	do
		shr dx | shr dx
		shr al,1
		if b
			or dx,0c000h
		endif
		dec bl
	while ne | wend
	xchg dl,dh
ret


; void ClearScreen();
cseg
ClearVram:
    xor bx,bx
    mov cx,8000h/2
	xor ax,ax
	do
		mov [es:bx],ax
		inc bx | inc bx
	wloop
ret
   
Clear:
	xor ax,ax
	do
		mov [bx],ax
		inc bx | inc bx
	wloop
ret
ClearScreen_: public ClearScreen_
    push ax | push bx | push cx | push dx
        mov ax,VramSegment | mov es,ax

        mov dx,308h+1
        xor al,al | out dx,al
        call ClearVram

		mov byte ptr[es:0ff81h],07h ; update
        xor ax,ax
		do
			mov [es:0ff83h],ah
			xor bx,bx
			do
				mov [es:bx],al
				inc bx
				cmp bh,40h
			while nz | wend
			xor ah,08h
		while nz | wend

		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		call Clear

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
		call Clear
    pop dx | pop cx | pop bx | pop ax
ret


cseg
Put:
;   es:di: vram
;   si: pPattern
    push cx
		mov ch,CharHeight
		do
			mov ax,[si] | inc si | inc si
			mov [es:di],ax
			add di,VramWidth
			mov [es:di],ax
			add di,VramWidth
			dec ch
		while ne | wend
        add di,VramStep-VramRowSize
    pop cx
ret


; void Put(word vram, byte c);
cseg
Put_: public Put_
	push dx | push si | push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax
        mov al,CharPatternSize | mul dl
		add ax,CharPatternW
        mov si,ax

        call Put
    	mov ax,di
	pop di | pop si | pop dx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov ax,VramSegment | mov es,ax

		mov bx,VVram_
		mov si,Backup
		mov di,0+VramRowSize*0 ; Top
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					push si
						mov ah,CharPatternSize | mul ah
						add ax,CharPatternW
						mov si,ax
						call Put
					pop si
				else
					inc di | inc di
				endif
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-VVramWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret 
