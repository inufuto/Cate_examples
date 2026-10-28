include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern,ColorPattern,SpritePattern
ext VVram_

VramSegment equ 0b800h

TopY equ 1
CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ CharPatternSize*4

dseg
Backup:
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*VVramHeight
ColoredPattern:
    defs CharPatternSize*Char_Color
MixedPattern: public MixedPattern
	defs CharPatternSize*9*32
pMixedPattern:
    defb 0,0

cseg
ColorSource:
defb 64,15 ;Ascii
defb 15,14 ;Logo
defb 2,7 ;Ladder
defb 4,14 ;Item
defb 0
InitVram: public InitVram
    mov ax,0009h | int 10h ; SET MODE
    
    mov bl,0
    do
        cmp bl,8
        if z
            xor bh,bh
        else
            mov bh,bl
        endif
        mov ax,1000h | int 10h
        inc bl
        cmp bl,16
    while nz | wend

    mov si,MonoPattern
    mov di,ColoredPattern
    mov bx,ColorSource
    do
        mov cl,[bx]
        or cl,cl
    while nz
        inc bx
        mov dl,[bx] | inc bx
        call MakePatternMono
    wend
ret

MakePatternMono:
	push bx
		mov bl,dl
		and bl,0fh
		mov bh,dl
		shr bh,1 | shr bh,1 | shr bh,1 | shr bh,1
		do
			mov ch,CharHeight
			do
				push cx
					mov al,[si] | inc si
					mov ch,4
					do
						xor ah,ah
						mov cl,2
						do
							shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
							shl al,1
							if c
								or ah,bl
							else
								or ah,bh
							endif
							dec cl
						while nz | wend
						mov [di],ah | inc di
						dec ch
					while nz | wend
				pop cx
				dec ch
			while nz | wend
			dec cl
		while nz | wend
	pop bx
ret


; void ClearScreen();
cseg
ClearRam:
	xor ax,ax 
	do
		mov [bx],ax
		inc bx | inc bx
	wloop
ret
ClearScreen_:  public ClearScreen_
	push ax | push cx | push dx | push bx
		mov ax,VramSegment | mov es,ax
        xor ax,ax
        mov bx,0
        do
            mov es:[bx],ax
            inc bx | inc bx
            cmp bx,8000h
        while ne | wend
		
        mov bx,backup
		mov cx,VVramWidth*VVramHeight
		call ClearRam

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
		call ClearRam
	pop bx | pop dx | pop cx | pop ax
ret

Put:
; in
;   si: source pattern
;   es:di: vram address
    push cx
        mov ch,2
        do
            mov cl,4
            do
                movsw
                movsw
                add di,2000h-VramStep
                dec cl
            while nz | wend
            add di,VramWidth-2000h*4
            dec ch
        while nz | wend
        add di,VramStep-VramRowSize
    pop cx
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
	push dx | push si | push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax

        cmp dl,Char_Color
        if c
            mov si,ColoredPattern
        else
            mov si,ColorPattern-CharPatternSize*Char_Color
        endif
        mov al,CharPatternSize | mul dl
        add si,ax

        call Put
        mov ax,di
	pop di | pop si | pop dx
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
	push dx
		sub dl,20h
		call Put_
	pop dx
ret


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    push ax | push cx | push si | push di
        mov word ptr[pMixedPattern],MixedPattern

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
		mov di,Vram+VramRowSize*TopY
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov ax,[bx] | inc bx | inc bx
				or ah,ah
				if nz
					mov byte ptr [si],0ffh
					push si
                        mov si,ax
                        call Put
                    pop si
					jmp EndDraw_next
				endif
				cmp al,[si]
				if ne
					mov [si],al
                    push si
                        cmp al,Char_Color
                        if c
                            mov si,ColoredPattern
                        else
                            mov si,ColorPattern-CharPatternSize*Char_Color
                        endif
                        mov ah,CharPatternSize | mul ah
                        add si,ax
                        call Put
                    pop si
				else
					add di,VramStep
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

        mov ah,cl
        xor al,al
        shr ax,1
        add ax,SpritePattern
        mov si,ax

		mov di,[pMixedPattern]
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
								call MixCenter
                                dec ch
                            while nz | wend
                        pop cx | pop bx
						add si,4-32*2
						inc bx | inc bx
						dec cl
					while nz | wend
					add bx,(VVramWidth-2)*2
					add si,32*2-4*2
					dec ch
				while nz | wend
			else
                mov cl,2
                do
                    push cx
                        ; Left
                        push bx 
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixLeft
                                dec ch
                            while nz | wend
                            add si,2-32*2
                        pop bx
                        inc bx | inc bx
                        ; Center
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixCenter
                                dec ch
                            while nz | wend
                            add si,4-32*2
                        pop bx
                        inc bx | inc bx
                        ; Right
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixRight
                                dec ch
                            while nz | wend
                        pop bx
						add si,-4-2
                        add bx,(VVramWidth-2)*2
                    pop cx
					dec cl
				while nz | wend
			endif
		else
			test dh,1 ; x
			if z
                ; Top
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
                                call MixCenter
                                dec ch
                            while nz | wend
                        pop bx
                    pop cx
                    add si,4-64/2
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add si,64/2-4*2
                add bx,(VVramWidth-2)*2
                ; Center
                mov cl,2
                do
                    push cx
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixCenter
                                dec ch
                            while nz | wend
                        pop bx
                    pop cx
                    add si,4-64
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add si,64-4*2
                add bx,(VVramWidth-2)*2
                ; Bottom
                mov cl,2
                do
                    push cx
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
                        pop bx
                    pop cx
                    add si,4-64/2
                    inc bx | inc bx
                    dec cl
                while nz | wend
            else
				;TL
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
                    add si,2-32
				pop bx
				inc bx | inc bx
				;TC
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
                    add si,4-32
				pop bx
				inc bx | inc bx
				;TR
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
					add si,-4-2
				pop bx
				add bx,(VVramWidth-2)*2
				;CL
				push bx
					call SourceBX
					mov ch,CharHeight
					do
						call MixLeft
						dec ch
					while nz | wend
                    add si,2-32*2
				pop bx
				inc bx | inc bx
				;CC
				push bx
					call SourceBX
					mov ch,CharHeight
					do
						call MixCenter
						dec ch
					while nz | wend
                    add si,4-32*2
				pop bx
				inc bx | inc bx
				;CR
				push bx
					call SourceBX
					mov ch,CharHeight
					do
						call MixRight
						dec ch
					while nz | wend
				pop bx
				add si,-4-2
				add bx,(VVramWidth-2)*2
				;BL
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
                    add si,2-32
				pop bx
				inc bx | inc bx
				;BC
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
                    add si,4-32
				pop bx
				inc bx | inc bx
				;BR
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
        cmp al,Char_Color
        if c
            mov bx,ColoredPattern
        else
            mov bx,ColorPattern-CharPatternSize*Char_Color
        endif
		mov ah,CharPatternSize | mul ah
		add bx,ax
    else
        mov bx,ax
	endif
ret
MixByte:
    mov al,[si] | inc si
    mov dl,0ffh
    test al,0f0h
    if nz
        and dl,0fh
    endif
    test al,0fh
    if nz
        and dl,0f0h
    endif
    mov ah,[bx] | inc bx
    and ah,dl
    or al,ah
    mov [di],al | inc di
ret
MixCenter:
    mov cl,4
    do
        call MixByte
        dec cl
    while nz | wend
    add si,4
ret
MixLeft:
                    _deb: public _deb
    mov ax,[bx] | inc bx | inc bx
    mov [di],ax | inc di | inc di
    call MixByte
    call MixByte
    add si,2+4
ret
MixRight:
    call MixByte
    call MixByte
    mov ax,[bx] | inc bx | inc bx
    mov [di],ax | inc di | inc di
    add si,2+4
ret
CopyBackground:
    mov cl,2
    do
		mov ax,[bx] | inc bx | inc bx
		mov [di],ax | inc di | inc di
        dec cl
    while nz | wend
ret
