include "Vram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext VVram_

VramTop equ Vram+VramRowSize*0

dseg
Backup:
	defs WindowWidth*WindowHeight
SpriteLayer: public SpriteLayer
	defs 2*WindowWidth*WindowHeight
pMixedPattern:
    defw 0
MixedPattern: public MixedPattern
	defs CharHeight*9*32


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
		mov cx,WindowWidth*WindowHeight
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
		cmp dl,Char_Fort
		if c
			mov al,CharHeight | mul dl
			add ax,CharPattern
		else
			sub dl,Char_Fort
			mov al,CharHeight | mul dl
			add ax,FortPatternRam
		endif
        call Put
	pop di | pop ax
	inc ax
ret


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    push ax | push cx | push si | push di
        mov word ptr[pMixedPattern],MixedPattern

        mov cx,ds | mov es,cx
		xor ah,ah
        mov si,VVram_
        mov di,SpriteLayer
        mov cx,WindowWidth*WindowHeight
        do
			mov al,[si] | inc si
			mov [di],ax | inc di | inc di
        wloop
    pop di | pop si | pop cx | pop ax
ret


; void EndDraw();
cseg
EndDraw_: public EndDraw_
	push ax | push cx | push dx | push bx | push si | push di
        mov ax,VramSegment | mov es,ax
        mov bx,SpriteLayer
		mov si,Backup
		mov di,Vram+VramTop
		mov ch,WindowHeight
		do
			mov cl,WindowWidth
			do 
				mov ax,[bx] | inc bx | inc bx
				or ah,ah
				if nz
					mov byte ptr [si],0ffh
					call Put
					add di,-VramWidth*CharHeight*VramStep
					jmp EndDraw_next
				endif
				cmp al,[si]
				if ne
					mov [si],al
					cmp al,Char_Fort
					if c
						mov ah,CharHeight | mul ah
						add ax,CharPattern
					else
						sub al,Char_Fort
						mov ah,CharHeight | mul ah
						add ax,FortPatternRam
					endif
					call Put
					add di,-VramWidth*CharHeight*VramStep
				endif
				EndDraw_next:
				inc di
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-WindowWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
dseg
vOffset:
	defw 0
cseg
DrawSprite_: public DrawSprite_
	push ax | push cx | push dx | push bx | push si | push di
        mov dh,al ; dx=(x,y)
        mov bx,dx ; bx=(x,y)
        shr bl,1 | shr bl,1 ;y grid
        shr bh,1 | and bh,0feh ;x grid
		mov al,WindowWidth*2 | mul bl
		add al,bh
        add ax,SpriteLayer
        mov bx,ax ; bx=pSpriteLayer

        mov ah,cl ; pattern
        xor al,al
        shr ax,1 | shr ax,1
        add ax,SpritePattern
        mov si,ax

		mov di,[pMixedPattern]
		shl dh,1
		shl dl,1
		and dl,3*2 ; y
		if z
			and dh,3*2 ; x
			if z
                mov ch,2
                do
                    mov cl,2
                    do
                        push bx | push cx
							call SourceBX
                            mov ch,CharHeight
                            do
								call MixStraight
                                dec ch
                            while nz | wend
                        pop cx | pop bx
						add si,2-32
						inc bx | inc bx
						dec cl
					while nz | wend
					add bx,(WindowWidth-2)*2
					add si,32-2*2
					dec ch
				while nz | wend
			else
				mov cl,dh
                mov dh,2
                do
					push dx
						push bx 
							call SourceBX
							mov ch,CharHeight
							do
								call MixLeft
								dec ch
							while nz | wend
							add si,-32
						pop bx
						inc bx | inc bx
						push bx
							call SourceBX
							mov ch,CharHeight
							do
								call MixCenter
								dec ch
							while nz | wend
							add si,2-32
						pop bx
						inc bx | inc bx
						push bx
							call SourceBX
							mov ch,CharHeight
							do
								call MixRight
								dec ch
							while nz | wend
						pop bx
						add si,-2
						add bx,(WindowWidth-2)*2
					pop dx
					dec dh
				while nz | wend
			endif
		else
			and dh,3*2 ; x
			if z
				mov al,8 | sub al,dl
				mov ah,4 | mul ah
				mov [vOffset],ax
				mov cl,2
				do
					push bx | push dx | push si
						call SourceBX
						mov ch,dl
						do
							call CopyBackground
							dec ch
						while nz | wend
						mov ch,8 | sub ch,dl
						do
							call MixStraight
							dec ch
						while nz | wend
					pop si | pop dx | pop bx
					add si,2
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(WindowWidth-2)*2
				add si,-4
				add si,[vOffset]
				mov cl,2
				do
					push bx | push dx | push si
						call SourceBX
						mov ch,8
						do
							call MixStraight
							dec ch
						while nz | wend
					pop si | pop dx | pop bx
					add si,2
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(WindowWidth-2)*2
				add si,32-4
				mov cl,2
				do
					push bx | push si
						push dx
							call SourceBX
							mov ch,dl
							do
								call MixStraight
								dec ch
							while nz | wend
						pop dx
						mov ch,8 | sub ch,dl
						do
							call CopyBackground
							dec ch
						while nz | wend
					pop si | pop bx
					add si,2
					inc bx | inc bx
					dec cl
				while nz | wend
				add si,32-2*2
				dec ch
			else
				mov cl,dh
				mov al,8 | sub al,dl
				mov ah,4 | mul ah
				mov [vOffset],ax

				push bx | push dx | push si
					call SourceBX
					mov ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,8 | sub ch,dl
					do
						call MixLeft
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				inc bx | inc bx
				push bx | push dx | push si
					call SourceBX
					mov ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,8 | sub ch,dl
					do
						call MixCenter
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				add si,2
				inc bx | inc bx
				push bx | push dx | push si
					call SourceBX
					mov ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,8 | sub ch,dl
					do
						call MixRight
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				add bx,(WindowWidth-2)*2
				add si,-2
				add si,[vOffset]
				push bx | push dx | push si
					call SourceBX
					mov ch,8
					do
						call MixLeft
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				inc bx | inc bx
				push bx | push dx | push si
					call SourceBX
					mov ch,8
					do
						call MixCenter
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				add si,2
				inc bx | inc bx
				push bx | push dx | push si
					call SourceBX
					mov ch,8
					do
						call MixRight
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				add bx,(WindowWidth-2)*2
				add si,32-2
				push bx | push si
					push dx
						call SourceBX
						mov ch,dl
						do
							call MixLeft
							dec ch
						while nz | wend
					pop dx
					mov ch,8 | sub ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
				pop si | pop bx
				inc bx | inc bx
				push bx | push si
					push dx
						call SourceBX
						mov ch,dl
						do
							call MixCenter
							dec ch
						while nz | wend
					pop dx
					mov ch,8 | sub ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
				pop si | pop bx
				add si,2
				inc bx | inc bx
				push bx | push si
					push dx
						call SourceBX
						mov ch,dl
						do
							call MixRight
							dec ch
						while nz | wend
					pop dx
					mov ch,8 | sub ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
				pop si | pop bx
			endif
		endif
		mov [pMixedPattern],di
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret

SourceBX:
    mov ax,[bx]
	mov [bx],di
	or ah,ah
	if z
		cmp al,Char_Fort
		if c
			mov ah,CharHeight | mul ah
			add ax,CharPattern
		else
			sub al,Char_Fort
			mov ah,CharHeight | mul ah
			add ax,FortPatternRam
		endif
	endif
	mov bx,ax
ret
CopyBackground:
	mov al,[bx] | inc bx
	mov [di],al | inc di
ret
MixStraight:
	mov al,[bx] | inc bx
	mov ah,[si] | inc si
	not ah | and al,ah
	or al,[si] | add si,4-1
	mov [di],al | inc di
ret
MixLeft:
	mov al,[bx] | inc bx
	call LoadLeft | inc si
	not ah | and al,ah
	call LoadLeft | add si,4-1
	or al,ah
	mov [di],al | inc di
ret
MixCenter:
	mov al,[bx] | inc bx
	push bx
		call LoadCenter | inc si
		not ah | and al,ah
		call LoadCenter | add si,4-1
		or al,ah
		mov [di],al | inc di
	pop bx
ret
MixRight:
	mov al,[bx] | inc bx
	call LoadRight | inc si
	not ah | and al,ah
	call LoadRight | add si,4-1
	or al,ah
	mov [di],al | inc di
ret
LoadLeft:
	mov ah,[si]
	shr ah,cl
ret
LoadCenter:
	push dx | push cx
		mov dh,[si]
		mov dl,[si+2]
		do
			shr dx,1
			dec cl
		while nz | wend
		mov ah,dl
	pop cx | pop dx
ret
LoadRight:
	push dx | push cx
		mov dh,[si]
		xor dl,dl
		do
			shr dx,1
			dec cl
		while nz | wend
		mov ah,dl
	pop cx | pop dx
ret


; MakeFortPattern();
FortWidth equ 6
FortHeight equ 6
ext FortPattern
ext FortY_, FortCharOffset_
dseg
FortPatternRam: public FortPatternRam
    defs CharHeight*(Char_End-Char_Fort)
cseg
MakeFortPattern_: public MakeFortPattern_
	push ax | push cx | push si | push di
		mov al,[FortCharOffset_]
		xor al,(Char_End-Char_Fort)/2
		mov [FortCharOffset_],al
		mov ah,CharHeight | mul ah
		add ax,FortPatternRam
		mov di,ax

		mov ah,[FortY_]
		and ah,3 | add ah,ah
		
		mov si,FortPattern
		mov ch,FortWidth
		do
			or ah,ah
			if nz
				xor al,al
				mov cl,ah
				do
					mov [di],al | inc di
					dec cl
				while nz | wend
			endif
			
			mov cl,CharHeight*FortHeight
			do
				mov al,[si] | inc si
				mov [di],al | inc di
				dec cl
			while nz | wend
			
			xor al,al
			mov cl,CharHeight
			sub cl,ah
			do
				mov [di],al | inc di
				dec cl
			while nz | wend
			dec ch
		while nz | wend
	pop di | pop si | pop cx | pop ax
ret
