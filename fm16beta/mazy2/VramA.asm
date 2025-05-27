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
CurrentPage:
	defw 0
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
    mov ax,SubSysSegment | mov es,ax

    mov dx,0fd98h
    do
        mov al,dl | and al,1fh
        out dx,al
        inc dl
        cmp dl,0a0h
    while nz | wend

    mov ax,SubSysSegment | mov es,ax
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
	mov cl,Char_End | sub cl,al
	call MakePatternColor

	mov di,SpritePatternW
	mov si,SpritePattern
	mov cl,Pattern_End
	call MakeSpritePattern
ret

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
	mov ah,CharPatternSize | mul ah
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
	mov ah,CharPatternSize | mul ah
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
ClearScreen_: public ClearScreen_
    push ax | push bx
        mov ax,SubSysSegment | mov es,ax

		mov byte ptr[es:0ff81h],07h
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
		mov byte ptr[CurrentPage],08h
		mov byte ptr[es:0ff82h],07h
    pop bx | pop ax
ret


Put1:
; in
;   al: char
;   di: vram address
    push cx | push dx
        mov ah,CharPatternSize | mul ah
        add ax,CharPatternW
        mov si,ax

        mov al,01h
        do
            mov [es:0ff81h],al
            mov ah,CharHeight
            do
                mov dx,[si] | inc si | inc si
                mov [es:di],dl
                inc di
                mov [es:di],dh
                add di,VramWidth-1
                dec ah
            while ne | wend
            sub di,VramWidth*CharHeight
            shl al,1
            cmp al,08h
        while nz | wend
    pop dx | pop cx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push si | push di
	    mov di,ax
        mov ax,SubSysSegment | mov es,ax
	    mov byte ptr[es:0ff83h],00h
		mov al,dl
		push dx
			call Put1
		pop dx
		mov al,dl
	    mov byte ptr[es:0ff83h],08h
		call Put1
	pop di | pop si | pop ax
	add ax,VramStep
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov ax,SubSysSegment | mov es,ax
		mov al,[CurrentPage] | mov byte ptr[es:0ff83h],al

		mov bx,VVram_
		mov si,[pBackup]
		mov di,VramRowSize
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
	push ax | push bx
		mov ax,SubSysSegment | mov es,ax

		; do
		; 	mov al,[es:0ff86h]
		; 	test al,40h
		; while z | wend

		mov ah,[CurrentPage]
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
		mov [CurrentPage],ah
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


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push cx | push dx | push bx | push si | push di
		xchg al,dl
		mov ch,VramWidth*2
		mul ch
		add ax,ax
		
		xor dh,dh
		add ax,dx
		add ax,VramRowSize
		mov di,ax

		mov ah,cl
		xor al,al
		add ax,SpritePatternW
		mov si,ax

        mov ax,SubSysSegment | mov es,ax
		mov al,[CurrentPage] | mov byte ptr[es:0ff83h],al

		mov ch,16
		do
			mov cl,4
			do
				mov dh,[si] | inc si
				or dh,dh
				if nz
					not dh
					mov bx,0001h
					do
						mov al,bl | or al,bh
						mov [es:0ff81h],al
						mov dl,[si] | inc si

						mov al,[es:di]
						and al,dh
						or al,dl
						mov [es:di],al

						shl bl,1
						add bh,40h
						test bl,07h
					while nz | wend
				else
					inc si | inc si | inc si
				endif
				inc di
				dec cl
			while nz | wend
			add di,VramWidth-4
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret
