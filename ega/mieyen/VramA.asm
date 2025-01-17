include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

SequencerPort equ 3c4h
MapMaskRegister equ 02h

GraphicsPort equ 3ceh
EnableSetResetRegister equ 01h
ColorCompareRegister equ 02h
DataRotateRegister equ 03h
ModeRegister equ 05h
BitMaskRegister equ 08h

CharPatternSize equ PlaneCount*CharHeight
SpritePatternSize equ CharPatternSize*4
Top equ VramRowSize*1


dseg
wVramSegment:
	defw 0
pBackup:
	defw 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
CharRam: public CharRam
    defs CharPatternSize*Char_End


cseg
ColorSource:
defb 64,15 ;Ascii
defb 16,11 ;Logo
defb 16,9 ;Wall
defb 4,14 ;Dot
defb 0
InitVram: public InitVram
    mov ax,000dh | int 10h ; Set video mode
    mov ax,0500h | int 10h ; Select active display page

    mov si,MonoPattern
    mov di,CharRam
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


MakePatternMono: public MakePatternMono
;   di: destination
;   si: source
;   dl: color
;   ch: count
    do
        mov cl,CharHeight
        do
            push cx
                mov al,[si] | inc si
                mov dh,dl
                mov cl,PlaneCount
                do
                    xor ah,ah
                    test dh,01h
                    if nz
                        or ah,al
                    endif
                    test dh,10h
                    if nz
                        not al
                        or ah,al
                        not al
                    endif
                    mov [di],ah | inc di
                    shr dh,1
                    dec cl
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
    push ax | push bx | push cx | push dx
        mov dx,SequencerPort
        mov ax,(0fh shl 8) or MapMaskRegister
        out dx,ax

        mov ax,VramSegment0 | mov es,ax
        do
            xor ax,ax
            xor bx,bx
            do
                mov [es:bx],ax
                inc bx | inc bx
                cmp bx,VramRowSize*VramHeight
            while nz | wend
            mov ax,es
            add ax,VramSegment1-VramSegment0
            mov es,ax
            cmp ax,VramSegment1+VramSegment1-VramSegment0
        while nz | wend

		mov bx,Backup
		mov cx,VVramWidth*VVramHeight
        call Clear

		mov bx,VVram_
		mov cx,VVramWidth*VVramHeight/2
        call Clear

		mov word ptr [pBackup],Backup1
		mov word ptr [wVramSegment],VramSegment1
        mov ax,0500h | int 10h
    pop dx | pop cx | pop bx | pop ax
ret


cseg
Put1:
;   al: char
;   es:di: vram address
    push cx | push dx | push di
        mov ah,CharPatternSize | mul ah
        add ax,CharRam
        mov si,ax

        mov dx,SequencerPort
        mov al,MapMaskRegister

        mov ch,CharHeight
        do
            mov ah,01h
            do
                out dx,ax
                mov cl,[si] | inc si
                mov [es:di],cl
                shl ah,1
                and ah,0fh
            while nz | wend        
            add di,VramWidth
            dec ch
        while nz | wend
    pop di | pop dx | pop cx
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
	push ax | push si | push di
	    mov di,ax
        mov ax,VramSegment0 | mov es,ax
        mov al,dl
        call Put1
        mov ax,VramSegment1 | mov es,ax
        mov al,dl
        call Put1
	pop di | pop si | pop ax
	add ax,VramStep
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push dx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov ax,[wVramSegment] | mov es,ax
        mov di,Top
		mov ch, VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
					push si
						call Put1
					pop si
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
	push ax | push cx
		mov ax,[wVramSegment]
		cmp ax,VramSegment0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [wVramSegment],VramSegment1
			xor al,al
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [wVramSegment],VramSegment0
			mov al,01h
		endif
		mov ah,05h
		int 10h
	pop cx | pop ax
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


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push cx | push dx | push bx | push si | push di
		xchg al,dl
		mov ch,VramWidth*4
		mul ch
		
        mov bl,dl ; x
		and bl,1
		shl bl,1 | shl bl,1
		shr dl,1
		xor dh,dh
		add ax,dx
		add ax,Top
		mov di,ax

		mov ah,cl
		xor al,al
        shr ax,1
		add ax,SpritePattern
		mov si,ax

        mov dx,GraphicsPort
        mov al,DataRotateRegister
        mov ah,bl
        out dx,ax

		mov cl,bl
		mov ch,16
		do
			push cx
				mov ch,2
				do
					mov bh,[si]
                    or bh,[si+1]
                    or bh,[si+2]
                    or bh,[si+3]
                    if nz
                        xor bl,bl
                        shr bx,cl
                        
                        mov dx,GraphicsPort
                        mov al,BitMaskRegister
                        mov ah,bh
                        out dx,ax

                        mov ah,01h
                        do
                            mov dx,SequencerPort
                            mov al,MapMaskRegister
                            out dx,ax

                            mov al,[es:di]
                            mov al,[si] | inc si
                            mov [es:di],al

                            shl ah,1
                            and ah,0fh
                        while nz | wend
                        sub si,4
                        inc di

                        mov dx,GraphicsPort
                        mov al,BitMaskRegister
                        mov ah,bl
                        out dx,ax

                        mov ah,01h
                        do
                            mov dx,SequencerPort
                            mov al,MapMaskRegister
                            out dx,ax

                            mov al,[es:di]
                            mov al,[si] | inc si
                            mov [es:di],al

                            shl ah,1
                            and ah,0fh
                        while nz | wend
                    else
                        add si,4
                        inc di
                    endif
					dec ch
				while nz | wend
			pop cx
			add di,VramWidth-2
			dec ch
		while nz | wend
        mov dx,GraphicsPort
        mov ax,BitMaskRegister or 0ff00h
        out dx,ax

        mov ax,DataRotateRegister
        out dx,ax
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret
