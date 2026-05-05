include "Vram.inc"

ext InitVram
ext InitKeys
ext InitSound, SoundHandler
ext Main_

Interval equ 307200/60
TimerInt equ 40h+0

dseg
TimerCount: public TimerCount
    defb 0
Port60Value: public Port60Value
    defb 0

cseg
    cli
        mov ax,cs
        mov ds,ax
        mov ss,ax
        mov sp,0
    sti
    mov ax,VramSegment | mov es,ax
    
    mov bx,0ff8eh ; CRTC?
    mov byte ptr[es:bx],10
    inc bx
    mov byte ptr[es:bx],20h
    dec bx

    xor al,al | mov [Port60Value],al

    call InitVram
    call InitKeys
    call InitSound

    cli
        ; mov al,36h | out 46h,al
        mov al,low Interval | out 40h,al
        mov al,high Interval | out 40h,al
        mov al,01h  | mov [Port60Value],al | out 60h,al

        xor ax,ax | mov es,ax
        mov ax,TimerHandler | mov [es:TimerInt*4],ax
        mov ax,cs | mov [es:TimerInt*4+2],ax
    sti
jmp Main_

TimerHandler: public TimerHandler
    push ax
        push ds
            mov ax,cs | mov ds,ax
            inc byte ptr[TimerCount]

            call SoundHandler

            mov al,[Port60Value]
            or al,80h
            out 60h,al
        pop ds
        mov al,20h | out 00h,al ; EOI
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


; defs 1c00h
; defb "AAAA"
; defs 2000h
; defb "BBBB"
