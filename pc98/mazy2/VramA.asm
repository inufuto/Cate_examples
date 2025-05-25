include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight*PlaneCount
SpritePatternSize equ 4*4*16

GRCG_Mode equ 7ch
GRCG_Tile equ 7eh

dseg
pVram:
	defw 0
pBackup:
	defw 0

CharPatternW: public CharPatternW
	defs CharPatternSize*Char_End
SpritePatternW:
	defs SpritePatternSize*Pattern_End
color:
	defb 0

	defs VVramWidth
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight

cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
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
	mov cl,Char_End | sub cl,al
	call MakePatternColor

	mov di,SpritePatternW
	mov si,SpritePattern
	mov cl,Pattern_End
	call MakeSpritePattern
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
					mov [di],bx
					shr al,1
					add di,CharHeight*2
					dec cl
				while nz | wend
				add di,2-CharHeight*2*PlaneCount
			pop cx
			dec ch
		while nz | wend
		add di,CharHeight*2*2
		dec cl
	while nz | wend
ret

MakePatternColor:
	mov ah,48 | mul ah
	add ax,CharPatternW
	mov di,ax

	do
		mov ch,CharHeight*PlaneCount
		do
			mov al,[si] | inc si
			call DoubleBits
			xchg dl,dh
			mov [di],dx
			add di,2
			dec ch
		while nz | wend
		dec cl
	while nz | wend
ret

MakeSpritePattern: public MakeSpritePattern
	do
		mov ch,32
		do
			mov al,[si+0] | call DoubleBits ; mask
			mov [di+0],dh | mov [di+4],dl
			mov al,[si+1] | call DoubleBits ; blue
			mov [di+1],dh | mov [di+5],dl
			mov al,[si+2] | call DoubleBits ; red
			mov [di+2],dh | mov [di+6],dl
			mov al,[si+3] | call DoubleBits ; green
			mov [di+3],dh | mov [di+7],dl
			add si,4
			add di,8
			dec ch
		while nz | wend
		dec cl
	while nz | wend
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
ClearScreen_:  public ClearScreen_
	push ax | push cx | push dx | push bx
		mov ax,VramSegment | mov es,ax
		mov al,88h | out GRCG_Mode,al

		xor al,al
		mov dl,3
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

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
		call Clear

		mov word ptr [pBackup],Backup1
		mov word ptr [pVram],Vram1
        mov ch,80h
        mov ah,42h
        int 18h
	pop bx | pop dx | pop cx | pop ax
ret


cseg
Put1:
; in
;   al: char
;   di: vram address
    push cx | push dx
        push di 
            mov ah,48 | mul ah
            add ax,CharPatternW
            mov si,ax

			mov ax,VramSegment
            mov cl,3
            do
				mov es,ax
                mov ch,CharHeight
                do
                    mov dx,[si] | add si,2
                    mov es:[di],dx
                    add di,VramWidth
                    dec ch
                while ne | wend
                sub di,VramWidth*CharHeight
				add ax,800h
                dec cl
            while ne | wend
			mov ax,es | sub ax,800h*3 | mov es,ax
        pop di
    pop dx | pop cx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push si | push di
	    mov di,ax
		mov al,dl
		push dx
			call Put1
		pop dx
		mov al,dl
		add di,Vram1-Vram0
		call Put1
	pop di | pop si | pop ax
	add ax,VramStep
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov di,[pVram] | add di,VramRowSize
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
						call Put1
					pop si
				endif
				add di,VramStep
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
		; do
		; 	in al,60h
		; 	test al,20h
		; while z | wend

		mov ax,[pVram]
		cmp ax,Vram0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [pVram],Vram1
			mov ch,80h
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [pVram],Vram0
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
		test al,3
		if nz
			inc ch
		endif
		shr al,1 | shr al,1
		mov bl,al
		xor bh,bh
		
		test dl,3
		if nz
			inc cl
		endif
		shr dl,1 | shr dl,1

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


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push cx | push dx | push bx | push si | push di
		xchg al,dl
		mov ch,VramWidth*2
		mul ch
		
		mov bl,dl
		and bl,1
		shl bl,1 | shl bl,1
		
		shr dl,1
		xor dh,dh
		add ax,dx
		add ax,[pVram] | add ax,VramRowSize
		mov di,ax

		mov ah,cl
		xor al,al
		add ax,SpritePatternW
		mov si,ax

		mov ax,VramSegment | mov es,ax
		mov al,0c8h | out GRCG_Mode,al

		mov cl,bl
		mov bh,16
		do
			mov bl,4
			do
				push bx
                                                    _deb: public _deb
					mov bh,[si] | inc si
					xor bl,bl
					shr bx,cl
					or bh,bh
					if nz
						mov ch,3
						do
							mov ah,[si] | inc si
							xor al,al
							shr ax,cl
							mov al,ah | out GRCG_Tile,al
							dec ch
						while nz | wend
						out GRCG_Tile,al ; dummy
						mov [es:di],bh
						dec si | dec si | dec si
					endif
					inc di
					or bl,bl
					if nz
						mov ch,3
						do
							mov ah,[si] | inc si
							xor al,al
							shr ax,cl
							out GRCG_Tile,al
							dec ch
						while nz | wend
						out GRCG_Tile,al ; dummy
						mov [es:di],bl
					else
						inc si | inc si | inc si
					endif
				pop bx
				dec bl
			while nz | wend
			add di,VramWidth-4
			dec bh
		while nz | wend
		xor al,al | out GRCG_Mode,al
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret
