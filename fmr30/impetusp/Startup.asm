ext InitVram
ext InitKeys
ext InitSound, SoundHandler
ext Main_

Interval equ 1000000/60
TimerInt equ 40h+0


dseg
TimerCount: public TimerCount
    defb 0

cseg
    cli
        mov ax,cs
        mov ds,ax
        mov ss,ax
        mov sp,0
    sti

    call InitSound
    call InitVram
    call InitKeys
    cli
        mov dx,130h
        mov al,low Interval | out dx,al
        mov al,high Interval | out dx,al

        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerInt*4],ax
        mov ax,cs | mov [es:TimerInt*4+2],ax
        mov al,01h | out 42h,al
    sti

    ; mov dx,40h
    ; mov al,80h or 12 | out dx,al
    ; mov al,17 | out dx,al
    ; mov al,90h | out dx,al
jmp Main_


TimerHandler: public TimerHandler
    push ax | push dx
        push ds
            mov ax,cs | mov ds,ax
            inc byte ptr[TimerCount]

            call SoundHandler
        pop ds

        mov dx,130h
        mov al,low Interval | out dx,al
        mov al,high Interval | out dx,al

        mov dx,100h | mov al,20h | out dx,al ; EOI
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
