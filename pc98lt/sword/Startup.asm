ext InitVram
ext InitSound
ext Main_

dseg
TimerCount: public TimerCount
    defb 0
denom:
    defb 0

cseg
    mov ah,40h
    int 18h

    mov ch,80h
    mov ah,42h
    int 18h

    call InitVram
    call InitSound

    xor ax,ax
    mov es,ax
    mov al,es:[500h]
    or al,20h
    mov es:[500h],al

    call SetTimer
jmp Main_

SetTimer:
    mov cx,1
    push cs | pop es
    mov bx,Handler
    mov ah,02h
    int 1ch
ret

Handler: public Handler
    sti
    push ax
    push bx
    push cx
    push ds
    push es
        call SetTimer

        mov ax,cs | mov ds,ax
        mov al,[denom]
        sub al,60
        if s
            add al,100
            push ax
                inc byte ptr[TimerCount]
            pop ax
        endif
        mov [denom],al
    pop es
    pop ds
    pop cx
    pop bx
    pop ax
iret


WaitTimer_: public WaitTimer_
    push ax
        mov ah,al
        do
            mov al,[TimerCount]
            cmp al,ah
        while b | wend
        cli
            mov byte ptr [TimerCount],0
        sti
    pop ax
ret
