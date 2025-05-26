include "Vram.inc"

ext InitKeys
ext InitVram
ext InitSound1, InitSound2, SoundHandler
ext Main_

TimerVector equ 1ch*4
TimerPort equ 40h
Interval equ 1192500/60

dseg
TimerCount: public TimerCount
    defb 0

cseg
    call InitKeys
    call InitSound1
    call InitVram
    cli
                                                ; mov dx,3dah | in al,dx
                                                ; mov dx,3c0h
                                                ; mov al,02fh | out dx,al
                                                ; mov al,27h | out dx,al
        mov ax,TimerHandler | mov [es:TimerVector+0],ax
        mov ax,cs | mov [es:TimerVector+2],ax

        mov al,low Interval | out TimerPort+0,al
        mov al,high Interval | out TimerPort+0,al
    sti
    call InitSound2
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
