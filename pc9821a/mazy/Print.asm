
ext PrintC_

cseg
PrintDigitB:
    push ax
        mov al,dl
        mov dl,'0'
        do
            inc dl
            sub al,dh
        while nc | wend
        add al,dh
        dec dl
        cmp dl,'0'
        if z
            or cl,cl
            if z
                mov dl,' '
            endif
        else
            mov cl,1
        endif
        mov dh,al
    pop ax
    call PrintC_
    mov dl,dh
ret 

; ; word PrintByteNumber3(word vram, byte b);
; cseg
; PrintByteNumber3_: public PrintByteNumber3_
;     push cx | push dx | push bx
;         xor cl,cl
;         mov dh,100
;         call PrintDigitB
;         mov dh,10
;         call PrintDigitB
;         add dl,'0'
;         call PrintC_
; 	pop bx | pop dx | pop cx
; ret

; word PrintByteNumber2(word vram, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    push cx | push dx | push bx
        xor cl,cl
        mov dh,10
        call PrintDigitB
        add dl,'0'
        call PrintC_
	pop bx | pop dx | pop cx
ret


cseg
PrintDigitW:
    push ax
        mov ax,dx
        mov dl,'0'
        do
            inc dl
            sub ax,bx
        while nc | wend
        add ax,bx
        dec dl
        cmp dl,'0'
        if z
            or cl,cl
            if z
                mov dl,' '
            endif
        else
            mov cl,1
        endif
        mov bx,ax
    pop ax
    call PrintC_
    mov dx,bx
ret 


; word PrintNumber5(word vram, word w);
cseg
PrintNumber5_: public PrintNumber5_
    push cx | push dx | push bx
        xor cl,cl
        mov bx,10000
        call PrintDigitW
        mov bx,1000
        call PrintDigitW
        mov bx,100
        call PrintDigitW
        mov bx,10
        call PrintDigitW
        add dl,'0'
        call PrintC_
	pop bx | pop dx | pop cx
ret


; word PrintNumber3(word vram, word w);
cseg
PrintNumber3_: public PrintNumber3_
    push cx | push dx | push bx
        xor cl,cl
        mov bx,100
        call PrintDigitW
        mov bx,10
        call PrintDigitW
        add dl,'0'
        call PrintC_
	pop bx | pop dx | pop cx
ret