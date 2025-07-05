include "Vram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext FortPattern
ext Background_, DotOffset_
ext FortDotOffset_

CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ 128

StageWidth equ 32
StageHeight equ 22
TileWidth equ 2
BackgroundWidth equ StageWidth+TileWidth

dseg
CharPatternW: public CharPatternW
    defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
    defs SpritePatternSize*Pattern_End
Backup:
Backup0:
	defs StageWidth*StageHeight
Backup1:
	defs StageWidth*StageHeight
pBackup:
	defw 0


cseg
InitVram: public InitVram
    mov dx,308h
    mov ax,0071h
    out dx,ax

	mov si,CharPattern
	mov di,CharPatternW
	mov cx,CharHeight*Char_End
	do
		mov al,[si] | inc si
		call MakeDouble
		mov [di],dx
		inc di | inc di
	wloop

	mov si,SpritePattern
	mov di,SpritePatternW
	mov cx,32*Pattern_End
	do
		mov al,[si] | inc si
		call MakeDouble
		mov [di+0],dl | mov [di+2],dh
		mov al,[si] | inc si
		call MakeDouble
		mov [di+1],dl | mov [di+3],dh
		add di,4
	wloop

	mov si,FortPattern
	mov di,FortPatternW
	mov cx,CharHeight*FortWidth*FortHeight
	do
		mov al,[si] | inc si
		call MakeDouble
		mov [di],dx | inc di | inc di
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
        mov al,04h | out dx,al
        call ClearVram
                        xor al,al | out dx,al

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
		mov cx,StageWidth*StageHeight
		call Clear

		; mov bx,VVram_
		; mov cx,StageWidth*StageHeight/2
		; call Clear

		mov word ptr [pBackup],Backup1
		mov dx,308h+1
        mov al,04h | out dx,al
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

        mov dx,308h+1 | in al,dx
        push ax
            xor al,04h | out dx,al
            push si | push di
                call Put
            pop di | pop si
        pop ax
        out dx,al
        call Put
    	mov ax,di
	pop di | pop si | pop dx
ret


; void BackgroundToVram();
cseg
BackgroundToVram_: public BackgroundToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov ax,VramSegment | mov es,ax

		mov bx,Background_
		mov si,[pBackup]
		mov di,0+VramRowSize*0 ; Top
		mov dh,[DotOffset_]
		mov ch,StageHeight
		do
			mov cl,StageWidth
			do 
				mov al,[bx] | inc bx
				cmp al,Char_Background
				if nb
					add al,dh
				endif
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
			add bx,BackgroundWidth-StageWidth
			add di,VramRowSize-StageWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret 


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
	push ax | push dx
        mov dx,308h+1 | in al,dx
        xor al,05h | out dx,al
        test al,04h
        if z
            mov ax,Backup0
        else
            mov ax,Backup1
        endif
        mov [pBackup],ax
    pop dx | pop ax
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

		mov al,StageWidth
		mul dl
		add ax,bx
		add ax,Backup
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
			add bx,StageWidth
			dec cl
		while nz | wend
 	pop bx | pop cx | pop dx | pop ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push bx | push cx | push dx | push si | push di
		mov bl,al ; x
		and bl,1
		shl bl,1 | shl bl,1 ; shift

		xchg al,dl
		mov ch,VramWidth*2
		mul ch
		add ax,ax
		shr dl,1
		xor dh,dh
		add ax,dx
		; add ax,VramRowSize ; Top
		mov di,ax
        mov ax,VramSegment | mov es,ax

		mov ah,cl
		xor al,al
		shr ax,1
		add ax,SpritePatternW
		mov si,ax

		mov cl,bl
		mov ch,16 ; yCount
		do
			mov bh,4 ; xCount
			do
				push bx
					mov bh,[si] | inc si
					xor bl,bl
					shr bx,cl
					or bx,bx
					if nz
						not bx
						mov dh,[si]
						xor dl,dl
						shr dx,cl

						mov ah,[es:di]
						and ah,bh
						or ah,dh
						mov [es:di],ah
						mov [es:di+VramWidth],ah
						inc di
						mov al,[es:di]
						and al,bl
						or al,dl
						mov [es:di],al
						mov [es:di+VramWidth],al
						dec di
					endif
					inc si
				pop bx
				inc di
				dec bh
			while nz | wend
			add di,VramWidth*2-4
			dec ch
		while nz | wend
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
ret


; void EraseBackupH(byte x, byte y, byte width);
cseg
EraseBackupH_: public EraseBackupH_
	push ax | push dx | push cx | push bx
		mov dh,al
		mov al,StageWidth
		mul dl
		mov dl,dh
		xor dh,dh
		add ax,dx
		add ax,Backup0
		mov bx,ax

		mov al,0ffh
		do
			mov [bx],al
			mov [bx+Backup1-Backup0],al
			inc bx
			dec cl
		while nz | wend
 	pop bx | pop cx | pop dx | pop ax
ret


; void DrawFort(byte x, byte y, byte width)
FortWidth equ 8
FortHeight equ 4
dseg
FortPatternW:
	defs CharHeight*FortWidth*FortHeight*2
cseg
DrawFort_: public DrawFort_
	push ax | push cx | push dx | push bx | push si | push di
		mov dh,al ;x
		mov al,VramRowSize/8
		mul dl
		shl ax,1 | shl ax,1 | shl ax,1
		; add ax,VramTop
		mov dl,dh ;x
		xor dh,dh
		add ax,dx
		add ax,dx
		mov di,ax
		mov ax,VramSegment | mov es,ax
		
		mov si,FortPatternW
		mov ch,cl
		add ch,ch
		mov cl,[FortDotOffset_]
		test cl,4
		if nz
			and cl,3
			add si,4*2
		endif
		shl cl,1 | shl cl,1
		cmp cl,8
		if nc
			and cl,7
			dec di
			inc ch
		endif
		mov bh,FortHeight*CharHeight
		do
			push si | push di
				mov bl,ch
				do
					mov dh,[si]
					mov dl,[si+1]
					inc si
					shl dx,cl
					mov [es:di],dh
					mov [es:di+VramWidth],dh
					inc di
					dec bl
				while nz | wend
			pop di | pop si
			add si,FortWidth*2
			add di,VramWidth*2
			dec bh
		while nz | wend
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret
