include "Vram.inc"
include "VVram.inc"

RaderTop equ 12
RaderVram equ Vram+VramRowSize*RaderTop+VVramWidth*VramStep

ext FighterX_, FighterY_

; void DrawFighterOnRader()
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
	push ax | push dx | push di
        mov al,[FighterY_]
        dec al
        cmp al,192
        if nc
            xor al,al
        endif
        shr al,1 | shr al,1
        mov dh,al
        shr al,1
        mov ah,VramWidth | mul ah
        and dh,1
        if nz
            add ax,2000h*2
        endif
        mov dl,[FighterX_]
        dec dl
        and dl,128-1
        shr dl,1 | shr dl,1
        xor dh,dh
        add ax,dx
        add ax,RaderVram
        mov di,ax
        mov ax,VramSegment | mov es,ax

        xor byte ptr[es:di],0eeh
        xor byte ptr[es:di+2000h],0eeh
	pop di | pop dx | pop ax
ret 
