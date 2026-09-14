cseg
ReadDisk: public ReadDisk
    push cx | push dx
        cli
        in al,2
        mov [1b5h],al
        or al,0f5h
        out 2,al
        sti

        mov byte ptr[19eh],46h
        mov al,ch
        shl al,1 | shl al,1
        mov [19fh],al
        mov [1a0h],dl
        mov [1a1h],ch
        mov [1a2h],dh
        mov byte ptr[1a3h],1
        mov byte ptr[1a4h],11h
        mov bp,9
        call SendCommand
        call WaitRead

        cli
        mov al,[1b5h]
        out 2,al
        sti

        call ReceiveResult
    pop dx | pop cx
ret

SendCommand: public SendCommand
    mov si,19eh
    do
        xor cx,cx
        do
            in al,08h
            cmp al,0c0h
            if b
                test al,40h
                je Send_do
            endif
        wloop
        Send_error:
        stc
        ret
        Send_do:
        xor cx,cx
        do
            in al,08h
            test al,80h
            jne Send_next
        wloop
        jmp Send_error
        Send_next:
        cld
        lodsb
        out 0ah,al
        dec bp
    while ne | wend
    mov byte ptr[195h],00h
    clc
ret

WaitRead: public WaitRead
    push bx
        mov byte ptr[195h],00h
        cli
        in al,1ch
        or al,80h
        out 1ch,al
        sti
        mov bl,14h
        do
            xor cx,cx
            do
                test byte ptr[195h],80h
                jne WaitRead_exit
            wloop
            dec bl
        while ne | wend
        stc
        jmp WaitRead_error
        WaitRead_exit:
        clc
        WaitRead_error:
        in al,1ch
        and al,7fh
        out 1ch,al
    pop bx
ret

ReceiveResult: public ReceiveResult
    mov si,1a7h
    xor cx,cx
    do
        Receive_retry:
        in al,08h
        test al,80h
        jne Receive_exit
        Receive_repeat:
    wloop
    stc
    ret
    Receive_exit:
    test al,40h
    je Receive_repeat
    in al,0ah
    mov [si],al
    inc si
    mov cx,0ah
    do | wloop
    in al,08h
    test al,10h
    jne Receive_retry
    clc
ret