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
pMixedPatternW:
    defw 0
CharPatternW: public CharPatternW
    defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
    defs SpritePatternSize*Pattern_End
MixedPatternW: public MixedPatternW
	defs CharPatternSize*9*38


cseg
InitVram: public InitVram
	mov si,CharPattern
	mov di,CharPatternW
	mov cx,CharHeight*Char_End
	call MakeDouble

	mov si,SpritePattern
	mov di,SpritePatternW
	mov cx,CharHeight*2*4*Pattern_End
	call MakeDouble
ret

MakeDouble:
	do
		mov al,[si] | inc si
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
ClearScreen_:  public ClearScreen_
	push ax | push cx | push dx | push bx
		mov ax,VramSegment | mov es,ax
		xor ax,ax
		xor bx,bx
		mov cx,8000h
		do
			mov es:[bx],ax
			add bx,2
		wloop

		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		call Clear

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
		call Clear
	pop bx | pop dx | pop cx | pop ax
ret


Put:
; in
;   ax: pPattern
;   di: vram address
    push cx | push si
		mov si,ax
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
    pop si | pop cx
ret


; void Put(word vram, byte c);
cseg
Put_: public Put_
	push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax
        mov al,CharPatternSize | mul dl
		add ax,CharPatternW
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
		add ax,CharPatternW
		call Put
		mov ax,di
	pop di | pop bx
ret


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    push ax | push cx | push si | push di
        mov word ptr[pMixedPatternW],MixedPatternW

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
					mov ah,CharPatternSize | mul ah
					add ax,CharPatternW
					call Put
				else
					inc di | inc di
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
        and bh,0feh ;x grid
		add al,bh
        add ax,SpriteLayer
        mov bx,ax ; bx=pSpriteLayer

        mov ah,cl ; pattern
        xor al,al
        shr ax,1
        add ax,SpritePatternW
        mov si,ax

		mov di,[pMixedPatternW]
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
						add si,4-64
						inc bx | inc bx
						dec cl
					while nz | wend
					add bx,(VVramWidth-2)*2
					add si,64-4*2
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
						add si,-64
					pop bx
					inc bx | inc bx
					push bx
						call SourceBX
						mov ch,CharHeight
						do
							call MixCenter
							dec ch
						while nz | wend
						add si,4-64
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
					add si,-4
					add bx,(VVramWidth-2)*2
					dec cl
				while nz | wend
			endif
		else
			and dh,1 ; x
			if z
				mov al,8 | sub al,dl
				mov ah,8 | mul ah
				mov [vOffset],ax
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
					add si,4-8*4
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(VVramWidth-2)*2
				add si,8*4-8
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
					add si,4-8*8
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(VVramWidth-2)*2
				add si,8*8-8
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
					add si,4-8*4
					inc bx | inc bx
					dec cl
				while nz | wend
				add si,64-4*2
				dec ch
			else
				mov cl,dh
				mov al,8 | sub al,dl
				mov ah,8 | mul ah
				mov [vOffset],ax

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
				add si,-8*4
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
				add si,4-8*4
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
				add si,-4
				;CL
				push bx
					call SourceBX
					mov ch,8
					do
						call MixLeft
						dec ch
					while nz | wend
				pop bx
				add si,-8*8
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
				add si,4-8*8
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
				add si,-4
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
				add si,-8*4
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
				add si,4-8*4
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
				add si,-8*4
			endif
		endif
		mov [pMixedPatternW],di
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret

SourceBX:
    mov ax,[bx]
	mov [bx],di
	or ah,ah
	if z
		mov ah,CharPatternSize | mul ah
		add ax,CharPatternW
	endif
	mov bx,ax
ret
CopyBackground:
	mov ch,4
	do
		mov ax,[bx] | inc bx | inc bx
		mov [di],ax | inc di | inc di
		dec ch
	while nz | wend
ret
MixStraight:
	mov ax,[bx] | inc bx | inc bx
	mov dx,[si] | inc si | inc si
	not dx | and ax,dx
	or ax,[si] | add si,8-2
	mov [di],ax | inc di | inc di
ret
MixLeft:
	mov ax,[bx] | inc bx | inc bx
	mov dh,[si] | xor dl,dl
	not dx | and ax,dx
	mov dh,[si+2] | xor dl,dl
	add si,8
	or ax,dx
	mov [di],ax | inc di | inc di
ret
MixCenter:
	mov ax,[bx] | inc bx | inc bx
	mov dl,[si+1] | mov dh,[si+4]
	not dx | and ax,dx
	mov dl,[si+3] | mov dh,[si+6]
	add si,8
	or ax,dx
	mov [di],ax | inc di | inc di
ret
MixRight:
	mov ax,[bx] | inc bx | inc bx
	mov dl,[si+1] | xor dh,dh
	not dx | and ax,dx
	mov dl,[si+3] | xor dh,dh
	add si,8
	or ax,dx
	mov [di],ax | inc di | inc di
ret
; LoadLeft:
; 	mov dh,[si]
; 	xor dl,dl
; ret
; LoadCenter:
; 	mov dl,[si+1]
; 	mov dh,[si+4]
; ret
; LoadRight:
; 	mov dl,[si+1]
; 	xor dh,dh
; ret
