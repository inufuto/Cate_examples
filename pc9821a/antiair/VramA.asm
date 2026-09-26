include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

VramSegment equ 0a800h
PortSegment equ 0e000h

PalettePort equ 0a8h

CharPatternSize equ CharWidth*CharHeight
SpritePatternSize equ SpriteWidth*SpriteHeight
VramRate equ 16

dseg
Backup:
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*VVramHeight
pMixedPattern:
    defb 0,0
CharPatternW:
    defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
	defs SpritePatternSize*Pattern_End
MixedPatternW: public MixedPatternW
	defs CharPatternSize*9*32

cseg
PaletteTable:
defb	00h, 00h, 00h, 00h, 00h, 0ffh, 0ffh, 00h
defb	00h, 0ffh, 00h, 0ffh, 00h, 0ffh, 00h, 00h
defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 0ffh, 0ffh, 0ffh
defb	00h, 00h, 00h, 00h, 5fh, 0ffh, 0ffh, 00h
defb	0bfh, 0bfh, 00h, 0bfh, 00h, 0ffh, 0bfh, 00h
defb	0bfh, 0bfh, 0ffh, 0bfh, 00h, 0bfh, 0bfh, 0bfh
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 1, 1 ; Fence
defb 0
InitVram: public InitVram
    mov ax,300ch
    mov bh,32h
    int 18h

    mov al,21h | out 6Ah,al
    mov al,0dh | out 0A2h,al

    mov ax,PortSegment | mov es,ax
    mov byte ptr [es:0100h],0

    mov bx,PaletteTable
    xor ah,ah
    do
        mov al,ah | out PalettePort,al
        mov al,[bx+1] | out PalettePort+2,al ; G
        mov al,[bx+0] | out PalettePort+4,al ; R
        mov al,[bx+2] | out PalettePort+6,al ; B
        add bx,3
        inc ah
        cmp ah,16
    while nz | wend

    mov si,MonoPattern
    mov di,CharPatternW
    mov bx,ColorTable
    do
		mov cl,[bx] ; count
		or cl,cl
	while nz
		inc bx
        mov ah,[bx] | inc bx ; color
        do
            mov ch,CharHeight
            do
                mov dl,[si] | inc si
                mov dh,CharWidth
                do
                    mov al,ah
                    shl dl,1
                    if c
                        and al,0fh
                    else
                        shr al,1 | shr al,1 | shr al,1 | shr al,1
                    endif
                    mov [di],al | inc di
                    dec dh
                while nz | wend
                dec ch
            while nz | wend
        dec cl
        while nz | wend
    wend

    mov si,ColorPattern
    mov cx,CharPatternSize/2*(Char_End-Char_Color)
    call MakeW

    mov si,SpritePattern
    mov di,SpritePatternW
    mov cx,Pattern_End*SpritePatternSize/2
    call MakeW
ret
MakeW:
    do
        mov al,[si] | inc si
        mov ah,al
        shr al,1 | shr al,1 | shr al,1 | shr al,1
        and ah,0fh
        mov [di],ax | inc di | inc di
    wloop
ret


cseg
WriteBank:
    mov ax,PortSegment | mov es,ax
    mov [es:0004h],dx
    inc dx
    mov [es:0006h],dx
    dec dx
    mov ax,VramSegment | mov es,ax
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
    push ax | push dx | push bx
        xor dx,dx
        do
            call WriteBank
            xor bx,bx
            do
                mov word ptr [es:bx],0
                inc bx | inc bx
            while nz | wend
            inc dx | inc dx
            cmp dx,10
        while nz | wend

        mov bx,backup
        mov cx,VVramWidth*VVramHeight
        call Clear

        mov bx,VVram_
        mov cx,VVramWidth*VVramHeight/2
        call Clear
    pop bx | pop dx | pop ax
ret


cseg
PutHorz:
    mov cl,CharWidth
    do
        mov al,[si] | inc si
        mov ah,al
        mov [es:di],ax
        add di,2
        if c
            inc dx | inc dx
            call WriteBank
        endif
        dec cl
    while nz | wend
    add di,640-CharWidth*2
    if c
        inc dx | inc dx
        call WriteBank
    endif
ret
Put: ; (si=pCharPattern, es:di=destination, dx=next bank)
    push cx
        mov ch,CharHeight
        do
            call PutHorz
            sub si,CharWidth
            call PutHorz
            dec ch
        while nz | wend
    pop cx
ret


cseg
PatternPtr: ;(al)->si
    mov ah,CharPatternSize
    mul ah
    add ax,CharPatternW
    mov si,ax
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
    push ax | push dx | push si | push di
        mov di,ax
        mov al,dl
        call PatternPtr

        shl di,1 | rcl dx,1
        shl di,1 | rcl dx,1
        shl di,1 | rcl dx,1
        shl di,1 | rcl dx,1
        shl dx,1
        call WriteBank

        call Put
    pop di | pop si | pop dx | pop ax
    inc ax
ret

; word PrintC(word vram, byte c);
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
        mov word ptr[pMixedPattern],MixedPatternW

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
Put1:
    call Put
    sub di,640*CharHeight*2-VramRate
    if c
        dec dx | dec dx
        call WriteBank
    endif
ret
EndDraw_: public EndDraw_
	push ax | push cx | push dx | push bx | push si | push di
        mov bx,SpriteLayer
		mov si,Backup
		mov di,(Vram+VramRowSize*0)*VramRate
        mov dx,0
        call WriteBank        
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
					    call Put1
                    pop si
					jmp EndDraw_next
				endif
				cmp al,[si]
				if ne
					mov [si],al
                    push si
                        call PatternPtr
    					call Put1
                    pop si
                else
                    add di,VramRate
                    if c
                        inc dx | inc dx
                        call WriteBank
                    endif
				endif
				EndDraw_next:
				inc si
				dec cl
			while nz | wend
			add di,640*CharHeight*2-VramRate*VVramWidth
            if c
                inc dx | inc dx
                call WriteBank
            endif
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
        shr bl,1 | shr bl,1 | shr bl,1 ;y grid
        shr bh,1 | shr bh,1 | and bh,0feh ;x grid
		mov al,VVramWidth*2 | mul bl
		add al,bh
        add ax,SpriteLayer
        mov bx,ax ; bx=pSpriteLayer

        mov ah,cl ; pattern
        xor al,al
        add ax,SpritePatternW
        mov si,ax

		mov di,[pMixedPattern]
		and dl,7 ; y
		if z
            and dh,7 ; x
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
						add si,CharWidth-SpriteWidth*CharHeight
						inc bx | inc bx
						dec cl
					while nz | wend
					add bx,(VVramWidth-2)*2
					add si,SpriteWidth*CharHeight-CharWidth*2
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
                            add si,-SpritePatternSize/2
                        pop bx
                        inc bx | inc bx
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixCenter
                                dec ch
                            while nz | wend
                            add si,-SpritePatternSize/2
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
                        add bx,(VVramWidth-2)*2
                    pop cx
					dec cl
				while nz | wend
            endif
        else
			and dh,7 ; x
			if z
                mov cl,2
                do
                    push cx
                        push bx
                            call SourceBX
                            mov ch,dl
                            do
                                call CopyBackground
                                dec ch
                            while nz | wend
                            mov ch,CharHeight | sub ch,dl
                            do
                                call MixStraight
                                dec ch
                            while nz | wend
                            call FeedForward
                        pop bx
                    pop cx
                    add si,CharWidth-SpritePatternSize/2
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add si,SpritePatternSize/2-SpriteWidth
                mov ch,dl
                do
                    sub si,SpriteWidth
                    dec ch
                while nz | wend
                add bx,(VVramWidth-2)*2
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
                    add si,CharWidth-SpritePatternSize/2
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add si,SpritePatternSize/2-SpriteWidth
                add bx,(VVramWidth-2)*2
                mov cl,2
                do
                    push cx
                        push bx
                            call SourceBX
                            mov ch,dl
                            do
                                call MixStraight
                                dec ch
                            while nz | wend
                            mov ch,CharHeight | sub ch,dl
                            do
                                call CopyBackground
                                dec ch
                            while nz | wend
                            call FeedBackward
                        pop bx
                    pop cx
                    add si,CharWidth
                    inc bx | inc bx
                    dec cl
                while nz | wend
            else
				;TL
				push bx
					call SourceBX
					mov ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
                    mov ch,CharHeight | sub ch,dl
					do
						call MixLeft
						dec ch
					while nz | wend
                    mov ch,dl
                    call FeedForward
				pop bx
                add si,-SpritePatternSize/2
				inc bx | inc bx
				;TC
				push bx
					call SourceBX
					mov ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,CharHeight | sub ch,dl
					do
						call MixCenter
						dec ch
					while nz | wend
                    call FeedForward
				pop bx
                add si,-SpritePatternSize/2
				inc bx | inc bx
				;TR
				push bx
					call SourceBX
					mov ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
					mov ch,CharHeight | sub ch,dl
					do
						call MixRight
						dec ch
					while nz | wend
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
				pop bx
                add si,-SpritePatternSize/2
				inc bx | inc bx
				;CC
				push bx
					call SourceBX
					mov ch,CharHeight
					do
						call MixCenter
						dec ch
					while nz | wend
				pop bx
                add si,-SpritePatternSize/2
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
				add bx,(VVramWidth-2)*2
				;BL
				push bx
                    call SourceBX
                    mov ch,dl
                    do
                        call MixLeft
                        dec ch
                    while nz | wend
					mov ch,CharHeight | sub ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
                    call FeedBackward
				pop bx
				inc bx | inc bx
				;BC
				push bx
                    call SourceBX
                    mov ch,dl
                    do
                        call MixCenter
                        dec ch
                    while nz | wend
					mov ch,CharHeight | sub ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
                    call FeedBackward
				pop bx
				inc bx | inc bx
				;BR
				push bx
                    call SourceBX
                    mov ch,dl
                    do
                        call MixRight
                        dec ch
                    while nz | wend
					mov ch,CharHeight | sub ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
				pop bx
            endif
        endif
        mov [pMixedPattern],di
    pop di | pop si | pop bx | pop dx | pop cx | pop ax
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
MixByte:
    mov al,[si] | inc si
    mov ah,[bx] | inc bx
    or al,al
    if z
        mov al,ah
    endif
    mov [di],al | inc di
ret
CopyByte:
    mov al,[bx] | inc bx
    mov [di],al | inc di
ret
MixStraight:
    mov cl,CharWidth
    do
        call MixByte
        dec cl
    while nz | wend
    add si,CharWidth
ret
MixLeft:
    mov cl,dh
    do
        call CopyByte
        dec cl
    while nz | wend
    mov cl,CharWidth | sub cl,dh
    do
        call MixByte
        dec cl
    while nz | wend
    mov cl,dh
    do
        inc si
        dec cl
    while nz | wend
    add si,CharWidth
ret
MixCenter:
    mov cl,CharWidth | sub cl,dh
    do
        inc si
        dec cl
    while nz | wend
    mov cl,CharWidth
    do
        call MixByte
        dec cl
    while nz | wend
    mov cl,dh
    do
        inc si
        dec cl
    while nz | wend
ret
MixRight:
    add si,CharWidth
    mov cl,CharWidth | sub cl,dh
    do
        inc si
        dec cl
    while nz | wend
    mov cl,dh
    do
        call MixByte
        dec cl
    while nz | wend
    mov cl,CharWidth | sub cl,dh
    do
        call CopyByte
        dec cl
    while nz | wend
ret
CopyBackground:
    mov cl,CharWidth
    do
        call CopyByte
        dec cl
    while nz | wend
ret
FeedForward:
    mov ch,dl
    do
        add si,SpriteWidth
        dec ch
    while nz | wend
ret
FeedBackward:
    mov ch,dl
    do
        sub si,SpriteWidth
        dec ch
    while nz | wend
ret