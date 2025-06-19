ext InitVram
ext InitKeys
; ext InitSound
ext Main_

TimerInt equ 42h

dseg
TimerCount:
    defb 0
count10:
    defb 0

cseg
    mov ax,cs | mov ds,ax

    cli
        in al,02h
        and al,not 04h
        out 02h,al
        mov byte ptr[count10],10
        
        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerInt*4],ax
        mov ax,cs | mov [es:TimerInt*4+2],ax
    sti

    call InitVram
    call InitKeys
    ; call InitSound
jmp Main_


TimerHandler: public TimerHandler
    push ax
    push ds
        mov ax,cs | mov ds,ax
        
        mov al,[count10]
        dec al
        mov [count10],al
        if z
            inc byte ptr[TimerCount]
            ; call SoundHandler
            mov byte ptr[count10],10
        endif

        mov al,20h | out 00h,al ; EOI
    pop ds
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
