include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern, LinePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ 4*2*16

dseg
Backup:
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*VVramHeight
pMixedPattern:
    defb 0,0
CharPattern: public CharPattern
    defs CharPatternSize*Char_End
MixedPattern: public MixedPattern
	defs CharPatternSize*9*32

cseg
ColorSource:
defb 64, 3 ; Ascii
defb 16, 1 ; Logo
defb 8, 3 ; Stair
defb 4, 3 ; Goal
defb 0
InitVram: public InitVram
    mov ax,0004h | int 10h ; Set video mode
    mov ax,0500h | int 10h ; Select active display page

    mov si,MonoPattern
    mov di,CharPattern
    mov bx,ColorSource
    do
        mov ch,[bx]
        or ch,ch
    while nz
        inc bx
        mov dl,[bx] | inc bx
        call MakePatternMono
    wend

    mov si,ColorPattern
    mov ch,Char_End-Char_Color
    call MakePatternColor
ret

MakePatternMono:
;   di: destination
;   si: source
;   dl: color
;   ch: count
    mov dh,dl
    shr dh,1 | shr dh,1 | shr dh,1 | shr dh,1
    do
        mov cl,CharHeight
        do
            push cx
                mov al,[si] | inc si
                mov ch,VramStep
                do
                    xor ah,ah
                    mov cl,8/VramStep
                    do
                        shl ah,1 | shl ah,1
                        shl al,1
                        if c
                            or ah,dl
                        else
                            or ah,dh
                        endif
                        dec cl
                    while nz | wend
                    mov [di],ah | inc di
                    dec ch
                while nz | wend
            pop cx
            dec cl
        while nz | wend
        dec ch
    while nz | wend
ret
MakePatternColor:
;   di: destination
;   si: source
;   ch: count
    do
        mov cl,CharPatternSize
        do
            mov al,[si] | inc si
            mov [di],al | inc di
            dec cl
        while nz | wend
        dec ch
    while nz | wend
ret


; void ClearScreen();
cseg
Clear:
    xor ax,ax 
    do
        mov [bx],ax
        inc bx | inc bx
    wloop
ret
ClearScreen_: public ClearScreen_
    push ax | push bx | push cx
        mov ax,VramSegment | mov es,ax
        xor ax,ax
        mov bx,0
        do
            mov [es:bx],ax
            inc bx | inc bx
            cmp bx,4000h
        while nz | wend
        
		mov bx,Backup
		mov cx,VVramWidth*VVramHeight/2
        call Clear

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
        call Clear
    pop cx | pop bx | pop ax
ret


cseg
Put:
; in
;   ax: pPattern
;   di: vram address
    push cx | push si
        mov si,ax
        mov cl,CharHeight/2
        do
            mov ax,[si] | inc si | inc si
            mov [es:di],ax
            mov ax,[si] | inc si | inc si
            mov [es:di+2000h],ax
            add di,VramWidth
            dec cl
        while nz | wend
    pop si | pop cx
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax
        mov al,CharPatternSize | mul dl
		add ax,CharPattern
        call Put
	pop di | pop ax
	inc ax | inc ax
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
		mov di,Vram+VramRowSize*1
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov ax,[bx] | inc bx | inc bx
                or ah,ah
                if nz
					mov byte ptr [si],0ffh
					call Put
                    sub di,VramWidth*CharHeight/2
					jmp EndDraw_next
				endif
				cmp al,[si]
				if ne
					mov [si],al
                    mov ah,CharPatternSize | mul ah
                    add ax,CharPattern
                    call Put
                    sub di,VramWidth*CharHeight/2
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
    push ax | push bx | push cx | push dx | push si | push di
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
                                call MixStraight
                                dec ch
                            while nz | wend
                            add si,2*2-2*2*2*CharHeight
                        pop cx | pop bx
                        inc bx | inc bx
                        dec cl
                    while nz | wend
                    add si,2*2*2*CharHeight-2*2*2
                    add bx,(VVramWidth-2)*2
                    dec ch
                while nz | wend
            else
                                    _deb: public _deb
                mov ch,2
                do
                    push bx
                        call SourceBX
                        mov cl,CharHeight
                        do
                            call MixLeft
                            dec cl
                        while nz | wend
                        add si,2-2*4*CharHeight
                    pop bx
                    inc bx | inc bx
                    push bx
                        call SourceBX
                        mov cl,CharHeight
                        do
                            call MixCenter
                            dec cl
                        while nz | wend
                        add si,2*2-2*4*CharHeight
                    pop bx
                    inc bx | inc bx
                    push bx
                        call SourceBX
                        mov cl,CharHeight
                        do
                            call MixRight
                            dec cl
                        while nz | wend
                        add si,-2*3
                    pop bx
                    add bx,(VVramWidth-2)*2
                    dec ch
                while nz | wend
            endif
        else
            test dh,1 ; x
            if z
                mov ch,2
                do
                    push bx
                        call SourceBX
                        mov cl,CharHeight/2
                        do
                            call CopyBackground
                            dec cl
                        while nz | wend
                        mov cl,CharHeight/2
                        do
                            call MixStraight
                            dec cl
                        while nz | wend
                    pop bx
                    add si,2*2-4*2*CharHeight/2
                    inc bx | inc bx
                    dec ch
                while nz | wend
                add si,2*4*CharHeight/2-2*4
                add bx,(VVramWidth-2)*2
                mov ch,2
                do
                    push bx
                        call SourceBX
                        mov cl,CharHeight
                        do
                            call MixStraight
                            dec cl
                        while nz | wend
                    pop bx
                    add si,2*2-4*2*CharHeight
                    inc bx | inc bx
                    dec ch
                while nz | wend
                add si,2*4*CharHeight-2*4
                add bx,(VVramWidth-2)*2
                mov ch,2
                do
                    push bx
                        call SourceBX
                        mov cl,CharHeight/2
                        do
                            call MixStraight
                            dec cl
                        while nz | wend
                        mov cl,CharHeight/2
                        do
                            call CopyBackground
                            dec cl
                        while nz | wend
                    pop bx
                    inc bx | inc bx
                    add si,2*2-4*2*CharHeight/2
                    dec ch
                while nz | wend
            else
                push bx
                    call SourceBX
                    mov cl,CharHeight/2
                    do
                        call CopyBackground
                        dec cl
                    while nz | wend
                    mov cl,CharHeight/2
                    do
                        call MixLeft
                        dec cl
                    while nz | wend
                pop bx
                add si,2-2*4*CharHeight/2
                inc bx | inc bx
                push bx
                    call SourceBX
                    mov cl,CharHeight/2
                    do
                        call CopyBackground
                        dec cl
                    while nz | wend
                    mov cl,CharHeight/2
                    do
                        call MixCenter
                        dec cl
                    while nz | wend
                pop bx
                add si,2*2-2*4*CharHeight/2
                inc bx | inc bx
                push bx
                    call SourceBX
                    mov cl,CharHeight/2
                    do
                        call CopyBackground
                        dec cl
                    while nz | wend
                    mov cl,CharHeight/2
                    do
                        call MixRight
                        dec cl
                    while nz | wend
                pop bx
                add si,-2*3
                add bx,(VVramWidth-2)*2
                push bx
                    call SourceBX
                    mov cl,CharHeight
                    do
                        call MixLeft
                        dec cl
                    while nz | wend
                pop bx
                add si,2-2*4*CharHeight
                inc bx | inc bx
                push bx
                    call SourceBX
                    mov cl,CharHeight
                    do
                        call MixCenter
                        dec cl
                    while nz | wend
                pop bx
                add si,2*2-2*4*CharHeight
                inc bx | inc bx
                push bx
                    call SourceBX
                    mov cl,CharHeight
                    do
                        call MixRight
                        dec cl
                    while nz | wend
                pop bx
                add si,-2*3
                add bx,(VVramWidth-2)*2
                push bx
                    call SourceBX
                    mov cl,CharHeight/2
                    do
                        call MixLeft
                        dec cl
                    while nz | wend
                    mov cl,CharHeight/2
                    do
                        call CopyBackground
                        dec cl
                    while nz | wend
                pop bx
                add si,2-2*4*CharHeight/2
                inc bx | inc bx
                push bx
                    call SourceBX
                    mov cl,CharHeight/2
                    do
                        call MixCenter
                        dec cl
                    while nz | wend
                    mov cl,CharHeight/2
                    do
                        call CopyBackground
                        dec cl
                    while nz | wend
                pop bx
                add si,2*2-2*4*CharHeight/2
                inc bx | inc bx
                push bx
                    call SourceBX
                    mov cl,CharHeight/2
                    do
                        call MixRight
                        dec cl
                    while nz | wend
                    mov cl,CharHeight/2
                    do
                        call CopyBackground
                        dec cl
                    while nz | wend
                pop bx                
            endif
        endif
        mov [pMixedPattern],di
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
ret

SourceBX:
    mov ax,[bx]
	mov [bx],di
	or ah,ah
	if z
		mov ah,CharPatternSize | mul ah
		add ax,CharPattern
	endif
	mov bx,ax
ret
MixByte:
    mov dx,[si] | inc si | inc si
    not dl
    mov al,[bx] | inc bx
    and al,dl
    or al,dh
    mov [di],al | inc di
ret
CopyByte:
    mov al,[bx] | inc bx
    mov [di],al | inc di
ret
CopyBackground:
    mov ax,[bx] | inc bx | inc bx
    mov [di],ax | inc di | inc di
ret
MixStraight:
    mov ah,2
    do
        call MixByte
        dec ah
    while nz | wend
    add si,2*2
ret
MixLeft:
    call CopyByte
    call MixByte
    add si,2*3
ret
MixCenter:
    mov ah,2
    do
        call MixByte
        dec ah
    while nz | wend
    add si,2*2
ret
MixRight:
    call MixByte
    call CopyByte
    add si,2*3
ret
