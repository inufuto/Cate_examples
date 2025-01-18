include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern

SpriteWidth equ 4
SpriteHeight equ 16
SpritePatternSize equ SpriteWidth*SpriteHeight*(PlaneCount+1)
AttributeValue equ 08h
PortB equ 0e1h

dseg
GTop: public GTop
    defb 0
SpritePatternW: public SpritePatternW
    defs SpritePatternSize*Pattern_End

cseg
WriteHl:
    xchg ah,al
    out dx,al
    inc dx | inc dx
    xchg ah,al
    out dx,al
    dec dx | dec dx
ret

ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 16, 1 ; Wall
defb 4,6 ; Dot
defb 0
InitVram: public InitVram
    mov al,90h | out 0e8h,al ; 40column mode
    mov al,01h | mov dx,176h | out dx,al ; 8line mode

    mov dx,CrtPort
    mov ax,0708h | call WriteHl ; Text screen Horizontal display start digit
    
    ; Palettes
    mov ah,80h
    mov cl,16
    do
        mov al,ah
        and al,07h
        if nz
            or al,18h
        endif
        call WriteHl
        inc ah
        dec cl
    while nz | wend

    ; Graphics viewport
    mov dx,GraphPort2
    mov ax,0000h | call WriteHl
    mov ax,0100h | call WriteHl
    mov ax,02c8h | call WriteHl
    mov ax,0300h | call WriteHl
    mov ax,0400h | call WriteHl
    mov ax,0550h | call WriteHl
    mov ax,0617h | call WriteHl
    mov ax,1007h | call WriteHl

    mov si,MonoPattern
	xor al,al
	mov bx,ColorTable
	do
		mov cl,[bx]
		or cl,cl
	while nz
		inc bx
		mov ch,[bx]
		inc bx
        call MakePatternMono
		add al,cl
	wend

	mov si,ColorPattern
	mov ch,Char_End-Char_Color
	call MakePatternColor

	mov di,SpritePatternW
	mov si,SpritePattern
	mov cl,Pattern_End
	call MakeSpritePattern
ret

MakePatternMono:
    push ax | push bx | push cx | push dx
        mov ah,CharHeight*2 | mul ah
        mov di,ax
        do
            mov bh,CharHeight
            do
                mov dx,PcgSegment
                mov ah,[si] | inc si
                mov bl,ch
                do
                    xor al,al
                    test bl,01h
                    if nz
                        or al,ah
                    endif
                    test bl,10h
                    if nz
                        not ah
                        or al,ah
                        not ah
                    endif
                    mov es,dx
                    mov [es:di],al

                    shr bl,1
                    inc dh
                    cmp dh,(high PcgSegment) + PlaneCount
                while nz | wend
                inc di | inc di
                dec bh
            while nz | wend
            dec cl
        while nz | wend
    pop dx | pop cx | pop bx | pop ax
ret
          
MakePatternColor:
    mov ah,CharHeight*2 | mul ah
    mov di,ax
    do
        mov ax,PcgSegment | mov es,ax
        do
            mov cl,CharHeight
            do
                mov al,[si] | inc si
                mov [es:di],al
                inc di | inc di
                dec cl
            while nz | wend
            sub di,CharHeight*2
            mov ax,es
            inc ah
            mov es,ax
            cmp ah,(high PcgSegment)+PlaneCount
        while nz | wend
        add di,CharHeight*2
        dec ch
    while nz | wend
ret

MakeSpritePattern: public MakeSpritePattern
	do
		mov ch,SpritePatternSize/2
		do
			mov al,[si] | inc si
            push cx
                xor dx,dx
                mov ch,8
                do
                    shl dx | shl dx
                    shl al,1
                    if b
                        or dx,0003h
                    endif
                    dec ch
                while ne | wend
            pop cx
			mov [di],dx | inc di | inc di
			dec ch
		while nz | wend
		dec cl
	while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push ax | push bx
        mov ax,TVramSegment | mov es,ax
        mov bx,0
        do
            mov word ptr [es:bx],0
            inc bx | inc bx
            mov word ptr [es:bx],AttributeValue
            inc bx | inc bx
            cmp bx,1000h
        while nz | wend

        mov ax,GVramSegment | mov es,ax
        call PrepareErase
        xor ax,ax | mov di,ax
        not ax
        mov cx,8000h
        do
            stosw
        wloop

        mov dx,GraphPort2
        mov ax,0910h | call WriteHl
        mov byte ptr[GTop],20h
    pop bx | pop ax
ret


; word word VramAddress(byte x, byte y);
cseg
VramAddress_: public VramAddress_
    push dx
        mov dh,al
        mov al,VramRowSize
        mul dl
        mov dl,dh
        xor dh,dh
        shl dx,1 | shl dx,1
        add ax,dx
    pop dx
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push di
        mov di,ax
        mov ax,TVramSegment | mov es,ax
        mov [es:di],dl
        mov ax,di
        add ax,VramStep
    pop di
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    push ax | push dx
        mov dx,CrtPort
        do
            in al,PortB
            and al,01h
            jz SwitchVram_VBlank
            in al,dx
            and al,01h
        while nz | wend
        SwitchVram_VBlank:

        mov dx,GraphPort2
        mov al,[GTop] | mov ah,09h
        call WriteHl

        or al,al
        if z
            mov al,20h
        else
            xor al,al
        endif
        mov [GTop],al
    pop dx | pop ax
ret


LoadEs:
    mov al,[GTop]
    or al,al
    mov ax,GVramSegment
    if nz
        add ah,04h
    endif
    mov es,ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
	push ax | push cx | push dx | push bx | push si | push di
        xchg al,dl
        mov ch,VramWidth*2
        mul ch

		mov bl,dl ; x
		and bl,7
		shl bl,1 ; shift

        shr dl,1 | shr dl,1
        and dl,0feh
        xor dh,dh
        add ax,dx
        ; add ax,VramWidth*2*CharHeight
        mov di,ax
        
        mov dx,GraphPort
        mov ax,0404h | out dx,ax
        inc dx | inc dx
        mov ax,0707h | out dx,ax
        dec dx | dec dx
        mov ax,0505h | out dx,ax
        inc dx | inc dx
        mov ax,0707h | out dx,ax
        dec dx | dec dx

        mov ah,cl ; pattern
        xor al,al
        add ax,SpritePatternW
        mov si,ax

        call LoadEs

        mov cl,bl ; left shift
        mov ch,16 | sub ch,cl ; right shift
        mov bh,SpriteHeight
        do
			mov bl,SpriteWidth/2
			do
				push bx
                    mov bx,[si]
                    shr bx,cl
                    or bx,bx
                    if nz
                        inc si | inc si

                        mov ax,0606h | out dx,ax ; mask
                        inc dx | inc dx
                        xchg bh,bl
                        mov ax,bx | out dx,ax
                        dec dx | dec dx

                        mov ax,8080h | out dx,ax ; BRGI
                        inc dx | inc dx
                        mov bl,PlaneCount
                        do
                            mov ax,[si] | inc si | inc si
                            shr ax,cl
                            xchg ah,al
                            out dx,ax
                            dec bl
                        while nz | wend
                        xor ax,ax | out dx,ax
                        dec dx | dec dx
                        mov word ptr[es:di],0ffffh

                        sub si,2*(1+PlaneCount)
                    endif
                    inc di | inc di

                    mov bx,[si]
                    xchg cl,ch | shl bx,cl | xchg cl,ch
                    or bx,bx
                    if nz
                        inc si | inc si

                        mov ax,0606h | out dx,ax ; mask
                        inc dx | inc dx
                        xchg bh,bl
                        mov ax,bx | out dx,ax
                        dec dx | dec dx

                        mov ax,8080h | out dx,ax ; BRGI
                        inc dx | inc dx
                        mov bl,PlaneCount
                        do
                            mov ax,[si] | inc si | inc si
                            xchg cl,ch | shl ax,cl | xchg cl,ch
                            xchg ah,al
                            out dx,ax
                            dec bl
                        while nz | wend
                        xor ax,ax | out dx,ax
                        dec dx | dec dx
                        mov word ptr[es:di],0ffffh
                    else
                        add si,2*(1+PlaneCount)
                    endif
                pop bx
                dec bl
            while nz | wend
            add di,VramWidth*2-SpriteWidth
            dec bh
        while nz | wend
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret


; void EraseSprite(byte x, byte y);
cseg
PrepareErase:
    mov dx,GraphPort
    mov ax,0404h | out dx,ax
    inc dx | inc dx
    mov ax,0707h | out dx,ax
    dec dx | dec dx
    mov ax,0505h | out dx,ax
    inc dx | inc dx
    mov ax,4747h | out dx,ax
    dec dx | dec dx

    mov ax,8080h | out dx,ax ; BRGI
    inc dx | inc dx
    xor ax,ax
    mov bl,PlaneCount
    do
        out dx,ax
        dec bl
    while nz | wend
ret
EraseSprite_: public EraseSprite_
	push ax | push dx | push cx | push bx
        xchg al,dl
        mov ch,VramWidth*2
        mul ch

        mov bh,SpriteWidth/2
		mov bl,dl ; x
		and bl,7
        if nz
            inc bh
        endif
        shr dl,1 | shr dl,1
        and dl,0feh
        xor dh,dh
        add ax,dx
        ; add ax,VramWidth*2*CharHeight
        mov di,ax
        call LoadEs

        call PrepareErase
        not ax
        mov ch,SpriteHeight
        do
            push di
                mov cl,bh
                do
                    mov word ptr[es:di],ax
                    inc di | inc di
                    dec cl
                while nz | wend
            pop di
            add di,VramWidth*2
            dec ch
        while nz | wend
 	pop bx | pop cx | pop dx | pop ax
ret


; byte ReadVram(word vram);
cseg
ReadVram_: public ReadVram_
    push di
        mov di,ax
        mov ax,TVramSegment | mov es,ax
        mov al,[es:di]
    pop di
ret
