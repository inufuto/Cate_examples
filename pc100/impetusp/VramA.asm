include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ 2*2*CharHeight*4

dseg
nextSegment:
    defw 0
pBackup:
	defw 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
	defs VVramWidth
CharPatternW:
	defs CharPatternSize*Char_End
SpritePatternW:
	defs SpritePatternSize*Pattern_End

cseg
InitVram: public InitVram
    xor al,al 
    out 60h,al | out 61h,al ; mono mode
    out 30h,al ; shift

	mov di,CharPatternW
	mov si,CharPattern
	mov cx,CharPatternSize/2*Char_End
	do
		mov al,[si] | inc si
		call DoubleBits
		mov [di],dx
		inc di | inc di
	wloop

	mov di,SpritePatternW
	mov si,SpritePattern
	mov cx,64*Pattern_End
	do
		mov al,[si] | inc si
		call DoubleBits
		mov [di],dx
		inc di | inc di
	wloop
ret

DoubleBits:
	push cx
		xor dx,dx
		mov ch,8
		do
			shl dx | shl dx
			shr al,1
			if b
				or dx,0003h
			endif
			dec ch
		while ne | wend
	pop cx
ret


; void ClearScreen();
cseg
ClearScreen_:  public ClearScreen_
	push ax | push bx | push cx
        mov ax,VramSegment0 | mov es,ax
        do
            xor ax,ax
            xor bx,bx
            do
				mov es:[bx],ax | inc bx | inc bx
            while nz | wend
			mov ax,es
			add ah,10h
			mov es,ax
            cmp ah,(high VramSegment1)+10h
        while nz | wend

		xor ax,ax 
		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax | inc bx | inc bx
		wloop

		xor ax,ax 
		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax | inc bx | inc bx
		wloop

		mov word ptr [pBackup],Backup1
		mov word ptr [nextSegment],VramSegment1
		mov al,0ffh | out 3eh,al
	pop cx | pop bx | pop ax
ret


cseg
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
            mov ax,[si] | inc si | inc si
            mov es:[di],ax
            add di,VramWidth
            mov es:[di],ax
            add di,VramWidth
            dec ch
        while ne | wend
        add di,VramStep-VramRowSize
    pop si | pop cx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push di
        mov di,ax
        mov ax,VramSegment0 | mov es,ax
        mov al,dl
        call Put
		dec di | dec di
        mov ax,VramSegment1 | mov es,ax
        mov al,dl
		call Put
		mov ax,di
	pop di
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACDEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
	push bx | push di
		mov di,ax
		mov bx,CharTable
		mov ax,31 shl 8
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
        mov ax,VramSegment0 | mov es,ax
        mov al,bl
        call Put
		dec di | dec di
        mov ax,VramSegment1 | mov es,ax
        mov al,bl
		call Put
		mov ax,di
	pop di | pop bx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov di,Vram
		mov ax,[nextSegment] | mov es,ax
		mov ch, VVramHeight ; vertical count
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					call Put
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
	push ax
		mov ah,[nextSegment+1]
		cmp ah,high VramSegment0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [nextSegment],VramSegment1
			mov al,0ffh
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [nextSegment],VramSegment0
			mov al,0ffh xor 02h
		endif
		out 3eh,al
	pop ax
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
	mov ch,al ;x
	mov ah,dl
	shl ah,1 | shl ah,1
	add ax,Vram
	mov di,ax

	mov ax,[nextSegment] | mov es,ax

	mov ah,cl
	xor al,al
	shr ax,1
	add ax,SpritePatternW
	mov si,ax
ret

; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
	push ax | push cx | push si | push di
		call PrepareSprite
		and ch,1
		if z
			mov cl,8
			do
				mov ax,[si] | inc si | inc si
				not ax
				out 1ah,al ; mask low
				mov al,ah | out 18h,al ; mask high
				mov ax,[si] | add si,6
				mov [es:di],ax
				add di,VramWidth
				mov [es:di],ax
				add di,VramWidth
				dec cl
			while nz | wend
		else
			mov cl,8
			do
				mov ax,[si] | inc si | inc si
				not ax
				out 18h,al ; mask high
				mov al,ah | out 1ah,al ; mask low
				mov ax,[si] | add si,6
				mov [es:di],ax
				add di,VramWidth
				mov [es:di],ax
				add di,VramWidth
				dec cl
			while nz | wend
		endif
		xor al,al
		out 1ah,al ; mask low
		out 18h,al ; mask high
	pop di | pop si | pop dx | pop ax
ret

; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
	push ax | push cx | push si | push di
		call PrepareSprite

		and ch,1
		if z
			mov cl,16
			do
				mov ch,2
				do
					mov ax,[si] | inc si | inc si
					not ax
					out 1ah,al ; mask low
					mov al,ah | out 18h,al ; mask high
					mov ax,[si] | inc si | inc si
					mov [es:di],ax
					mov [es:di+VramWidth],ax
					inc di | inc di
					dec ch
				while nz | wend
				add di,VramWidth*2-2*2
				dec cl
			while nz | wend
		else
			mov cl,16
			do
				mov ch,2
				do
					mov ax,[si] | inc si | inc si
					not ax
					out 18h,al ; mask high
					mov al,ah | out 1ah,al ; mask low
					mov ax,[si] | inc si | inc si
					mov [es:di],ax
					mov [es:di+VramWidth],ax
					inc di | inc di
					dec ch
				while nz | wend
				add di,VramWidth*2-2*2
				dec cl
			while nz | wend
		endif
		xor al,al
		out 1ah,al ; mask low
		out 18h,al ; mask high
	pop di | pop si | pop dx | pop ax
ret