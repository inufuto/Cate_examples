include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

CharPatternSize equ VramStep*CharHeight*PlaneCount
SpritePatternSize equ 4*CharHeight*2*(1+PlaneCount)
Top equ 1

dseg
nextSegment:
    defw 0
pBackup:
	defw 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
	defs VVramWidth
CharPatternW: public CharPatternW
	defs CharPatternSize*Char_End
SpritePatternW: public SpritePatternW
	defs SpritePatternSize*Pattern_End

cseg
PaletteValues:
defb	00h, 00h, 0c0h, 01h, 07h, 00h, 0c7h, 01h
defb	38h, 00h, 0f8h, 01h, 3fh, 00h, 0ffh, 01h
defb	00h, 00h, 00h, 01h, 04h, 00h, 10h, 00h
defb	20h, 00h, 0e0h, 01h, 27h, 00h, 24h, 01h
ColorTable:
defb 31, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
    mov ax,0ffffh | out 60h,ax ; color mode
    xor al,al
    out 30h,al ; shift
    out 1ah,al ; mask low
    out 18h,al ; mask high

    mov dx,40h
    mov bx,PaletteValues
    mov cl,16
    do
        mov ax,[bx]
        inc bx | inc bx
        out dx,ax
        inc dx | inc dx
        dec cl
    while nz | wend

	mov di,CharPatternW

    mov si,MonoPattern
    mov bx,ColorTable
    do
        mov cl,[bx]
        or cl,cl
    while nz
        inc bx
        mov ch,[bx]
        inc bx
        do
            push bx | push cx
                mov cl,CharHeight
                do
                    push cx
                        mov al,[si] | inc si
                        call DoubleBits
                        mov al,ch
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
                            mov [di],bx | inc di | inc di
                            shr al,1
                            dec cl
                        while nz | wend
                    pop cx
                    dec cl
                while nz | wend
            pop cx | pop bx
            dec cl
        while nz | wend
    wend

    mov si,ColorPattern
    mov cx,(Char_End-Char_Color)*CharHeight*PlaneCount
    do
        mov al,[si] | inc si
        call DoubleBits
        mov [di],dx | inc di | inc di
    wloop

	mov di,SpritePatternW
	mov si,SpritePattern
	mov cx,160*Pattern_End
	do
		mov al,[si] | inc si
		call DoubleBits
		mov [di],dx | inc di | inc di
	wloop
ret

DoubleBits:
	push cx
		xor dx,dx
		mov ch,8
		do
			shr dx | shr dx
			shr al,1
			if b
				or dx,0c000h
			endif
			dec ch
		while ne | wend
	pop cx
ret


; void ClearScreen();
cseg
ClearScreen_:  public ClearScreen_
	push ax | push bx | push cx
        mov ax,VramSegment0 | mov es,ax
        mov al,0fh | out 1ch,al
        do
            xor ax,ax
            xor bx,bx
            do
				mov es:[bx],ax
                inc bx | inc bx
            while nz | wend
			mov ax,es
			add ah,10h
			mov es,ax
            cmp ah,(high VramSegment1)+10h
        while nz | wend

		xor ax,ax 
		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax
			inc bx | inc bx
		wloop

		xor ax,ax 
		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax
			inc bx | inc bx
		wloop

		mov word ptr [pBackup],Backup1
		mov word ptr [nextSegment],VramSegment1
		mov al,0ffh | out 3eh,al
	pop cx | pop bx | pop ax
ret


cseg
Put:
; in
;   al: char
;   di: vram address
    push cx | push si
        mov ah,CharPatternSize | mul ah
        add ax,CharPatternW
        mov si,ax

        mov ch,CharHeight
        do
            mov cl,1
            do
                mov al,cl | out 1ch,al
                mov ax,[si] | inc si | inc si
                mov es:[di],ax
                mov es:[di+VramWidth],ax
                shl cl,1
                test cl,10h
            while z | wend
            add di,VramWidth*2
            dec ch
        while ne | wend
        add di,VramStep-VramRowSize
    pop si | pop cx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push di
        mov di,ax
        mov ax,VramSegment0 | mov es,ax
        mov al,dl
        call Put
		dec di | dec di
        mov ax,VramSegment1 | mov es,ax
        mov al,dl
		call Put
		mov ax,di
	pop di
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACDEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
	push bx | push di
		mov di,ax
		mov bx,CharTable
		mov ax,31 shl 8
		do
			cmp dl,[bx]
			jz PrintC_break
			inc bx
			inc al
			dec ah
		while nz | wend
		xor al,al
		PrintC_break:
		mov bl,al
        mov ax,VramSegment0 | mov es,ax
        mov al,bl
        call Put
		dec di | dec di
        mov ax,VramSegment1 | mov es,ax
        mov al,bl
		call Put
		mov ax,di
	pop di | pop bx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov di,Vram
		mov ax,[nextSegment] | mov es,ax
		mov ch, VVramHeight ; vertical count
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					call Put
				else
					inc di | inc di
				endif
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-VVramWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop dx | pop cx | pop ax
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
	push ax
		mov ah,[nextSegment+1]
		cmp ah,high VramSegment0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [nextSegment],VramSegment1
			mov al,0ffh
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [nextSegment],VramSegment0
			mov al,0ffh xor 02h
		endif
		out 3eh,al
	pop ax
ret


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
	push ax | push dx | push cx | push bx
		mov cx,0202h
		test al,1
		if nz
			inc ch
		endif
		shr al,1
		mov bl,al
		xor bh,bh
		
		test dl,1
		if nz
			inc cl
		endif
		shr dl,1

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


cseg
PrepareSprite:
	mov ch,al ;x
	mov ah,dl
	shl ah,1 | shl ah,1
	add ax,Vram
	mov di,ax

	mov ax,[nextSegment] | mov es,ax

    mov al,SpritePatternSize/2 | mul cl
    add ax,ax
    add ax,SpritePatternW
    mov si,ax
ret

; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
	push ax | push cx | push dx | push si | push di
		call PrepareSprite

		and ch,1
		if z
			mov cl,8
			do
                mov ax,[si] | inc si | inc si
                not ax
                out 1ah,al ; mask low
                mov al,ah | out 18h,al ; mask high
                mov dx,0100h or PlaneCount
                do
                    mov al,dh | out 1ch,al
                    mov ax,[si] | inc si | inc si
                    mov [es:di],ax
                    mov [es:di+VramWidth],ax
                    shl dh,1
                    dec dl
                while nz | wend
                add si,10
				add di,VramWidth*2
				dec cl
			while nz | wend
		else
			mov cl,8
			do
                mov ax,[si] | inc si | inc si
                not ax
                out 18h,al ; mask high
                mov al,ah | out 1ah,al ; mask low
                mov dx,0100h or PlaneCount
                do
                    mov al,dh | out 1ch,al
                    mov ax,[si] | inc si | inc si
                    mov [es:di],ax
                    mov [es:di+VramWidth],ax
                    shl dh,1
                    dec dl
                while nz | wend
                add si,10
				add di,VramWidth*2
				dec cl
			while nz | wend
		endif
		xor al,al
		out 1ah,al ; mask low
		out 18h,al ; mask high
	pop di | pop si | pop dx | pop dx | pop ax
ret

; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
	push ax | push cx | push dx | push si | push di
		call PrepareSprite

		and ch,1
		if z
			mov cl,16
			do
				mov ch,2
				do
                                        _deb: public _deb
					mov ax,[si] | inc si | inc si
					not ax
					out 1ah,al ; mask low
					mov al,ah | out 18h,al ; mask high
                    mov dx,0100h or PlaneCount
                    do
                        mov al,dh | out 1ch,al
                        mov ax,[si] | inc si | inc si
                        mov [es:di],ax
                        mov [es:di+VramWidth],ax
                        shl dh,1
                        dec dl
                    while nz | wend
					inc di | inc di
					dec ch
				while nz | wend
				add di,VramWidth*2-2*2
				dec cl
			while nz | wend
		else
			mov cl,16
			do
				mov ch,2
				do
					mov ax,[si] | inc si | inc si
					not ax
					out 18h,al ; mask high
					mov al,ah | out 1ah,al ; mask low
                    mov dx,0100h or PlaneCount
                    do
                        mov al,dh | out 1ch,al
                        mov ax,[si] | inc si | inc si
                        mov [es:di],ax
                        mov [es:di+VramWidth],ax
                        shl dh,1
                        dec dl
                    while nz | wend
					inc di | inc di
					dec ch
				while nz | wend
				add di,VramWidth*2-2*2
				dec cl
			while nz | wend
		endif
		xor al,al
		out 1ah,al ; mask low
		out 18h,al ; mask high
	pop di | pop si | pop dx | pop dx | pop ax
ret
