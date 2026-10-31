include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern,ColorPattern
ext VVram_

VramSegment equ 0b800h

TopY equ 0
CharPatternSize equ VramStep*CharHeight

dseg
Backup:
	defs VVramWidth*VVramHeight
ColoredPattern: public ColoredPattern
    defs CharPatternSize*Char_Color

cseg
ColorSource:
defb 64, 15 ; Ascii
defb 1, 11 ; Wall
defb 4, 15 ; Goal
defb 4, 14 ; Bang
defb 4, 15 ; M
defb 4, 13 ; A
defb 4, 14 ; Z
defb 4, 12 ; Y
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
		mov cx,VVramWidth*VVramHeight/2
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


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
        mov ax,VramSegment | mov es,ax
        mov bx,VVram_
		mov si,Backup
		mov di,Vram+VramRowSize*TopY
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[bx] | inc bx
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
				VVramToVram_next:
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-VVramWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret
