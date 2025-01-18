include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern,ColorPattern,SpritePattern
ext VVram_


PagePort equ 3dfh
CharPatternSize equ VramStep*CharHeight
SpritePatternSize equ CharPatternSize*4

dseg
CharRam: public CharRam
    defs CharPatternSize*Char_End
CurrentPage:
    defw 0
pBackup:
	defw 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight

cseg
ColorSource:
defb 64,15 ;Ascii
defb 16,11 ;Logo
defb 16,9 ;Wall
defb 4,14 ;Dot
defb 0
InitVram: public InitVram
    mov ax,0009h | int 10h ; SET MODE

    mov si,MonoPattern
    mov di,CharRam
    mov bx,ColorSource
    do
        mov cl,[bx]
        or cl,cl
    while nz
        inc bx
        mov dl,[bx] | inc bx
        call MakePatternMono
    wend

	mov ax,ds | mov es,ax
    mov di,CharRam+CharPatternSize*Char_Color
	mov si,ColorPattern
	mov cx,CharPatternSize*(Char_End-Char_Color)/2
	do | movsw | wloop
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
Clear:
	xor ax,ax 
	do
		mov [bx],ax
		inc bx | inc bx
	wloop
ret
ClearScreen_:  public ClearScreen_
	push ax | push cx | push dx | push bx
		mov ax,VramSegment0 | mov es,ax
		xor ax,ax
        mov bx,0
		do
            mov es:[bx],ax
            inc bx | inc bx
		while ne | wend

		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		call Clear

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
		call Clear

        mov word ptr [CurrentPage],VramSegment1
        mov word ptr [pBackup],Backup1
        mov dx,PagePort | mov al,0ffh | out dx,al
	pop bx | pop dx | pop cx | pop ax
ret


cseg
Put1:
; in
;   al: char
;   es:di: vram address
    push cx
        mov ah,CharPatternSize | mul ah
        add ax,CharRam
        mov si,ax
        mov ch,2
        do
            mov cl,4
            do
                movsw
                movsw
                add di,2000h-4
                dec cl
            while nz | wend
            add di,VramWidth-2000h*4
            dec ch
        while nz | wend
    pop cx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push si | push di
	    mov di,ax
        mov ax,VramSegment0 | mov es,ax
		mov al,dl
		push ax | push di
			call Put1
            mov ax,VramSegment1 | mov es,ax
		pop di | pop ax
        call Put1
	pop di | pop si | pop ax
	add ax,VramStep
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
        mov ax,[CurrentPage] | mov es,ax
		mov bx,VVram_
		mov si,[pBackup]
		mov di,Vram+VramRowSize
		mov ch, VVramHeight ; vertical count
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					push si | push di
						call Put1
					pop di | pop si
				endif
				add di,VramStep
				inc si
				dec cl
			while nz | wend
			add di,VramWidth*2-VVramWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret 


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
	push ax | push dx
		mov ax,[CurrentPage]
		cmp ax,VramSegment0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [CurrentPage],VramSegment1
			mov al,0fdh
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [CurrentPage],VramSegment0
            mov al,0ffh
		endif
        mov dx,PagePort | out dx,al
	pop dx | pop ax
ret


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
	push ax | push cx | push bx
		mov bl,al
		xor bh,bh
		
		mov al,VVramWidth
		mul dl
		add ax,bx
		add ax,Backup0
		mov bx,ax

		mov cl,2
		mov al,0ffh
		do
			mov ah,2
			do
				mov [bx],al
				mov [bx+Backup1-Backup0],al
				inc bx
				dec ah
			while nz | wend
			add bx,VVramWidth-2
			dec cl
		while nz | wend
 	pop bx | pop cx | pop ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push cx | push dx | push bx | push si | push di
        xchg al,dl
        mov ah,VramWidth
        mul ah
		shl ax,1
        xor dh,dh
        shl dx,1 | shl dx,1
        add ax,dx
		add ax,VramRowSize
        mov di,ax
        mov ax,[CurrentPage]
        mov es,ax

        mov ah,cl
        xor al,al
        shr ax,1
        add ax,SpritePattern
        mov si,ax
        
        mov ch,16
        do
            mov cl,16/2
            do
                mov al,[si] | inc si
				or al,al
                mov dl,0ffh
                test al,0f0h
                if nz
                    and dl,0fh
                endif
                test al,0fh
                if nz
                    and dl,0f0h
                endif
                mov ah,[es:di]
                and ah,dl
                or al,ah
                mov [es:di],al | inc di
                dec cl
            while nz | wend
            mov ax,di
            add ax,2000h-16/2
            test ah,80h
            if nz
                and ah,7fh
                add ax,VramWidth
            endif
            mov di,ax
            dec ch
        while nz | wend
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret
