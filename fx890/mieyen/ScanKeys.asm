KOUT EQU 200H
KIN EQU 202H
KCTL EQU 204H

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    push cx | push dx
        mov ch,ah
            xor cl,cl
            cli
                mov dx,KOUT

                mov ax,0010h | out dx,ax
                call Wait@
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                test ax,0080h ; Space
                if nz
                    or cl,Keys_Button0
                endif
                dec dx | dec dx

                mov ax,0020h | out dx,ax
                call Wait@
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                test ax,0080h ; Left
                if nz
                    or cl,Keys_Left
                endif
                test ax,0100h ; Down
                if nz
                    or cl,Keys_Down
                endif
                dec dx | dec dx

                mov ax,0040h | out dx,ax
                call Wait@
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                test ax,0020h ; Up
                if nz
                    or cl,Keys_Up
                endif
                test ax,0080h ; Right
                if nz
                    or cl,Keys_Right
                endif
                dec dx | dec dx

                mov ax,0080h | out dx,ax
                call Wait@
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                test ax,0020h ; 4
                if nz
                    or cl,Keys_Left
                endif
                dec dx | dec dx

                mov ax,0100h | out dx,ax
                call Wait@
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                test ax,0010h ; 8
                if nz
                    or cl,Keys_Up
                endif
                test ax,0040h ; 2
                if nz
                    or cl,Keys_Down
                endif
                dec dx | dec dx

                mov ax,0200h | out dx,ax
                call Wait@
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                test ax,0040h ; 6
                if nz
                    or cl,Keys_Right
                endif
                dec dx | dec dx

                mov ax,0800h | out dx,ax
                call Wait@
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                test ax,0800h ; Shift
                if nz
                    or cl,Keys_Button1
                endif
                inc dx | inc dx

                push ax
                    mov dx,KCTL | mov al,3 | out dx,al
                    dec al
                    out dx,al
                pop ax
            sti
            mov al,cl
        mov ah,ch
    pop dx | pop cx
Wait@:
ret


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    push cx | push dx
        mov ch,ah
            cli
                mov dx,KOUT

                mov ax,0001h | out dx,ax
                inc dx | inc dx
                mov dx,KIN | in ax,dx
                and al,01h
                if nz
                    mov al,1
                endif
                inc dx | inc dx
                
                mov cl,al
                    mov dx,KCTL | mov al,3 | out dx,al
                    dec al
                    out dx,al
                mov al,cl
            sti
        mov ah,ch
    pop dx | pop cx
ret
