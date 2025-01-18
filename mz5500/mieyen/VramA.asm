include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

GDC equ 100h
WDC equ 110h
VDC2 equ 120h
VDC1 equ 130h

CharPatternSize equ VramStep*CharHeight*PlaneCount
SpritePatternSize equ VramStep*CharHeight*4*(PlaneCount+1)
VramTop equ Vram+VramRowSize*1

dseg
color:
	defb 0
Backup:
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*VVramHeight
pMixedPatternW:
    defb 0,0
CharPatternW: public CharPatternW
    defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
    defs SpritePatternSize*Pattern_End
MixedPatternW: public MixedPatternW
	defs CharPatternSize*9*32


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 16, 1 ; Wall
defb 4,6 ; Dot
defb 0
InitVram: public InitVram
    mov dx,VDC2
    xor al,al
    out dx,al

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
			shl dx | shl dx
			shr al,1
			if b
				or dx,0003h
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
			mov [di],dx | inc di | inc di
			dec ch
		while nz | wend
		dec cl
	while nz | wend
ret

MakeSpritePattern: public MakeSpritePattern
	do
		mov ch,SpritePatternSize/2
		do
			mov al,[si] | inc si
            call DoubleBits
			mov [di],dx | inc di | inc di
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
        do
            xor ax,ax
            xor bx,bx
            mov cx,8000h/2
            do
			mov es:[bx],ax
			add bx,2
            wloop
            mov ax,es | add ah,10h | mov es,ax
            cmp ah,0f0h
        while nz | wend

		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		call Clear

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
		call Clear
	pop bx | pop dx | pop cx | pop ax
ret


cseg
Put:
; in
;   ax: pPattern
;   di: vram address
    push cx | push si
        mov si,ax
        mov ax,VramSegment | mov es,ax
        mov ch,PlaneCount
        do
            mov cl,CharHeight
            do
    			mov ax,[si] | inc si | inc si
                mov [es:di],ax
                add di,VramWidth
                mov [es:di],ax
                add di,VramWidth
                dec cl
            while ne | wend
            sub di,VramWidth*CharHeight*2
            mov ax,es | add ah,10h | mov es,ax
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
        mov al,CharPatternSize | mul dl
		add ax,CharPatternW
        call Put
	pop di | pop ax
	inc ax | inc ax
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
        mov bx,SpriteLayer
		mov si,Backup
		mov di,VramTop
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
				endif
				EndDraw_next:
				inc di | inc di
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-VVramWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push cx | push dx | push bx | push si | push di
        mov dh,al ; dx=(x,y)
        mov bx,dx ; bx=(x,y)
        shr bl,1 ;y grid
        and bh,0feh ;x grid
		mov al,VVramWidth*2 | mul bl
		add al,bh
        add ax,SpriteLayer
        mov bx,ax ; bx=pSpriteLayer

        mov ah,cl ; pattern
        xor al,al
        add ax,SpritePatternW
        mov si,ax

		mov di,[pMixedPatternW]
		test dl,1 ; y
		if z
			test dh,1 ; x
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
						add si,8-128
                        add di,16*2
						inc bx | inc bx
						dec cl
					while nz | wend
					add bx,(VVramWidth-2)*2
					add si,128-8*2
					dec ch
				while nz | wend
			else
                mov cl,2
                do
                    push cx
                        push bx 
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixLeft
                                dec ch
                            while nz | wend
                            add si,-128
                        pop bx
                        add di,16*2
                        inc bx | inc bx
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixCenter
                                dec ch
                            while nz | wend
                            add si,-128
                        pop bx
                        add di,16*2
                        inc bx | inc bx
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixRight
                                dec ch
                            while nz | wend
                        pop bx
                        add di,16*2
                        add bx,(VVramWidth-2)*2
                    pop cx
					dec cl
				while nz | wend
			endif
		else
			test dh,1 ; x
			if z
                mov cl,2
                do
                    push cx
                        push bx
                            call SourceBX
                            mov ch,CharHeight/2
                            do
                                call CopyBackground
                                dec ch
                            while nz | wend
                            mov ch,CharHeight/2
                            do
                                call MixStraight
                                dec ch
                            while nz | wend
                        pop bx
                    pop cx
                    add si,8-128/2
                    add di,16*2
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add bx,(VVramWidth-2)*2
                add si,128/2-8*2
                mov cl,2
                do
                    push cx
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixStraight
                                dec ch
                            while nz | wend
                        pop bx
                    pop cx
                    add si,8-128
                    add di,16*2
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add bx,(VVramWidth-2)*2
                add si,128-8*2
                mov cl,2
                do
                    push cx
                        push bx
                            call SourceBX
                            mov ch,CharHeight/2
                            do
                                call MixStraight
                                dec ch
                            while nz | wend
                            mov ch,CharHeight/2
                            do
                                call CopyBackground
                                dec ch
                            while nz | wend
                        pop bx
                    pop cx
                    add si,8-128/2
                    add di,16*2
                    inc bx | inc bx
                    dec cl
                while nz | wend
            else
				push bx
					call SourceBX
					mov ch,CharHeight/2
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,CharHeight/2
					do
						call MixLeft
						dec ch
					while nz | wend
                    add si,-128/2
				pop bx
                add di,16*2
				inc bx | inc bx
				push bx
					call SourceBX
					mov ch,CharHeight/2
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,CharHeight/2
					do
						call MixCenter
						dec ch
					while nz | wend
                    add si,-128/2
				pop bx
                add di,16*2
				inc bx | inc bx
				push bx
					call SourceBX
					mov ch,CharHeight/2
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,CharHeight/2
					do
						call MixRight
						dec ch
					while nz | wend
				pop bx
                add di,16*2
				add bx,(VVramWidth-2)*2
				push bx
					call SourceBX
					mov ch,CharHeight
					do
						call MixLeft
						dec ch
					while nz | wend
                    add si,-128
				pop bx
                add di,16*2
				inc bx | inc bx
				push bx
					call SourceBX
					mov ch,CharHeight
					do
						call MixCenter
						dec ch
					while nz | wend
                    add si,-128
				pop bx
				add di,16*2
				inc bx | inc bx
				push bx
					call SourceBX
					mov ch,CharHeight
					do
						call MixRight
						dec ch
					while nz | wend
				pop bx
                add di,16*2
				add bx,(VVramWidth-2)*2
				push bx
                    call SourceBX
                    mov ch,CharHeight/2
                    do
                        call MixLeft
                        dec ch
                    while nz | wend
					mov ch,CharHeight/2
					do
						call CopyBackground
						dec ch
					while nz | wend
                    add si,-128/2
				pop bx
                add di,16*2
				inc bx | inc bx
				push bx
                    call SourceBX
                    mov ch,CharHeight/2
                    do
                        call MixCenter
                        dec ch
                    while nz | wend
					mov ch,CharHeight/2
					do
						call CopyBackground
						dec ch
					while nz | wend
                    add si,-128/2
				pop bx
                add di,16*2
				inc bx | inc bx
				push bx
                    call SourceBX
                    mov ch,CharHeight/2
                    do
                        call MixRight
                        dec ch
                    while nz | wend
					mov ch,CharHeight/2
					do
						call CopyBackground
						dec ch
					while nz | wend
				pop bx
                add di,16*2
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
    mov cl,PlaneCount
    do
    	mov ax,[bx] | add bx,16
	    mov [di],ax | add di,16
        dec cl
    while nz | wend
    add bx,2-16*PlaneCount
    add di,2-16*PlaneCount
ret
MixStraight:
	mov dx,[si] | inc si | inc si
    not dx
    mov cl,PlaneCount
    do
	    mov ax,[bx] | add bx,16
	    and ax,dx
	    or ax,[si] | inc si | inc si
        mov [di],ax | add di,16
        dec cl
    while nz | wend
    add bx,2-16*PlaneCount
    add di,2-16*PlaneCount
    add si,16-8
ret
MixLeft:
   	call LoadLeft
    not dx
    mov cl,PlaneCount
    do
        mov ax,[bx] | add bx,16
        and ax,dx
        push dx
            call LoadLeft
            or ax,dx
        pop dx
        mov [di],ax | add di,16
        dec cl
    while nz | wend
    add bx,2-16*PlaneCount
    add di,2-16*PlaneCount
    add si,16-8
ret
MixCenter:
    call LoadCenter
    not dx
    mov cl,PlaneCount
    do
    	mov ax,[bx] | add bx,16
        and ax,dx
        push dx
            call LoadCenter
            or ax,dx
        pop dx
		mov [di],ax | add di,16
        dec cl
    while nz | wend
    add bx,2-16*PlaneCount
    add di,2-16*PlaneCount
    add si,16-8
ret
MixRight:
	call LoadRight
    not dx
    mov cl,PlaneCount
    do
    	mov ax,[bx] | add bx,16
        and ax,dx
        push dx
            call LoadRight
            or ax,dx
        pop dx
		mov [di],ax | add di,16
        dec cl
    while nz | wend
    add bx,2-16*PlaneCount
    add di,2-16*PlaneCount
    add si,16-8
ret

LoadLeft:
	mov dh,[si]
	xor dl,dl
    inc si | inc si
ret
LoadCenter:
    mov dl,[si+1]
    mov dh,[si+8]
    inc si | inc si
ret
LoadRight:
    mov dl,[si+9]
    xor dh,dh
    inc si | inc si
ret
