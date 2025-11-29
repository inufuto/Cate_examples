ext InitVram
ext InitSound, SoundHandler
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
    push ax | push bx | push cx | push ds | push es
        call SetTimer

        mov ax,cs | mov ds,ax
        mov al,[denom]
        sub al,60
        if s
            add al,100
            inc byte ptr[TimerCount]
            call SoundHandler
        endif
        mov [denom],al
    pop es | pop ds | pop cx | pop bx | pop ax
iret
