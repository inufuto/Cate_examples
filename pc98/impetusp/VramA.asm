include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight*PlaneCount
SpritePatternSize equ VramStep*2*CharHeight*2*(1+PlaneCount)

GRCG_Mode equ 7ch
GRCG_Tile equ 7eh

dseg
pNextPage: public pNextPage
	defw 0
pBackup:
	defw 0

CharPatternW: public CharPatternW
	defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
	defs SpritePatternSize*Pattern_End
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
color:
	defb 0

cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
	mov si,MonoPattern
	xor al,al
	mov bx,ColorTable
	do
		mov cl,[bx]
		or cl,cl
	while nz
		inc bx
		mov ch,[bx]
		inc bx
		push ax | push bx | push cx
			call MakePatternMono
		pop cx | pop bx | pop ax
		add al,cl
	wend

	mov si,ColorPattern
	mov di,CharPatternW+CharPatternSize*Char_Color
	mov cx,CharHeight*PlaneCount*(Char_End-Char_Color)
	call MakePatternColor

	mov di,SpritePatternW
	mov si,SpritePattern
	mov cx,SpritePatternSize*Pattern_End
	call MakePatternColor
ret


cseg
DoubleBits:
	push cx
		xor dx,dx
		mov ch,8
		do
			shr dx | shr dx
			shr al,1
			if b
				or dx,0c000h
			endif
			dec ch
		while ne | wend
	pop cx
ret

MakePatternMono:
	mov ah,48 | mul ah
	add ax,CharPatternW
	mov di,ax

	mov [color],ch
	do
		mov ch,CharHeight
		do
			push cx
				mov al,[si] | inc si
				call DoubleBits
				xchg dl,dh
				mov al,[color]
				mov cl,PlaneCount
				do
					xor bx,bx
					test al,01h
					if nz
						or bx,dx
					endif
					test al,10h
					if nz
						not dx
						or bx,dx
						not dx
					endif
					mov [di],bx | inc di | inc di
					shr al,1
					dec cl
				while nz | wend
			pop cx
			dec ch
		while nz | wend
		dec cl
	while nz | wend
ret

MakePatternColor:
	do
		mov al,[si] | inc si
		call DoubleBits
		xchg dl,dh
		mov [di],dx | inc di | inc di
	wloop
ret


; void ClearScreen();
cseg
Clear:
	xor ax,ax
	do
		mov [bx],ax | inc bx | inc bx
	wloop
ret
ClearScreen_:  public ClearScreen_
	push ax | push cx | push dx | push bx
		mov ax,VramSegment | mov es,ax
		mov al,88h | out GRCG_Mode,al

		xor al,al
		mov dl,PlaneCount
		do
			out GRCG_Tile,al
			dec dl
		while ne | wend

		xor ax,ax
		xor bx,bx
		mov cx,8000h
		do
			mov es:[bx],ax
			inc bx | inc bx
		wloop
		xor al,al | out GRCG_Mode,al

		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		call Clear

		; mov bx,VVram_
		; mov cx,VVramWidth*VVramHeight/2
		; call Clear

		mov word ptr [pBackup],Backup1
		mov word ptr [pNextPage],Vram1
        mov ch,80h
        mov ah,42h
        int 18h
	pop bx | pop dx | pop cx | pop ax
ret


cseg
Put:
; in
;   al: char
;   di: vram address
    push cx
		mov ah,CharPatternSize | mul ah
		add ax,CharPatternW
		mov si,ax

		mov ax,VramSegment | mov es,ax
		mov cl,CharHeight
		do
			mov al,88h | out GRCG_Mode,al
			mov ch,PlaneCount
			do
				mov al,[si] | inc si | inc si
				out GRCG_Tile,al
				dec ch
			while nz | wend
			mov es:[di],al | inc di
			add si,1-2*PlaneCount
			mov al,88h | out GRCG_Mode,al
			mov ch,PlaneCount
			do
				mov al,[si] | inc si | inc si
				out GRCG_Tile,al
				dec ch
			while nz | wend
			mov es:[di],al
			dec si
			add di,VramWidth-1
			dec cl
		while nz | wend
		xor al,al | out GRCG_Mode,al
        add di,2-VramWidth*CharHeight
    pop cx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push si | push di
	    mov di,ax
		mov al,dl
		call Put
		mov al,dl
		add di,Vram1-Vram0-2
		call Put
		add di,Vram0-Vram1
		mov ax,di
	pop di | pop si
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
	push bx | push di
		mov di,ax
		mov bx,CharTable
		mov ax,30 shl 8
		do
			cmp dl,[bx]
			jz PrintC_break
			inc bx
			inc al
			dec ah
		while nz | wend
		xor al,al
		PrintC_break:
		mov bl,al
		call Put
		mov al,bl
		add di,Vram1-Vram0-2
		call Put
		add di,Vram0-Vram1
		mov ax,di
	pop di | pop bx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov di,[pNextPage]
		mov ch, VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					push si
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


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
	push ax | push cx
		mov ax,[pNextPage]
		cmp ax,Vram0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [pNextPage],Vram1
			mov ch,80h
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [pNextPage],Vram0
			mov ch,40h
		endif
		mov ah,42h
		int 18h
	pop cx | pop ax
ret


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
	push ax | push dx | push cx | push bx
		mov cx,0202h
		test al,1
		if nz
			inc ch
		endif
		shr al,1
		mov bl,al
		xor bh,bh
		
		test dl,1
		if nz
			inc cl
		endif
		shr dl,1

		mov al,VVramWidth
		mul dl
		add ax,bx
		add ax,Backup0
		mov bx,ax

		mov al,0ffh
		do
			push bx
				mov ah,ch
				do
					mov [bx],al
					mov [bx+Backup1-Backup0],al
					inc bx
					dec ah
				while nz | wend
			pop bx
			add bx,VVramWidth
			dec cl
		while nz | wend
 	pop bx | pop cx | pop dx | pop ax
ret


cseg
PrepareSprite:
	xchg al,dl ; dl := x
	mov ch,VramWidth
	mul ch
	shl ax,1 | shl ax,1
	
	xor dh,dh
	add ax,dx
	add ax,[pNextPage]
	mov di,ax

	mov ah,cl
	xor al,al
	add ax,SpritePatternW
	mov si,ax

	mov ax,VramSegment | mov es,ax
ret

; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
	push ax | push cx | push dx | push bx | push si | push di
		call PrepareSprite
		mov cl,8
		do
			mov bh,[si] | inc si | inc si
			mov al,0c8h | out GRCG_Mode,al
			mov ah,PlaneCount
			do
				mov al,[si] | inc si | inc si
				out GRCG_Tile,al
				dec ah
			while nz | wend
			mov es:[di],bh | inc di
			add si,1-2*(PlaneCount+1)

			mov bh,[si] | inc si | inc si
			mov al,0c8h | out GRCG_Mode,al
			mov ah,PlaneCount
			do
				mov al,[si] | inc si | inc si
				out GRCG_Tile,al
				dec ah
			while nz | wend
			mov es:[di],bh
			add di,VramWidth-1
			add si,2*(PlaneCount+1)-1

			dec cl
		while nz | wend
		xor al,al | out GRCG_Mode,al
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret

; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
	push ax | push cx | push dx | push bx | push si | push di
		call PrepareSprite
		mov cl,16
		do
			mov ch,2
			do
				mov bh,[si] | inc si | inc si
				mov al,0c8h | out GRCG_Mode,al
				mov ah,PlaneCount
				do
					mov al,[si] | inc si | inc si
					out GRCG_Tile,al
					dec ah
				while nz | wend
				mov es:[di],bh | inc di
				add si,1-2*(PlaneCount+1)

				mov bh,[si] | inc si | inc si
				mov al,0c8h | out GRCG_Mode,al
				mov ah,PlaneCount
				do
					mov al,[si] | inc si | inc si
					out GRCG_Tile,al
					dec ah
				while nz | wend
				mov es:[di],bh | inc di
				dec si
				dec ch
			while nz | wend
			add di,VramWidth-4

			dec cl
		while nz | wend
		xor al,al | out GRCG_Mode,al
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret
