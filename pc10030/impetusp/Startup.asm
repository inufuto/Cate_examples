ext InitVram
ext InitKeys
ext InitSound, SoundHandler
ext Main_

TimerInt equ 42h

dseg
TimerCount: public TimerCount
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
    call InitSound
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
            call SoundHandler
            mov byte ptr[count10],10
        endif

        mov al,20h | out 00h,al ; EOI
    pop ds
    pop ax
iret
