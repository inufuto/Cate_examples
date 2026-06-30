ext InitVram
ext InitKeys
ext InitSound, SoundHandler
ext Main_

Interval equ 1996800/60
TimerInt equ 08h

dseg
TimerCount:
    defb 0

cseg
    mov al,0dh | out 0a2h,al
    mov al,01h | out 6ah,al ; This shouldn't be necessary on the actual device.

    call InitSound
    cli
        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerInt*4],ax
        mov ax,cs | mov [es:TimerInt*4+2],ax
        
        mov al,36h | out 77h,al
        mov al,low Interval | out 71h,al
        mov al,high Interval | out 71h,al
        
        in al,02 | and al,0feh | out 02,al
    sti
    call InitVram
    call InitKeys
jmp Main_

TimerHandler: public TimerHandler
    push ds
    push ax
        mov ax,cs | mov ds,ax
        inc byte ptr[TimerCount]
        call SoundHandler
        mov al,20h | out 00h,al ; EOI
    pop ax
    pop ds
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
