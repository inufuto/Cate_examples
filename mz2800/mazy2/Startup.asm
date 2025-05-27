include "Vram.inc"

ext InitSound, SoundHandler
ext InitVram
ext Main_

TimerVector equ 100h
TimerPort equ 0e4h


dseg
TimerCount:
    defb 0

cseg
    cli
        mov ax,cs
        mov ds,ax
        mov ss,ax
        mov sp,0
    sti
    call InitSound
    cli
        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerVector],ax
        mov ax,cs | mov [es:TimerVector+2],ax

        mov al,not 01h
        out 81h,al
    sti
    call InitVram
jmp Main_


StartTimer:
    mov al,30h | out TimerPort+3,al
    mov ax,31250/60
    out TimerPort,al
    xchg ah,al
    out TimerPort,al
ret

TimerHandler: public TimerHandler
    push ds
    push ax 
        mov ax,cs | mov ds,ax
        call StartTimer

        inc byte ptr[TimerCount]
        call SoundHandler

        mov al,20h | out 80h,al ; EOI
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



; 8259
;   80:11 ICW1 
;   81:40 ICW2 (offset)
;   81:80 ICW3
;   81:11 ICW4

;   81:ff OCW1 (mask)

