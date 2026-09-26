include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext VVram_

VramSegment equ 0a800h
PortSegment equ 0e000h

PalettePort equ 0a8h

CharPatternSize equ CharWidth*CharHeight
VramRate equ 16

dseg
Backup:
	defs VVramWidth*VVramHeight
CharPatternW:
    defs CharPatternSize*Char_End

cseg
PaletteTable:
defb	00h, 00h, 00h, 5fh, 3fh, 0dfh, 0ffh, 00h
defb	00h, 0ffh, 9fh, 0dfh, 00h, 0ffh, 00h, 0bfh
defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 0ffh, 0ffh, 0ffh
defb	00h, 00h, 00h, 7fh, 7fh, 7fh, 9fh, 5fh
defb	3fh, 0dfh, 7fh, 7fh, 00h, 7fh, 00h, 00h
defb	5fh, 9fh, 0dfh, 0bfh, 9fh, 0bfh, 0bfh, 0bfh
ColorTable:
defb 64, 7 ; Ascii
defb 1, 5 ; Wall
defb 4, 7 ; Goal
defb 4, 6 ; Bang
defb 4, 7 ; M
defb 4, 3 ; A
defb 4, 6 ; Z
defb 4, 11 ; Y
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


; void VVramToVram();
cseg
Put1:
    call Put
    sub di,640*CharHeight*2-VramRate
    if c
        dec dx | dec dx
        call WriteBank
    endif
ret
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
        mov bx,VVram_
		mov si,Backup
		mov di,(Vram+VramRowSize*0)*VramRate
        mov dx,0
        call WriteBank        
		mov ch,VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[bx] | inc bx
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
				VVramToVram_next:
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
