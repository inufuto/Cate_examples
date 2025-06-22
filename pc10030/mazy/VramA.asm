include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext VVram_

CharPatternSize equ VramStep*CharHeight*PlaneCount
SpritePatternSize equ 4*CharHeight*2*(1+PlaneCount)
Top equ 0

dseg
currentSegment:
    defw 0
pBackup:
	defw 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
CharPatternW: public CharPatternW
	defs CharPatternSize*Char_End

cseg
PaletteValues:
defb	00h, 00h, 8ah, 01h, 07h, 00h, 0a7h, 01h
defb	38h, 00h, 0fdh, 01h, 3fh, 00h, 0ffh, 01h
defb	00h, 00h, 0dbh, 00h, 54h, 00h, 0deh, 00h
defb	18h, 00h, 10h, 01h, 2eh, 01h, 6dh, 01h
ColorTable:
defb 64, 7h ; Ascii
defb 1, 5h ; Wall
defb 4, 7h ; Goal
defb 4, 6h ; Bang
defb 4, 7h ; M
defb 4, 3h ; A
defb 4, 6h ; Z
defb 4, 0bh ; Y
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
		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax
			add bx,2
		wloop

		xor ax,ax 
		mov bx,backup
		mov cx,VVramWidth*VVramHeight
		do
			mov [bx],ax
			add bx,2
		wloop

		mov word ptr [pBackup],Backup1
		mov word ptr [currentSegment],VramSegment1
		mov al,0ffh | out 3eh,al
	pop cx | pop bx | pop ax
ret


cseg
Put1:
; in
;   al: char
;   es: vram segment
;   di: vram offset
    push ax
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
        sub di,VramWidth*2*CharHeight
    pop ax
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push cx | push si | push di
        mov di,ax
        mov ax,VramSegment0 | mov es,ax
        mov al,dl
        call Put1
        
        mov ax,VramSegment1 | mov es,ax
        mov al,dl
		call Put1
	pop di | pop si | pop cx | pop ax
	add ax,VramStep
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov di,Vram+VramRowSize*Top
		mov ax,[currentSegment] | mov es,ax
		mov ch, VVramHeight ; vertical count
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					push cx | push si
						call Put1
					pop si | pop cx
				endif
				add di,VramStep
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
		mov ah,[currentSegment+1]
		cmp ah,high VramSegment0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [currentSegment],VramSegment1
			mov al,0ffh
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [currentSegment],VramSegment0
			mov al,0ffh xor 02h
		endif
		out 3eh,al
	pop ax
ret
