include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern

SpriteWidth equ 4
SpriteHeight equ 16
SpritePatternSize equ SpriteWidth*SpriteHeight*GPlaneCount
AttributeValue equ 08h
PortB equ 0e1h

dseg
SpritePatternW: public SpritePatternW
    defs SpritePatternSize*Pattern_End
GTop: public GTop
    defb 0
NextPage: public NextPage
    defw 0
TerrainCharOffset: public TerrainCharOffset
    defw 0

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
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
PaletteTable:
defb 00h,11h,12h,13h,14h,15h,16h,17h
defb 10h,19h,1ah,1bh,1ch,1dh,1eh,1fh
InitVram: public InitVram
    mov al,90h | out 0e8h,al ; 40column mode
    mov al,01h | mov dx,176h | out dx,al ; 8line mode

    mov dx,CrtPort
    mov ax,0708h | call WriteHl ; Text screen Horizontal display start digit
    
    mov bx,PaletteTable
    mov ah,80h
    mov cl,16
    do
        mov al,[bx] inc bx
        call WriteHl
        inc ah
        dec cl
    while nz | wend

    ; Graphics viewport
    mov dx,GraphPort2
    mov ax,0000h | call WriteHl ; Vertical start position
    mov ax,0100h | call WriteHl
    mov ax,02c8h | call WriteHl ; Vertical end position
    mov ax,0300h | call WriteHl
    mov ax,0400h | call WriteHl ; Horizontal start position
    mov ax,0550h | call WriteHl ; Horizontal end position
    mov ax,0617h | call WriteHl ; Screen Mode 640*200*16
    mov ax,100fh | call WriteHl ; Plane to display

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

	; mov si,ColorPattern
	; mov ch,Char_End-Char_Color
	; call MakePatternColor

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
                    cmp dh,(high PcgSegment) + TPlaneCount
                while nz | wend
                inc di | inc di
                dec bh
            while nz | wend
            dec cl
        while nz | wend
    pop dx | pop cx | pop bx | pop ax
ret
          
; MakePatternColor:
;     mov ah,CharHeight*2 | mul ah
;     mov di,ax
;     do
;         mov ax,PcgSegment | mov es,ax
;         do
;             mov cl,CharHeight
;             do
;                 mov al,[si] | inc si
;                 mov [es:di],al
;                 inc di | inc di
;                 dec cl
;             while nz | wend
;             sub di,CharHeight*2
;             mov ax,es
;             inc ah
;             mov es,ax
;             cmp ah,(high PcgSegment)+TPlaneCount
;         while nz | wend
;         add di,CharHeight*2
;         dec ch
;     while nz | wend
; ret

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
                    shr al,1
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
    push ax | push bx | push dx
        mov ax,TVramSegment | mov es,ax
        mov bx,Vram0
        do
            mov word ptr [es:bx],0
            inc bx | inc bx
            mov word ptr [es:bx],AttributeValue
            inc bx | inc bx
            cmp bx,Vram0+2000h
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

        mov dx,CrtPort
        mov ax,0005h | call WriteHl
        mov word ptr[NextPage],Vram1
        mov byte ptr[TerrainCharOffset],Char_Terrain1-Char_Terrain0
    pop dx | pop bx | pop ax
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push di
        mov di,ax
        mov ax,TVramSegment | mov es,ax
        mov [es:di],dl
        mov [es:di+1000h],dl
        mov ax,di
        add ax,VramStep
    pop di
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
	push bx | push di
		mov di,ax
		mov bx,CharTable
		mov ax,30 shl 8
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
        mov ax,TVramSegment | mov es,ax
        mov [es:di],bl
        mov [es:di+1000h],bl
        mov ax,di
        add ax,VramStep
	pop di | pop bx
ret


; void SwitchTVram();
cseg
SwitchTVram_: public SwitchTVram_
    push ax | push dx
        mov dx,CrtPort
        mov ax,[NextPage]
        or ah,ah
        if z
            mov ax,0005h | call WriteHl
            mov word ptr[NextPage],Vram1
            mov byte ptr[TerrainCharOffset],Char_Terrain1-Char_Terrain0
        else
            mov ax,0009h | call WriteHl
            mov word ptr[NextPage],Vram0
            mov byte ptr[TerrainCharOffset],0
        endif
    pop dx | pop ax
ret


; void SwitchGVram();
cseg
SwitchGVram_: public SwitchGVram_
    push ax | push dx
        mov dx,CrtPort
        do
            in al,PortB
            and al,01h
            jz SwitchGVram_VBlank
            in al,dx
            and al,01h
        while nz | wend
        SwitchGVram_VBlank:

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
        mov ax,0404h | out dx,ax ; Color Register
        inc dx | inc dx
        mov ax,0f0fh | out dx,ax
        dec dx | dec dx

        mov ax,0505h | out dx,ax ; Function register/screen selection register
        inc dx | inc dx
        mov ax,0f0fh | out dx,ax
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
                    push cx
                        xor bx,bx
                        mov ax,8080h | out dx,ax ; BRGI
                        inc dx | inc dx
                        mov ch,GPlaneCount
                        do
                            mov ax,[si] | inc si | inc si
                            shr ax,cl
                            xchg ah,al
                            or bx,ax
                            out dx,ax
                            dec ch
                        while nz | wend
                        dec dx | dec dx
                        mov ax,0606h | out dx,ax ; mask
                        inc dx | inc dx
                        mov ax,bx | out dx,ax
                        dec dx | dec dx
                        mov word ptr[es:di],0ffffh
                        sub si,2*GPlaneCount
                        inc di | inc di
                    pop cx
                    push cx
                        mov cl,ch
                        xor bx,bx
                        mov ax,8080h | out dx,ax ; BRGI
                        inc dx | inc dx
                        mov ch,GPlaneCount
                        do
                            mov ax,[si] | inc si | inc si
                            shl ax,cl
                            xchg ah,al
                            or bx,ax
                            out dx,ax
                            dec ch
                        while nz | wend
                        dec dx | dec dx
                        mov ax,0606h | out dx,ax ; mask
                        inc dx | inc dx
                        mov ax,bx | out dx,ax
                        dec dx | dec dx
                        mov word ptr[es:di],0ffffh
                    pop cx
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
    mov ax,0f0fh | out dx,ax
    dec dx | dec dx
    mov ax,0505h | out dx,ax
    inc dx | inc dx
    mov ax,4f4fh | out dx,ax
    dec dx | dec dx

    mov ax,8080h | out dx,ax ; BRGI
    inc dx | inc dx
    xor ax,ax
    mov bl,GPlaneCount
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
