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
SpritePatternSize equ (1+PlaneCount)*2*16

dseg
NextVramSegment:
	defw 0
pBackup:
	defw 0
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
    defs VVramWidth
CharRam: public CharRam
    defs CharPatternSize*Char_End


cseg
ColorSource:
defb 31,15 ;Ascii
defb 15,11 ;Logo
defb 1,15 ;Remain
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

    mov ax,ds | mov es,ax
    mov si,ColorPattern
    mov di,CharRam+CharPatternSize*Char_Color
    mov cx,CharPatternSize*(Char_End-Char_Color)/2
    do
        movsw
    wloop
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
		mov word ptr [NextVramSegment],VramSegment1
        mov ax,0500h | int 10h
    pop dx | pop cx | pop bx | pop ax
ret


cseg
Put:
;   al: char
;   es:di: vram address
    push cx | push dx | push si
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
    pop si | pop dx | pop cx
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
	push di
	    mov di,ax
        mov ax,VramSegment0 | mov es,ax
        mov al,dl
        call Put
        add di,-VramWidth*CharHeight
        mov ax,VramSegment1 | mov es,ax
        mov al,dl
        call Put
        add di,1-VramWidth*CharHeight
        mov ax,di
	pop di
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKLMNOPRSTUVY"
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
        add di,-VramWidth*CharHeight
        mov ax,VramSegment1 | mov es,ax
        mov al,bl
        call Put
        add di,1-VramWidth*CharHeight
        mov ax,di
	pop di | pop bx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
	push ax | push cx | push bx | push si | push di
		mov bx,VVram_
		mov si,[pBackup]
		mov ax,[NextVramSegment] | mov es,ax
        mov di,Vram
		mov ch, VVramHeight
		do
			mov cl,VVramWidth
			do 
				mov al,[bx]
				inc bx
				cmp al,[si]
				if ne
					mov [si],al
                    call Put
                    add di,1-VramWidth*CharHeight
                else
                    inc di
				endif
				inc si
				dec cl
			while nz | wend
			add di,VramRowSize-VVramWidth*VramStep
			dec ch
		while nz | wend
	pop di | pop si | pop bx | pop cx | pop ax
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
	push ax | push cx
		mov ax,[NextVramSegment]
		cmp ax,VramSegment0
		if z
			mov word ptr [pBackup],Backup1
			mov word ptr [NextVramSegment],VramSegment1
			xor al,al
		else
			mov word ptr [pBackup],Backup0
			mov word ptr [NextVramSegment],VramSegment0
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


PrepareSprite:
    mov bl,al ; x
    xchg al,dl
    mov ch,VramWidth*4
    mul ch
    shr dl,1
    xor dh,dh
    add ax,dx
    ; add ax,Vram
    mov di,ax

    mov al,SpritePatternSize | mul cl
    add ax,SpritePattern
    mov si,ax
ret

; void DrawSprite1(byte x, byte y, byte pattern);
cseg
DrawSprite1_: public DrawSprite1_
	push ax | push cx | push dx | push bx | push si | push di
        call PrepareSprite
        and bl,1
        if z
            mov cl,8
            do
                mov ah,[si] | inc si ; mask
                or ah,ah
                if nz
                    mov dx,GraphicsPort
                    mov al,BitMaskRegister
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
                    add si,PlaneCount
                endif
                add si,1+PlaneCount
                add di,VramWidth
                dec cl
            while nz | wend
        else
            mov cl,8
            do
                ;left
                mov ah,[si] | inc si ; mask
                shr ah,1 | shr ah,1 | shr ah,1 | shr ah,1
                if nz
                    mov dx,GraphicsPort
                    mov al,BitMaskRegister
                    out dx,ax
                    mov ah,01h
                    do
                        mov dx,SequencerPort
                        mov al,MapMaskRegister
                        out dx,ax

                        mov al,[es:di]
                        mov al,[si] | inc si
                        shr al,1 | shr al,1 | shr al,1 | shr al,1
                        mov [es:di],al

                        shl ah,1
                        and ah,0fh
                    while nz | wend
                else
                    add si,PlaneCount
                endif
                inc di
                ; right
                sub si,1+PlaneCount
                mov ah,[si] | inc si
                shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
                if nz
                    mov dx,GraphicsPort
                    mov al,BitMaskRegister
                    out dx,ax
                    mov ah,01h
                    do
                        mov dx,SequencerPort
                        mov al,MapMaskRegister
                        out dx,ax

                        mov al,[es:di]
                        mov al,[si] | inc si
                        shl al,1 | shl al,1 | shl al,1 | shl al,1
                        mov [es:di],al

                        shl ah,1
                        and ah,0fh
                    while nz | wend
                else
                    add si,PlaneCount
                endif
                add si,1+PlaneCount
                add di,VramWidth-1
                dec cl
            while nz | wend
        endif
        mov dx,GraphicsPort
        mov ax,BitMaskRegister or 0ff00h
        out dx,ax
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret

; void DrawSprite2(byte x, byte y, byte pattern);
cseg
DrawSprite2_: public DrawSprite2_
	push ax | push cx | push dx | push bx | push si | push di
        call PrepareSprite
        and bl,1
        if z
            mov cl,16
            do
                mov ch,2
                do
                    mov ah,[si] | inc si ; mask
                    or ah,ah
                    if nz
                        mov dx,GraphicsPort
                        mov al,BitMaskRegister
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
                        add si,PlaneCount
                    endif
                    inc di
                    dec ch
                while nz | wend
                add di,VramWidth-2
                dec cl
            while nz | wend
        else
            mov cl,16
            do
                ;left
                mov ah,[si] | inc si ; mask
                shr ah,1 | shr ah,1 | shr ah,1 | shr ah,1
                if nz
                    mov dx,GraphicsPort
                    mov al,BitMaskRegister
                    out dx,ax
                    mov ah,01h
                    do
                        mov dx,SequencerPort
                        mov al,MapMaskRegister
                        out dx,ax

                        mov al,[es:di]
                        mov al,[si] | inc si
                        shr al,1 | shr al,1 | shr al,1 | shr al,1
                        mov [es:di],al

                        shl ah,1
                        and ah,0fh
                    while nz | wend
                else
                    add si,PlaneCount
                endif
                inc di
                ; center
                mov ah,[si-1-PlaneCount]
                mov al,[si] | inc si ; mask
                shr ax,1 | shr ax,1 | shr ax,1 | shr ax,1
                or al,al
                if nz
                    mov ah,al
                    mov dx,GraphicsPort
                    mov al,BitMaskRegister
                    out dx,ax
                    mov ah,01h
                    do
                        mov dx,SequencerPort
                        mov al,MapMaskRegister
                        out dx,ax

                        mov al,[es:di]
                        mov bh,[si-1-PlaneCount]
                        mov bl,[si] | inc si
                        shr bx,1 | shr bx,1 | shr bx,1 | shr bx,1
                        mov [es:di],bl

                        shl ah,1
                        and ah,0fh
                    while nz | wend
                else
                    add si,PlaneCount
                endif
                inc di
                ; right
                sub si,1+PlaneCount
                mov ah,[si] | inc si
                shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
                if nz
                    mov dx,GraphicsPort
                    mov al,BitMaskRegister
                    out dx,ax
                    mov ah,01h
                    do
                        mov dx,SequencerPort
                        mov al,MapMaskRegister
                        out dx,ax

                        mov al,[es:di]
                        mov al,[si] | inc si
                        shl al,1 | shl al,1 | shl al,1 | shl al,1
                        mov [es:di],al

                        shl ah,1
                        and ah,0fh
                    while nz | wend
                else
                    add si,PlaneCount
                endif
                add di,VramWidth-2
                dec cl
            while nz | wend
        endif
        mov dx,GraphicsPort
        mov ax,BitMaskRegister or 0ff00h
        out dx,ax
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret
