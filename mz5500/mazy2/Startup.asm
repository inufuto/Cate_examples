ext InitKeys
ext InitSound, SoundHandler
ext InitVram
ext Main_

TimerInt equ 45h

dseg
TimerCount:
    defb 0


cseg
    mov ax,cs
    mov ds,ax
    xor ax,ax
    mov ss,ax
    mov sp,ax
    
    call InitTimer
    call InitKeys
    call InitSound
    call InitVram
jmp Main_


InitTimer:
    cli
        mov dx,213h
        mov al,0c5h | out dx,al
        mov al,20 | out dx,al

        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerInt*4],ax
        mov ax,cs | mov [es:TimerInt*4+2],ax

        in al,32h
        and al,not 20h
        out 32h,al
    sti
ret

TimerHandler: public TimerHandler
    push ax | push dx
    push ds
        mov ax,cs | mov ds,ax
        
        mov dx,240h
        in al,dx
        ; cmp al,6
        ; if z
            inc byte ptr[TimerCount]
            call SoundHandler
        ; endif

        mov dx,260h
        mov al,0edh | out dx,al
        mov al,04dh | out dx,al

        mov al,20h | out 30h,al ; EOI
    pop ds
    pop dx | pop ax
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
