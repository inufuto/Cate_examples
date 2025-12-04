include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight*PlaneCount
SpritePatternSize equ 4*4*16

dseg
pBackup:
	defw 0
CharPatternW: public CharPatternW
	defs CharPatternSize*Char_End
SpritePatternW:
	defs SpritePatternSize*Pattern_End
NextPage:
	defw 0
color:
	defb 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight


cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
    mov ax,VramSegment | mov es,ax
    mov byte ptr[es:0ff82h],07h

    mov dx,0fd98h
    do
        mov al,dl | and al,1fh
        out dx,al
        inc dl
        cmp dl,0a0h
    while nz | wend

    mov bx,8000h
    do
        mov byte ptr [es:bx],00h
        inc bx
        mov byte ptr [es:bx],07h
        inc bx
        cmp bx,9000h
    while nz | wend

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
		mov [bx],ax
		add bx,2
	wloop
ret
ClearScreen_: public ClearScreen_
    push ax | push bx | push dx
        mov ax,VramSegment | mov es,ax

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

		mov word ptr [pBackup],Backup1
		mov byte ptr[NextPage],08h
		mov byte ptr[es:0ff82h],07h
    pop dx | pop bx | pop ax
ret


Put:
; in
;   al: char
;   di: vram address
    push cx | push si
		mov ah,CharPatternSize | mul ah
		add ax,CharPatternW
		mov si,ax

		mov ch,CharHeight
		do
			mov cl,01h
			do
				mov [es:0ff81h],cl
				mov ax,[si] | inc si | inc si
				mov [es:di],al
				mov [es:di+1],ah
				shl cl,1
				cmp cl,08h
			while nz | wend
			add di,VramWidth
			dec ch
		while ne | wend
		add di,2-VramWidth*CharHeight
    pop si | pop cx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax
	    mov byte ptr[es:0ff83h],00h
		mov al,dl
		call Put
		dec di | dec di
	    mov byte ptr[es:0ff83h],08h
		mov al,dl
		call Put
		mov ax,di
	pop di
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
	push bx | push di
		mov di,ax
        mov ax,VramSegment | mov es,ax
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
							_deb: public _deb
		mov bl,al
	    mov byte ptr[es:0ff83h],00h
		call Put
		dec di | dec di
	    mov byte ptr[es:0ff83h],08h
		mov al,bl
		call Put
		mov ax,di
	pop di | pop bx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov ax,VramSegment | mov es,ax
		mov al,[NextPage] | mov byte ptr[es:0ff83h],al

		mov bx,VVram_
		mov si,[pBackup]
		mov di,0
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
	push ax | push bx
		mov ax,VramSegment | mov es,ax

		mov ah,[NextPage]
		or ah,ah
		if z
			mov bx,Backup1
			mov ax,0807h
		else
			mov bx,Backup0
			mov ax,000fh
		endif
		mov [es:0ff82h],al
		mov [pBackup],bx
		mov [NextPage],ah
	pop bx | pop ax
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


; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
	push ax | push cx | push dx | push bx | push si | push di
		call PrepareSprite
		mov ch,8
		do
			mov bx,[si]
			or bx,bx
			if nz
				inc si | inc si
				not bx
				mov dx,0001h
				do
					or dl,dh | mov [es:0ff81h],dl
					mov al,[es:di]
					mov ah,[es:di+1]
					and ax,bx
					or ax,[si] | inc si | inc si
					mov [es:di],al
					mov [es:di+1],ah
					add dh,40h
					shl dl,1
					cmp dl,08h
				while nz | wend
				add si,2*4
			else
				add si,2*8
			endif
			add di,VramWidth
			dec ch
		while nz | wend
    pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret

; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
	push ax | push cx | push dx | push bx | push si | push di
		call PrepareSprite
		mov ch,16
		do
			mov cl,2
			do
				mov bx,[si] | inc si | inc si
				or bx,bx
				if nz
					not bx
					mov dx,0001h
					do
						or dl,dh | mov [es:0ff81h],dl
						mov al,[es:di]
						mov ah,[es:di+1]
						and ax,bx
						or ax,[si] | inc si | inc si
						mov [es:di],al
						mov [es:di+1],ah
						add dh,40h
						shl dl,1
						cmp dl,08h
					while nz | wend
				else
					add si,3*2
				endif
				inc di | inc di
				dec cl
			while nz | wend
			add di,VramWidth-4
			dec ch
		while nz | wend
    pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret

PrepareSprite:
	xchg al,dl
	mov ch,VramWidth*2
	mul ch
	add ax,ax
	
	xor dh,dh
	add ax,dx
	; add ax,VramRowSize
	mov di,ax

	mov ah,cl
	xor al,al
	add ax,SpritePatternW
	mov si,ax

	mov ax,VramSegment | mov es,ax
	mov al,[NextPage] | mov byte ptr[es:0ff83h],al
ret
