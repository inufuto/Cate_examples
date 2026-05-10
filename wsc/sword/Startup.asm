include "wsc.inc"
include "Vram.inc"

ext Main_
ext InitVram
ext InitSound, SoundHandler
ext InitSprites, UpdateSprites

RamSeg equ 0000h
RamTop equ 0000h
RamTail equ 0e00h
MetaDataSize equ 0010h
RomData equ -(RamTail-RamTop)-MetaDataSize

dseg
TimerCount: public TimerCount
    defb 0
denom:
    defb 0


cseg
Startup: public Startup
    cli
        mov cx,0 
        do | wloop

        mov ax,RamSeg | mov es,ax
        mov ax,cs | mov ds,ax
        mov si,RomData
        mov di,RamTop
        mov cx,(RamTail-RamTop)/2
        do
            movsw
        wloop
        mov ax,RamSeg | mov ds,ax
        mov ss,ax | mov sp,RamTail
    sti
    mov al,0ech | out REG_DISP_MODE,al
    mov al,VramX | out REG_SCR1_X,al | out REG_SCR2_X,al
    mov al,VramY | out REG_SCR1_Y,al | out REG_SCR2_Y,al
    mov al,07h | out REG_SPR_BASE,al ;0E00h
    mov al,32h | out REG_MAP_BASE,al ;1000h/1800h

    mov al,07h | out REG_DISP_CTRL,al
    xor al,al | out REG_SCR2_WIN_X0,al
    xor al,al | out REG_SCR2_WIN_Y0,al
    mov al,VramWidth*8-1 | out REG_SCR2_WIN_X1,al
    mov al,VramHeight*8-1 | out REG_SCR2_WIN_Y1,al

    mov al,01h | out REG_LCD_CTRL,al
    mov al,01h | out REG_SND_WAVE_BASE,al

    call InitVram
    call InitSprites
    call InitSound
    cli
        mov al,8 | out REG_INT_BASE,al
        mov al,40h | out REG_INT_ENABLE,al
        mov ax,Handler | mov [(4*(8+6))],ax
        mov ax,cs | mov [(4*(8+6))+2],ax
    sti
jmp Main_


Handler: public Handler
    push ax
        mov ax,RamSeg | mov ds,ax
        mov al,[denom]
        sub al,60
        if s
            add al,75
            push ax
                inc byte ptr[TimerCount]
                call SoundHandler
            pop ax
        endif
        mov [denom],al
        call UpdateSprites
        mov al,40h | out REG_INT_ACK,al
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
