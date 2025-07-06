include "Vram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext Ground_,GroundY_,charOffset_,Tiles_
ext FortPattern

CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ 128

dseg
CharPatternW: public CharPatternW
    defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
    defs SpritePatternSize*Pattern_End
FortPatternW: public FortPatternW
    defs CharPatternSize*6*6
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
	mov cx,CharHeight*6*6
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


; void DrawGround();
cseg
DrawGround_: public DrawGround_
	push ax | push cx | push dx | push bx | push si | push di
		mov ax,VramSegment | mov es,ax

		mov si,[pBackup]
		mov di,0; VramRowSize

		mov al,[GroundY_]
		or al,al
		do | while s
			sub di,VramRowSize
			sub si,StageWidth
			inc al
		wend
		mov dh,[GroundY_]
		mov bx,Ground_
		do
			mov dl,StageWidth/TileSize
			do
				mov al,[bx] | inc bx
				push bx
					mov ah,TileSize*TileSize*2
					mul ah
					add al,[charOffset_]
					adc ah,0
					add ax,Tiles_
					mov bx,ax
					mov ch,TileSize
					do
						cmp dh,StageHeight
						if b
							mov cl,TileSize
							do
								mov al,[bx] | inc bx
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
							add di,VramRowSize-TileSize*VramStep
							add si,StageWidth-TileSize
						else
							add bx,TileSize
							add di,VramRowSize
							add si,StageWidth
						endif
						inc dh
						dec ch
					while nz | wend
					add di,VramStep*TileSize-VramRowSize*TileSize
					add si,TileSize-StageWidth*TileSize
					sub dh,TileSize
				pop bx
				dec dl
			while nz | wend
			add di,VramRowSize*TileSize-StageWidth*VramStep
			add si,StageWidth*TileSize-StageWidth
			add dh,TileSize
			cmp dh,StageHeight
		while b | wend
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

		mov al,StageWidth
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
			add bx,StageWidth
			dec cl
		while nz | wend
 	pop bx | pop cx | pop dx | pop ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push bx | push cx | push dx | push si | push di
		xchg al,dl
		mov ch,VramWidth*2
		mul ch
		add ax,ax
		add ax,ax
		xor dh,dh
		add ax,dx
		mov di,ax
        mov ax,VramSegment | mov es,ax

		mov ah,cl
		xor al,al
		shr ax,1
		add ax,SpritePatternW
		mov si,ax

		add bl,bl | add bl,bl
		mov ch,16 ; yCount
		do
			mov cl,4 ; xCount
			do
				mov dh,[si] | inc si
				or dh,dh
				if nz
					not dh
					mov dl,[si]

					mov ah,[es:di]
					and ah,dh
					or ah,dl
					mov [es:di],ah
					mov [es:di+VramWidth],ah
				endif
				inc si
				inc di
				dec cl
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


; void DrawBarrierLine(byte x, byte y, byte length);
cseg
DrawBarrierLine_: public DrawBarrierLine_
	push ax | push bx | push cx | push dx
		mov dh,al ; x
		mov al,VramWidth*2
		mul dl
		add ax,ax
		mov dl,dh
		xor dh,dh
		add ax,dx
		add ax,ax
		add ax,VramWidth*3*2
		mov bx,ax
        mov ax,VramSegment | mov es,ax
	
		add cl,cl
		do
			mov byte ptr [es:bx],0ffh
			mov byte ptr [es:bx+VramWidth],0ffh
			inc bx
			dec cl
		while nz | wend
	pop dx | pop cx | pop bx | pop ax
ret


; void DrawFortPattern(byte x, byte y);
cseg
DrawFortPattern_: public DrawFortPattern_
	push ax | push bx | push cx | push dx | push si | push di
		mov ch,8*6
		mov si,FortPatternW
		do
			cmp dl,0
		while l
			add si,4*2*6
			sub ch,4
			inc dl
		wend
		or ch,ch
		if nz
			mov dh,al ; x
			mov al,VramWidth*2
			mul dl
			add ax,ax
			add ax,ax
			mov dl,dh ; x
			xor dh,dh
			add ax,dx
			mov di,ax
			mov ax,VramSegment | mov es,ax
			do
				mov cl,6
				do
					mov ax,[si] | inc si | inc si
					mov [es:di],ax
					mov [es:di+VramWidth],ax
					inc di | inc di
					dec cl
				while nz | wend
				add di,VramWidth*2-6*2
				dec ch
			while nz | wend
		endif
	pop di | pop si | pop dx | pop cx | pop bx | pop ax
ret
