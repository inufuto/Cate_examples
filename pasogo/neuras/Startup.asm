include "Pasogo.inc"

ext InitVram
; ext InitSound
ext Main_

TimerVector equ (0+8)*4
Interval equ 1192500/60

dseg
TimerCount:
    defb 0

cseg
    cli

    mov ax,TimerHandler | mov [es:TimerVector+0],ax
    mov ax,cs | mov [es:TimerVector+2],ax

    mov al,36h | out IntervalTimer+3,al ; counter 0: LSB, followed by write of MSB, mode 3
    defb 0ebh,0, 0ebh,0
    mov al,low Interval | out IntervalTimer+0,al
    defb 0ebh,0, 0ebh,0
    mov al,high Interval | out IntervalTimer+0,al
    defb 0ebh,0, 0ebh,0
    mov al,0fah | out InterruptController+1,al ; OCW1 : mask
    defb 0ebh,0, 0ebh,0

    sti

    call InitVram
    ; call InitSound
jmp Main_


TimerHandler: public TimerHandler
    push ax
        push ds
            mov ax,cs | mov ds,ax
            inc byte ptr[TimerCount]
            ; call SoundHandler
        pop ds
        mov al,20h | out InterruptController+0,al ; EOI
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
