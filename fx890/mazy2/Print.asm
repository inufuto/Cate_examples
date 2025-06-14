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
            or ch,ch
            if z
                mov dl,' '
            endif
        else
            mov ch,1
        endif
        mov dh,al
    pop ax
    call PrintC_
    xor cl,1
    mov dl,dh
ret 

; ptr<byte> PrintByteNumber3(ptr<byte> pVram, byte b, bool shift);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    push cx | push dx | push bx
        xor ch,ch
        mov dh,100
        call PrintDigitB
        mov dh,10
        call PrintDigitB
        add dl,'0'
        call PrintC_
	pop bx | pop dx | pop cx
ret

; ptr<byte> PrintByteNumber2(ptr<byte> pVram, byte b, bool shift);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    push cx | push dx | push bx
        xor ch,ch
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
            or ch,ch
            if z
                mov dl,' '
            endif
        else
            mov ch,1
        endif
        mov bx,ax
    pop ax
    call PrintC_
    xor cl,1
    mov dx,bx
ret 


; ptr<byte> PrintNumber5(ptr<byte> pVram, word w, bool shift);
cseg
PrintNumber5_: public PrintNumber5_
    push cx | push dx | push bx
        xor ch,ch
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