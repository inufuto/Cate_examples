include "Vram.inc"

ext InitVram
ext InitKeyMode, InitKeys
ext InitSound, SoundHandler
ext Main_

TimerInt equ 08h+0
Interval equ 320 ; 1/60 sec

dseg
TimerCount: public TimerCount
    defb 0

cseg
    cli
        mov ax,cs
        mov ds,ax
        mov ss,ax
        mov sp,0
        call InitKeyMode
    sti
    
    mov dx,0fd05h | mov al,80h | out dx,al
    mov dx,0fd0fh | mov al,80h | out dx,al

    mov ax,SubSysSegment | mov es,ax
    mov bx,0ff8eh
    mov byte ptr[es:bx],10
    inc bx
    mov byte ptr[es:bx],20h
    dec bx

    call InitVram
    call InitKeys
    call InitSound

    cli
        mov dx,0fd39h | mov al,41h | out dx,al
        mov dx,0fd3ch | mov al,high Interval | out dx,al
        inc dx | mov al,low Interval | out dx,al

        mov dx,0fd38h | mov al,80h | out dx,al
        mov dx,0fd3ah | mov al,45h | out dx,al
        inc dx | out dx,al
        mov dx,0fd39h | in al,dx

        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerInt*4],ax
        mov ax,cs | mov [es:TimerInt*4+2],ax

        mov al,0fch | out 1,al
        mov dx,0fd02h | mov al,90h | out dx,al
    sti
jmp Main_
    
TimerHandler: public TimerHandler
    push ds
    push ax | push dx
        mov ax,cs | mov ds,ax
        inc byte ptr[TimerCount]
        call SoundHandler

        mov dx,0fd39h | in al,dx
        mov dx,0fd3ch | in ax,dx

        mov al,20h | out 0,al ; EOI
    pop dx | pop ax
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

; cseg
; TimerValue_: public TimerValue_
;     push dx
;         mov dx,0fd3ch
;         in al,dx | mov ah,al
;         inc dx
;         in al,dx
;     pop dx
; ret
