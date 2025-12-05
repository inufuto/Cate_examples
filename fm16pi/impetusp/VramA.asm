include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ CharHeight*VramStep*4*2

dseg
Backup:
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*VVramHeight
pMixedPattern:
    defw 0
MixedPattern: public MixedPattern
	defs CharHeight*9*32


cseg
InitVram: public InitVram
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
		xor ax,ax
		xor bx,bx
		mov cx,8000h/2
		do
			mov es:[bx],ax
			add bx,2
		wloop

		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		call Clear

		; mov bx,VVram_
		; mov cx,VVramWidth*VVramHeight/2
		; call Clear
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
		add di,VramStep-VramRowSize
    pop si | pop cx
ret


; void Put(word vram, byte c);
cseg
Put_: public Put_
	push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax
        mov al,CharHeight | mul dl
		add ax,CharPattern
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
        mov ah,CharPatternSize | mul ah
		add ax,CharPattern
		call Put
		mov ax,di
	pop di | pop bx
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
        mov cx,VVramWidth*VVramHeight
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
		mov di,Vram
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov ax,[bx] | inc bx | inc bx
				or ah,ah
				if nz
					mov byte ptr [si],0ffh
					call Put
					jmp EndDraw_next
				endif
				cmp al,[si]
				if ne
					mov [si],al
					mov ah,CharHeight | mul ah
					add ax,CharPattern
					call Put
				else
					inc di
				endif
				EndDraw_next:
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-VVramWidth*VramStep
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
        and bl,0feh
		mov al,VVramWidth | mul bl
        and bh,0feh
		add al,bh
        add ax,SpriteLayer
        mov bx,ax ; bx=pSpriteLayer

        mov ah,cl ; pattern
        xor al,al
        shr ax,1 | shr ax,1
        add ax,SpritePattern
        mov si,ax

		mov di,[pMixedPattern]
		and dl,1 ; y
		if z
			and dh,1 ; x
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
					add bx,(VVramWidth-2)*2
					add si,32-2*2
					dec ch
				while nz | wend
			else
                mov cl,2
                do
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
					add bx,(VVramWidth-2)*2
					dec cl
				while nz | wend
			endif
		else
			and dh,1 ; x
			if z
				; mov al,8 | sub al,dl
				; mov ah,4 | mul ah
				; mov [vOffset],ax
				mov cl,2
				do
					push bx
						call SourceBX
						call CopyBackground
						mov ch,4
						do
							call MixStraight
							dec ch
						while nz | wend
					pop bx
					add si,2-8*2
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(VVramWidth-2)*2
				add si,8*2-4
				mov cl,2
				do
					push bx
						call SourceBX
						mov ch,8
						do
							call MixStraight
							dec ch
						while nz | wend
					pop bx
					add si,2-32
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(VVramWidth-2)*2
				add si,32-4
				mov cl,2
				do
					push bx
						call SourceBX
						mov ch,4
						do
							call MixStraight
							dec ch
						while nz | wend
						call CopyBackground
					pop bx
					add si,2-8*2
					inc bx | inc bx
					dec cl
				while nz | wend
				add si,32-2*2
				dec ch
			else
				; mov cl,dh
				; mov al,8 | sub al,dl
				; mov ah,4 | mul ah
				; mov [vOffset],ax

				;TL
				push bx
					call SourceBX
					call CopyBackground
					mov ch,4
					do
						call MixLeft
						dec ch
					while nz | wend
				pop bx
				add si,-16
				inc bx | inc bx
				;TC
				push bx
					call SourceBX
					call CopyBackground
					mov ch,4
					do
						call MixCenter
						dec ch
					while nz | wend
				pop bx
				add si,2-16
				inc bx | inc bx
				;TR
				push bx
					call SourceBX
					call CopyBackground
					mov ch,4
					do
						call MixRight
						dec ch
					while nz | wend
				pop bx
				add bx,(VVramWidth-2)*2
				add si,-2
				;CL
				push bx
					call SourceBX
					mov ch,8
					do
						call MixLeft
						dec ch
					while nz | wend
				pop bx
				add si,-32
				inc bx | inc bx
				;CC
				push bx
					call SourceBX
					mov ch,8
					do
						call MixCenter
						dec ch
					while nz | wend
				pop bx
				add si,2-32
				inc bx | inc bx
				;CR
				push bx
					call SourceBX
					mov ch,8
					do
						call MixRight
						dec ch
					while nz | wend
				pop bx
				add bx,(VVramWidth-2)*2
				add si,-2
				;BL
				push bx
					call SourceBX
					mov ch,4
					do
						call MixLeft
						dec ch
					while nz | wend
					call CopyBackground
				pop bx
				add si,-16
				inc bx | inc bx
				;BC
				push bx
					call SourceBX
					mov ch,4
					do
						call MixCenter
						dec ch
					while nz | wend
					call CopyBackground
				pop bx
				add si,2-16
				inc bx | inc bx
				;BR
				push bx
					call SourceBX
					mov ch,4
					do
						call MixRight
						dec ch
					while nz | wend
					call CopyBackground
				pop bx
				add si,-16
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
		mov ah,CharHeight | mul ah
		add ax,CharPattern
	endif
	mov bx,ax
ret
CopyBackground:
	mov ch,4
	do
		mov al,[bx] | inc bx
		mov [di],al | inc di
		dec ch
	while nz | wend
ret
MixStraight:
	mov al,[bx] | inc bx
	mov ah,[si]
	not ah | and al,ah
	or al,[si+1]
	add si,4
	mov [di],al | inc di
ret
MixLeft:
	mov al,[bx] | inc bx
	mov ah,[si]
	shr ah,1 | shr ah,1 | shr ah,1 | shr ah,1
	not ah | and al,ah
	mov ah,[si+1]
	shr ah,1 | shr ah,1 | shr ah,1 | shr ah,1
	or al,ah
	add si,4
	mov [di],al | inc di
ret
MixCenter:
	mov al,[bx] | inc bx
	mov dh,[si] | mov dl,[si+2]
	shr dx,1 | shr dx,1 | shr dx,1 | shr dx,1
	not dl | and al,dl
	mov dh,[si+1] | mov dl,[si+3]
	shr dx,1 | shr dx,1 | shr dx,1 | shr dx,1
	or al,dl
	add si,4
	mov [di],al | inc di
ret
MixRight:
	mov al,[bx] | inc bx
	mov ah,[si]
	shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
	not ah | and al,ah
	mov ah,[si+1]
	shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
	or al,ah
	add si,4
	mov [di],al | inc di
ret
