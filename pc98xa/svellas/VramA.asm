include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext AsciiPattern, MonoPattern, ColorPattern, SpritePattern
ext VVram_

GRCG_Mode equ 0a4h
GRCG_Tile equ 0a6h

AsciiPatternWidth equ VramStep
AsciiPatternSize equ AsciiPatternWidth*CharHeight
AsciiCount equ 40h
AsciiColor equ 7

CharPatternWidth equ VramStep*2
CharPatternSize equ CharPatternWidth*CharHeight*PlaneCount

SpritePatternWidth equ CharPatternWidth*2
SpriteHeight equ CharHeight*2
SpritePatternSize equ SpritePatternWidth*SpriteHeight*PlaneCount

CharPatternQ equ 0000h
SpritePatternQ equ CharPatternQ+CharPatternSize*Char_End
MixedPatternQ equ SpritePatternQ+SpritePatternSize*Pattern_End
; QQQ equ MixedPatternQ+CharPatternSize*9*32

dseg
AsciiPatternW: public AsciiPatternW
    defs AsciiPatternSize*AsciiCount
Backup:
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*VVramHeight
pMixedPatternQ:
    defw 0
color:
    defb 0

cseg
PaletteTable:
defb	00h, 00h, 0fh, 00h, 00h, 0fh, 0bfh, 0fh
defb	0f0h, 00h, 0ffh, 00h, 0f0h, 0fh, 0ffh, 0fh
defb	00h, 00h, 0fh, 05h, 0b0h, 0fh, 0bfh, 00h
defb	0b0h, 00h, 0bbh, 00h, 0f5h, 0fh, 0ddh, 0dh
ColorTable:
defb 16, 10 ; Logo
defb 8, 12 ; MovablePanel
defb 8, 15 ; Arrow
defb 4, 14 ; Star
defb 0
InitVram: public InitVram
    mov bx,PaletteTable
    xor ah,ah
    do
        mov al,ah | out 0a8h,al

        mov dx,[bx] | inc bx | inc bx
        mov al,dl
        shr al,1 | shr al,1 | shr al,1 | shr al,1
        out 0aah,al
        mov al,dh | out 0ach,al
        mov al,dl | and al,0fh | out 0aeh,al
        inc ah
        cmp ah,16
    while nz | wend

    mov si,AsciiPattern
    mov di,AsciiPatternW
    mov cx,CharHeight*AsciiCount
    do
        mov al,[si] | inc si
        xor dx,dx
        mov ah,8
        do
            shl dx,1 | shl dx,1
            shl al,1
            if c
                or dx,0003h
            endif
            dec ah
        while nz | wend
        xchg dh,dl
        mov [di],dx | inc di | inc di
    wloop

    mov si,MonoPattern
    mov di,CharPatternQ
    mov ax,PatternSegment | mov es,ax
	mov bx,ColorTable
	do
		mov cl,[bx] ; count
		or cl,cl
	while nz
		inc bx
		mov al,[bx] | inc bx
        mov [color],al
        do
            mov ch,CharHeight
            do
                push cx
                    mov dh,[si] | inc si
                    mov cl,CharPatternWidth
                    do
                        mov ch,PlaneCount
                        do
                            mov byte ptr[es:di],00h | inc di
                            dec ch
                        while nz | wend
                        sub di,PlaneCount

                        mov dl,0f0h
                        mov ch,2
                        do
                            push cx
                                mov ah,[color]
                                shl dh,1
                                if nc
                                    shr ah,1 | shr ah,1 | shr ah,1 | shr ah,1
                                endif
                                mov cl,PlaneCount
                                do
                                    shr ah,1
                                    if c
                                        or byte ptr[es:di],dl
                                    endif
                                    inc di
                                    dec cl
                                while nz | wend
                            pop cx
                            sub di,PlaneCount
                            shr dl,1 | shr dl,1 | shr dl,1 | shr dl,1
                            dec ch
                        while nz | wend
                        add di,PlaneCount
                        dec cl
                    while nz | wend
                pop cx
                dec ch
            while nz | wend
            dec cl
        while nz | wend
    wend

    mov si,ColorPattern
    mov cx,(Char_End-Char_Color)*CharHeight*PlaneCount
    do
        push cx
            mov ch,PlaneCount
            do
                mov al,[si] | inc si
                call MakeColorQ
                dec ch
            while nz | wend
            add di,CharPatternWidth*(PlaneCount-1)
        pop cx
    wloop

    mov si,SpritePattern
    mov di,SpritePatternQ
    mov cx,Pattern_End*SpriteHeight*PlaneCount
    do
        push cx
            mov ch,2
            do
                mov cl,PlaneCount
                do
                    mov al,[si] | inc si
                    call MakeColorQ
                    dec cl
                while nz | wend
                add di,3*PlaneCount
                dec ch
            while nz | wend
        pop cx
    wloop
ret

MakeColorQ: public MakeColorQ
    push cx
        mov ch,CharPatternWidth
        do
            xor ah,ah
            mov cl,8/CharPatternWidth
            do
                shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
                shl al,1
                if c
                    or ah,0fh
                endif
                dec cl
            while nz | wend
            mov [es:di],ah
            add di,PlaneCount
            dec ch
        while nz | wend
        add di,1-CharPatternWidth*PlaneCount
    pop cx
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
    push ax | push cx | push dx | push bx
        mov al,00h | out GRCG_Mode,al
        
        mov ax,VramSegment
        do
            mov es,ax
            xor bx,bx
            mov cx,bx
            do
                mov byte ptr[es:bx],0
                inc bx
            wloop
            add ax,1000h
            cmp ax,VramSegment+2000h
        while nz | wend

        mov bx,backup
        mov cx,VVramWidth*VVramHeight
        call Clear

        mov bx,VVram_
        mov cx,VVramWidth*VVramHeight/2
        call Clear
    pop bx | pop dx | pop cx | pop ax
ret

; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    push ax | push cx | push dx | push si | push di
        mov di,ax
        mov ax,VramSegment
        add di,di
        if c
            add ax,1000h
        endif
        mov es,ax

        mov al,AsciiPatternSize
        mul dl
        add ax,AsciiPatternW-AsciiPatternSize*' '
        mov si,ax

        mov cl,CharHeight
        do
            mov dx,[si] | inc si | inc si
            mov ch,4
            do
                mov al,AsciiColor and 0fh | out GRCG_Mode,al
                mov word ptr[es:di],0
                mov al,(not AsciiColor) and 0fh | out GRCG_Mode,al
                mov [es:di],dx
                add di,VramWidth*2
                if c
                    mov ax,es | add ax,1000h | mov es,ax
                endif
                dec ch
            while nz | wend
            dec cl
        while nz | wend
    pop di | pop si | pop dx | pop cx | pop ax
    inc ax
ret


cseg
Put:
; in
;   ax: pCharPattern
;   es:di: vram address
    push cx | push si
		mov si,ax
        push ds
            mov ax,PatternSegment | mov ds,ax
            mov cl,CharHeight
            do
                mov ch,CharPatternWidth
                do
                    mov al,80h | out GRCG_Mode,al
                    mov ah,PlaneCount
                    do
                        mov al,[si] | inc si
                        out GRCG_Tile,al
                        dec ah
                    while nz | wend
                    mov ah,4
                    do
                        mov es:[di],al
                        add di,VramWidth*2
                        if c
                            mov dx,es | add dx,1000h | mov es,dx
                        endif
                        dec ah
                    while nz | wend
                    sub di,VramWidth*2*PlaneCount-1
                    if c
                        mov dx,es | sub dx,1000h | mov es,dx
                    endif
                    dec ch
                while nz | wend
                add di,VramWidth*2*4-4
                if c
                    mov dx,es | add dx,1000h | mov es,dx
                endif
                dec cl
            while nz | wend
        pop ds
        sub di,VramWidth*2*CharHeight*4-4
        if c
            mov dx,es | sub dx,1000h | mov es,dx
        endif
    pop si | pop cx
ret

; word Put(word vram, byte c);
Put_: public Put_
    push ax | push dx | push di
	    mov di,ax
        mov ax,VramSegment
        add di,di
        if c
            add ax,1000h
        endif
        mov es,ax

        mov ah,dl | xor al,al
        shr ax,1
        add ax,CharPatternQ
		call Put
		mov ax,di
        shr ax,1
	pop di | pop dx | pop ax
    inc ax | inc ax
ret


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    push ax | push cx | push si | push di
        mov word ptr[pMixedPatternQ],MixedPatternQ

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
        mov bx,SpriteLayer+VVramWidth*1*2
		mov si,Backup
		mov di,(Vram+VramRowSize*1)*2
		mov ch,VVramHeight-2
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
                    mov ah,al | xor al,al
                    shr ax,1
                    add ax,CharPatternQ
					call Put
				else
					add di,VramStep*2
                    if c
                        mov dx,es | add dx,1000h | mov es,dx
                    endif
				endif
				EndDraw_next:
				inc si
				dec cl
			while nz | wend
			add di,(VramRowSize-VVramWidth*VramStep)*2
            if c
                mov dx,es | add dx,1000h | mov es,dx
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
        shr bl,1 ;y grid
        and bh,0feh ;x grid
		mov al,VVramWidth*2 | mul bl
		add al,bh
        add ax,SpriteLayer
        mov bx,ax ; bx=pSpriteLayer

        mov ah,cl ; pattern
        add ah,ah | xor al,al
        add ax,SpritePatternQ
        mov si,ax

        mov ax,PatternSegment | mov es,ax

		mov di,[pMixedPatternQ]
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
						add si,16-256
						inc bx | inc bx
						dec cl
					while nz | wend
					add bx,(VVramWidth-2)*2
					add si,256-32
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
                            add si,-256
                        pop bx
                        inc bx | inc bx
                        push bx
                            call SourceBX
                            mov ch,CharHeight
                            do
                                call MixCenter
                                dec ch
                            while nz | wend
                            add si,-256
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
						; add si,-8
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
                    add si,16-256/2
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add bx,(VVramWidth-2)*2
                add si,256/2-16*2
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
                    add si,16-256
                    inc bx | inc bx
                    dec cl
                while nz | wend
                add bx,(VVramWidth-2)*2
                add si,256-16*2
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
                    add si,16-256/2
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
				pop bx
                add si,-256/2
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
				pop bx
                add si,-256/2
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
                add si,-256
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
                add si,-256
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
                                _deb: public _deb
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
				pop bx
                add si,-256/2
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
				pop bx
                add si,-256/2
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
		mov [pMixedPatternQ],di
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret

SourceBX:
    mov ax,[bx]
	mov [bx],di
	or ah,ah
	if z
        mov ah,al | xor al,al
        shr ax,1
		add ax,CharPatternQ
	endif
	mov bx,ax
ret
MixW:
    xor dx,dx
    mov cl,PlaneCount
    do
        or dl,[es:si] | or dh,[es:si+PlaneCount]
        inc si
        dec cl
    while nz | wend
    not dx
    sub si,PlaneCount

    mov cl,PlaneCount
    do
        mov al,[es:bx] | mov ah,[es:bx+PlaneCount] | inc bx
        and ax,dx
        or al,[es:si] | or ah,[es:si+PlaneCount] | inc si
        mov [es:di],al | mov [es:di+PlaneCount],ah | inc di
        dec cl
    while nz | wend
    add bx,PlaneCount
    add si,PlaneCount
    add di,PlaneCount
ret
CopyW:
    mov cl,PlaneCount
    do
        mov ax,[es:bx] | inc bx | inc bx
        mov [es:di],ax | inc di | inc di
        dec cl
    while nz | wend
ret
MixStraight:
    call MixW
    call MixW
    add si,CharPatternWidth*PlaneCount
ret
MixLeft:
    call CopyW
    call MixW
    add si,CharPatternWidth*3/2*PlaneCount
ret
MixCenter:
    add si,PlaneCount*CharPatternWidth/2
    call MixW
    call MixW
    add si,PlaneCount*CharPatternWidth/2
ret
MixRight:
    add si,CharPatternWidth*3/2*PlaneCount
    call MixW
    call CopyW
ret
CopyBackground:
    mov cl,CharPatternWidth*PlaneCount/2
    do
		mov ax,[es:bx] | inc bx | inc bx
		mov [es:di],ax | inc di | inc di
        dec cl
    while nz | wend
ret
