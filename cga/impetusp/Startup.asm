ext InitKeys
ext InitVram
ext InitSound, SoundHandler
ext Main_

TimerVector equ 1ch*4
TimerPort equ 40h
Interval equ 1192500/60

dseg
TimerCount:
    defb 0
cseg
    call InitKeys
    call InitVram
    call InitSound
    cli
        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerVector+0],ax
        mov ax,cs | mov [es:TimerVector+2],ax

        mov al,low Interval | out TimerPort+0,al
        mov al,high Interval | out TimerPort+0,al
    sti
    ; mov al,low 2710 | out TimerPort+2,al
    ; mov al,high 2710 | out TimerPort+2,al
    ; in al,61h
    ; or al,03h
    ; out 61h,al
jmp Main_


TimerHandler: public TimerHandler
    push ds | push ax
        mov ax,cs | mov ds,ax
        inc byte ptr[TimerCount]
        call SoundHandler
    pop ax | pop ds
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
