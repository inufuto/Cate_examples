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
TopY equ 1
XResolution equ 640
SpriteTopY equ (30-VramHeight)*CharHeight/2+TopY*CharHeight

dseg
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
CharPatternW:
    defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
	defs SpritePatternSize*Pattern_End
pBackup:
	defw 0
MaskShift:
    defw 0

cseg
PaletteTable:
defb	00h, 00h, 00h, 00h, 9ch, 0ffh, 0ffh, 00h
defb	00h, 0ffh, 9ch, 5ah, 00h, 0ffh, 00h, 00h
defb	0deh, 0deh, 0ffh, 0ffh, 00h, 0ffh, 0ffh, 0ffh
defb	00h, 00h, 00h, 9ch, 5ah, 00h, 0ffh, 0bdh
defb	5ah, 0bdh, 5ah, 5ah, 0bdh, 7bh, 00h, 00h
defb	5ah, 0bdh, 0ffh, 0deh, 9ch, 0bdh, 0bdh, 0bdh
ColorTable:
defb 64, 7 ; Ascii
defb 15, 14 ; Logo
defb 2, 14 ; Ladder
defb 4, 6 ; Item
defb 0
InitVram: public InitVram
    mov ax,300ch
    mov bh,32h
    int 18h

    mov al,21h | out 6Ah,al
    mov al,0dh | out 0A2h,al

    mov ax,PortSegment | mov es,ax
    mov byte ptr [es:0100h],0

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

UpdatePaletteElement:
    mov al,ch | out PalettePort,al
    mov al,[bx+1] | out PalettePort+2,al ; G
    mov al,[bx+0] | out PalettePort+4,al ; R
    mov al,[bx+2] | out PalettePort+6,al ; B
    inc ch
ret
UpdatePalette0:
    mov cx,16
    do
        mov bx,PaletteTable
        mov ah,16
        do
            call UpdatePaletteElement
            add bx,3
            dec ah
        while nz | wend
        dec cl
    while nz | wend
ret
UpdatePalette1:
    mov bx,PaletteTable
    mov cx,16
    do
        mov ah,16
        do
            call UpdatePaletteElement
            dec ah
        while nz | wend
        add bx,3
        dec cl
    while nz | wend
ret
WaitVBlank:
    do
        in al,0a0h
        test al,20h
    while nz | wend
    do
        in al,0a0h
        test al,20h
    while z | wend
ret

; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    push ax | push bx | push cx
        cmp byte ptr [MaskShift],0
        if z
            call WaitVBlank
            call UpdatePalette0
            mov ax,Backup1
            mov cx,0f04h
        else
            call WaitVBlank
            call UpdatePalette1
            mov ax,Backup0
            mov cx,0f000h
        endif
        mov [pBackup],ax
        mov [MaskShift],cx
    pop cx | pop bx | pop ax
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
		inc bx | inc bx
	wloop
ret
ClearScreen_: public ClearScreen_
    push ax | push dx | push bx
        xor dx,dx
        do
            call WriteBank
            xor bx,bx
            mov ax,bx
            do
                mov [es:bx],ax
                inc bx | inc bx
            while nz | wend
            inc dx | inc dx
            cmp dx,10
        while nz | wend

        mov bx,Backup0
        mov cx,VVramWidth*VVramHeight
        call Clear

        mov bx,VVram_
        mov cx,VVramWidth*VVramHeight/2
        call Clear

        mov word ptr [pBackup],Backup1
        mov word ptr [MaskShift],0f04h
        call UpdatePalette0
    pop bx | pop dx | pop ax
ret


cseg
PutHorz:
    mov cl,CharWidth
    do
        mov al,[si] | inc si
        mov ah,al
        shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
        or al,ah
        mov ah,al
        mov [es:di],ax
        add di,2
        if c
            inc dx | inc dx
            call WriteBank
        endif
        dec cl
    while nz | wend
    add di,XResolution-CharWidth*2
    if c
        inc dx | inc dx
        call WriteBank
    endif
ret
Put: ; (si=pCharPattern, es:di=destination, dx=bank)
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
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
        mov bx,VVram_
		mov si,[pBackup]
		mov di,(Vram+VramRowSize*TopY)*VramRate
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
                        push bx | push cx
                            mov cx,[MaskShift]
                            mov bh,CharHeight
                            do
                                call VVHorz
                                sub si,CharWidth
                                call VVHorz
                                dec bh
                            while nz | wend
                        pop cx | pop bx
                        sub di,XResolution*CharHeight*2-VramRate
                        if c
                            dec dx | dec dx
                            call WriteBank
                        endif
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
			add di,XResolution*CharHeight*2-VramRate*VVramWidth
            if c
                inc dx | inc dx
                call WriteBank
            endif
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret
VVHorz:
    mov bl,CharWidth
    do
        mov al,[si] | inc si
        shl al,cl
        mov ah,[es:di]
        and ah,ch
        or al,ah
        mov ah,al
        mov [es:di],ax
        add di,2
        if c
            inc dx | inc dx
            call WriteBank
        endif
        dec bl
    while nz | wend
    add di,XResolution-CharWidth*2
    if c
        inc dx | inc dx
        call WriteBank
    endif
ret



; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
	push ax | push dx | push cx | push bx
		mov cx,0202h
		test al,7
		if nz
			inc ch
		endif
		shr al,1 | shr al,1 | shr al,1
		mov bl,al
		xor bh,bh
		
		test dl,7
		if nz
			inc cl
		endif
		shr dl,1 | shr dl,1 | shr dl,1

		mov al,VVramWidth
		mul dl
		add ax,bx
		add ax,Backup0
		mov bx,ax

		mov al,0ffh
		do
			push bx
				mov ah,ch
				do
					mov [bx],al
					mov [bx+Backup1-Backup0],al
					inc bx
					dec ah
				while nz | wend
			pop bx
			add bx,VVramWidth
			dec cl
		while nz | wend
 	pop bx | pop cx | pop dx | pop ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
    push ax | push cx | push dx | push bx | push si | push di
        mov bl,al ; x
        mov al,dl ;y
        add al,SpriteTopY
        xor ah,ah
        mov dx,XResolution*2 | mul dx
        xor bh,bh | shl bx,1
        add ax,bx | adc dx,0
        mov di,ax
        shl dx,1
        call WriteBank

        mov ah,cl ; pattern
        xor al,al
        add ax,SpritePatternW
        mov si,ax

        mov cx,[MaskShift]

        mov bh,SpriteHeight
        do
            call SpriteHorz
            sub si,SpriteWidth
            call SpriteHorz
            dec bh
        while nz | wend
    pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret
SpriteHorz:
    mov bl,SpriteWidth
    do
        mov al,[si] | inc si
        or al,al
        if nz
            shl al,cl
            mov ah,[es:di]
            and ah,ch
            or al,ah
            mov ah,al
            mov [es:di],ax
        endif
        add di,2
        if c
            inc dx | inc dx
            call WriteBank
        endif
        dec bl
    while nz | wend
    add di,XResolution-SpriteWidth*2
    if c
        inc dx | inc dx
        call WriteBank
    endif
ret