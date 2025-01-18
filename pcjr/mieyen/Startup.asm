ext InitVram
ext KeyHandler,KeyBits
ext InitSound,SoundHandler
ext Main_

KeyVector equ 09h*4
TimerVector equ 1ch*4

PioPort equ 60h
TimerPort equ 40h
Interval equ 1192500/60


dseg
TimerCount:
    defb 0
cseg
    mov byte ptr[KeyBits],0
    
    in al,PioPort+1 | or al,60h | out PioPort+1,al
    
    call InitVram
    call InitSound
    cli
        xor ax,ax | mov es,ax
        mov ax,KeyHandler | mov [es:KeyVector+0],ax
        mov ax,cs | mov [es:KeyVector+2],ax
        mov ax,TimerHandler | mov [es:TimerVector+0],ax
        mov ax,cs | mov [es:TimerVector+2],ax

        mov al,0b4h | out TimerPort+3,al
        mov al,low Interval | out TimerPort+0,al
        mov al,high Interval | out TimerPort+0,al
    sti
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
