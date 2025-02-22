include "Pasogo.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern, SpritePattern
ext VVram_

CharPatternSize equ CharHeight
VramTop equ Vram+VramRowSize*1


dseg
Backup:
	defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs 2*VVramWidth*VVramHeight
pMixedPattern:
    defb 0,0
MixedPattern: public MixedPattern
	defs CharPatternSize*9*30


cseg
InitVram: public InitVram
    mov dx,ModeSelectA | mov al,3ah
    out dx,al | defb 0ebh,0

    mov dx,ModeSelectB | mov al,01h
    out dx,al | defb 0ebh,0

    mov ax,0400h or GpioControl
    out Vg230Index,ax | defb 0ebh,0
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
ClearScreen_:  public ClearScreen_
    push ax | push cx | push di
        mov ax,VramSegment | mov es,ax
        mov di,VramOrg
        xor ax,ax
        mov cx,4b00h
        do
            stosw
        wloop

		mov bx,Backup
		mov cx,VVramWidth*VVramHeight/2
        call Clear
    pop di | pop cx | pop ax
ret


cseg
Put: 
; in
;   ax: pPattern
;   di: vram address
    push cx | push si
        mov si,ax
        mov ch,2
        do
            mov cl,CharHeight/2
            do
                mov al,[si] | inc si
                mov [es:di],al
                add di,2000h
                dec cl
            while nz | wend
            add di,VramWidth-2000h*CharHeight/2
            dec ch
        while nz | wend
        add di,1-VramWidth*2
    pop si | pop cx
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
	push di
	    mov di,ax
        mov ax,VramSegment | mov es,ax
        mov al,CharPatternSize | mul dl
		add ax,CharPattern
        call Put
        mov ax,di
	pop di
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
        shr bl,1 | shr bl,1 ;y grid
        shr bh,1 | and bh,0feh ;x grid
		mov al,VVramWidth*2 | mul bl
		add al,bh
        add ax,SpriteLayer
        mov bx,ax ; bx=pSpriteLayer

        mov ah,cl ; pattern
        xor al,al
        shr ax,1 | shr ax,1
        add ax,SpritePattern
        mov si,ax

		mov di,[pMixedPattern]
		shl dl,1 | shl dh,1
		and dl,6 ; y
		if z
			and dh,6 ; x
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
											_deb:public _deb
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
							add si,-32
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
					pop dx
					dec dh
				while nz | wend
			endif
		else
            mov al,CharHeight | sub al,dl
            mov ah,4 | mul ah
            mov [vOffset],ax
			and dh,6 ; x
			if z
				mov cl,2
				do
					push bx | push dx | push si
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
					pop si | pop dx | pop bx
					inc si | inc si
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(VVramWidth-2)*2
				add si,-4
				add si,[vOffset]
				mov cl,2
				do
					push bx | push dx | push si
						call SourceBX
						mov ch,CharHeight
						do
							call MixStraight
							dec ch
						while nz | wend
					pop si | pop dx | pop bx
					inc si | inc si
					inc bx | inc bx
					dec cl
				while nz | wend
				add bx,(VVramWidth-2)*2
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
						mov ch,CharHeight | sub ch,dl
						do
							call CopyBackground
							dec ch
						while nz | wend
					pop si | pop bx
					inc si | inc si
					inc bx | inc bx
					dec cl
				while nz | wend
				add si,32-2*2
				dec ch
			else
				mov cl,dh

				push bx | push dx | push si
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
				pop si | pop dx | pop bx
                inc bx | inc bx
				push bx | push dx | push si
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
						call MixRight
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				add bx,(VVramWidth-2)*2
				; add si,-2
				add si,[vOffset]
				push bx | push dx | push si
					call SourceBX
					mov ch,CharHeight
					do
						call MixLeft
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				inc bx | inc bx
				push bx | push dx | push si
					call SourceBX
					mov ch,CharHeight
					do
						call MixCenter
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				; inc si | inc si
				inc bx | inc bx
				push bx | push dx | push si
					call SourceBX
					mov ch,CharHeight
					do
						call MixRight
						dec ch
					while nz | wend
				pop si | pop dx | pop bx
				add bx,(VVramWidth-2)*2
				add si,32
				push bx | push si
					push dx
						call SourceBX
						mov ch,dl
						do
							call MixLeft
							dec ch
						while nz | wend
					pop dx
					mov ch,CharHeight | sub ch,dl
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
					mov ch,CharHeight | sub ch,dl
					do
						call CopyBackground
						dec ch
					while nz | wend
				pop si | pop bx
				; inc si | inc si
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
					mov ch,CharHeight | sub ch,dl
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
		mov ah,CharPatternSize | mul ah
		add ax,CharPattern
	endif
	mov bx,ax
ret
CopyBackground:
	mov al,[bx] | inc bx
	mov [di],al | inc di
ret
MixStraight:
	mov al,[bx] | inc bx
	mov dx,[si]
    add si,4
	not dl | and al,dl
    or al,dh
	mov [di],al | inc di
ret
MixLeft:
	mov al,[bx] | inc bx
	mov dl,[si] | shr dl,cl
	not dl | and al,dl
	mov dl,[si+1] | shr dl,cl
    add si,4
	or al,dl
	mov [di],al | inc di
ret
MixCenter:
	mov al,[bx] | inc bx
    mov dh,[si] | mov dl,[si+2] | shr dx,cl
	not dl | and al,dl
    mov dh,[si+1] | mov dl,[si+3] | shr dx,cl
    add si,4
	or al,dl
	mov [di],al | inc di
ret
MixRight:
	mov al,[bx] | inc bx
    mov dh,[si+2] | xor dl,dl | shr dx,cl
	not dl | and al,dl
    mov dh,[si+3] | xor dl,dl | shr dx,cl
    add si,4
	or al,dl
	mov [di],al | inc di
ret
