ext InitVram
ext InitKeys, KeyHandler
ext InitSound, SoundHandler
ext Main_

Interval equ 2457600/60
TimerInt equ 08h+0
KeyInt equ 08h+4

dseg
TimerCount: public TimerCount
    defb 0
PortA0: public PortA0
    defb 0
oldTimerHandler:
    defs 4
oldKeyHandler:
    defs 4

cseg
    cli
        mov ax,cs | mov ds,ax

        mov ax,0040h | mov es,ax
        mov al,[es:01f5h] | mov [PortA0],al
    
        mov al,36h | out 0e6h,al
        mov al,low Interval | out 0e0h,al
        mov al,high Interval | out 0e0h,al
        
        xor ax,ax | mov es,ax
        mov ax,[es:TimerInt*4] | mov [oldTimerHandler],ax
        mov ax,[es:TimerInt*4+2] | mov [oldTimerHandler+2],ax
        mov ax,TimerHandler | mov [es:TimerInt*4],ax
        mov ax,cs | mov [es:TimerInt*4+2],ax

        mov ax,[es:KeyInt*4] | mov [oldKeyHandler],ax
        mov ax,[es:KeyInt*4+2] | mov [oldKeyHandler+2],ax
        mov ax,KeyHandler | mov [es:KeyInt*4],ax
        mov ax,cs | mov [es:KeyInt*4+2],ax

        call InitKeys
        call InitSound
    sti
    call InitVram
    call Main_

    cli
        mov al,34h | out 0e6h,al
        mov al,00h | out 0e0h,al
        mov al,60h | out 0e0h,al

        xor ax,ax | mov es,ax
        mov ax,[oldTimerHandler] | mov [es:TimerInt*4],ax
        mov ax,[oldTimerHandler+2] | mov [es:TimerInt*4+2],ax

        mov ax,[oldKeyHandler] | mov [es:KeyInt*4],ax
        mov ax,[oldKeyHandler+2] | mov [es:KeyInt*4+2],ax
    sti
retf


TimerHandler: public TimerHandler
    push ax
        push ds
            mov ax,cs | mov ds,ax
            inc byte ptr[TimerCount]
            call SoundHandler
            mov al,[PortA0]
            and al,not 10h | out 0a0h,al
            or al,10h | out 0a0h,al
            mov [PortA0],al
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
        ; cli
            mov byte ptr [TimerCount],0
        ; sti
    pop ax
ret
