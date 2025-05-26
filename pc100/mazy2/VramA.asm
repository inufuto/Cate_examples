include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, SpritePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ 4*CharHeight*4
Top equ 1

dseg
currentSegment:
    defw 0
pBackup:
	defw 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
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
	mov si,MonoPattern
	mov cx,CharPatternSize/2*Char_End
	do
		mov al,[si] | inc si
		call DoubleBits
		mov [di],dx
		inc di | inc di
	wloop

	mov di,SpritePatternW
	mov si,SpritePattern
	mov cx,32*Pattern_End
	do
		mov al,[si] | inc si
		call DoubleBits
		mov [di],dl | mov [di+2],dh
		mov al,[si] | inc si
		call DoubleBits
		mov [di+1],dl | mov [di+3],dh
		add di,4
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
				mov es:[bx],ax
                inc bx | inc bx
            while nz | wend
			mov ax,es
			add ah,10h
			mov es,ax
            cmp ah,(high VramSegment1)+10h
        while nz | wend

		xor ax,ax 
		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax
			add bx,2
		wloop

		xor ax,ax 
		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax
			add bx,2
		wloop

		mov word ptr [pBackup],Backup1
		mov word ptr [currentSegment],VramSegment1
		mov al,0ffh | out 3eh,al
	pop cx | pop bx | pop ax
ret


cseg
Put1:
; in
;   al: char
;   es: vram segment
;   di: vram offset
    push ax
        mov ah,CharHeight*2 | mul ah
        add ax,CharPatternW
        mov si,ax

        mov ch,CharHeight
        do
            mov ax,[si] | inc si | inc si
            mov es:[di],ax
            mov es:[di+VramWidth],ax
            add di,VramWidth*2
            dec ch
        while ne | wend
        sub di,VramWidth*2*CharHeight
    pop ax
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push cx | push si | push di
        mov di,ax
        mov ax,VramSegment0 | mov es,ax
        mov al,dl
        call Put1
        
        mov ax,VramSegment1 | mov es,ax
        mov al,dl
		call Put1
	pop di | pop si | pop cx | pop ax
	add ax,VramStep
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov di,Vram+VramRowSize*Top
		mov ax,[currentSegment] | mov es,ax
		mov ch, VVramHeight ; vertical count
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					push cx | push si
						call Put1
					pop si | pop cx
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
	push ax
		mov ah,[currentSegment+1]
		cmp ah,high VramSegment0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [currentSegment],VramSegment1
			mov al,0ffh
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [currentSegment],VramSegment0
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
		mov ah,dl
		mov dl,al
		xor al,al
		shl ax,1
		mov bl,dl
		and bl,1
		shl bl,1 | shl bl,1
		shr dl,1
		xor dh,dh
		add ax,dx
		add ax,Vram+VramRowSize*Top
		mov di,ax

		mov ax,[currentSegment] | mov es,ax

		mov ah,cl
		xor al,al
		shr ax,1
		add ax,SpritePatternW
		mov si,ax

		mov cl,bl
		mov ch,16
		do
			push cx
				mov ch,4
				do
					mov bl,[si] | inc si
					xor bh,bh
					shl bx,cl
					not bx

					mov dl,[si] | inc si
					xor dh,dh
					shl dx,cl

					mov ax,[es:di]
					and ax,bx
					or ax,dx
					mov [es:di],ax
					mov [es:di+VramWidth],ax
					inc di
					
					dec ch
				while nz | wend
			pop cx
			add di,VramWidth*2-4
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret