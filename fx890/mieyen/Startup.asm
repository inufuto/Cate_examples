include "Vram.inc"

ext WriteLcd,ReadLcd
ext InitSound
ext Main_

dseg
CtrlSave:
    defb 0
Save38:
    defw 0
Save3a:
    defw 0
Save3e:
    defw 0
SaveInt:
    defw 0
    defw 0
TimerCount:
    defb 0


cseg
    mov ax,cs | mov ds,ax

    mov ah,10h
    int 41h

    mov ax,LcdSegment | mov es,ax

    mov al,23h | call ReadLcd | mov [CtrlSave],ah
    mov ax,0b523h | call WriteLcd

    cli
        call InitSound
        
        in ax,3eh | mov [Save3e],ax
        in ax,3ah | mov [Save3a],ax
        in ax,38h | mov [Save38],ax
        mov ax,0e001h | out 3eh,ax
        mov ax,15360 | out 3ah,ax
        mov ax,0 | out 38h,ax

        mov ax,[48h] | mov [SaveInt],ax
        mov ax,Handler | mov [48h],ax
        mov ax,[4ah] | mov [SaveInt+2],ax
        mov ax,cs | mov [48h+2],ax
    sti

    call Main_

    cli
        mov ax,[Save3e] | out 3eh,ax
        mov ax,[Save38] | out 38h,ax
        mov ax,[Save3a] | out 3ah,ax

        mov ax,[SaveInt] | mov [48h],ax
        mov ax,[SaveInt+2] | mov [48h+2],ax
    sti

    mov al,23h | mov ah,[CtrlSave] | call WriteLcd
   
    xor al,al
iret


Handler:
    push ds | push ax
        mov ax,cs | mov ds,ax
        inc byte ptr[TimerCount]
        mov ax,8000h | out 2,ax
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
