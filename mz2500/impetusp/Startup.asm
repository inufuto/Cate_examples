include "MemMap.inc"
include "Vram.inc"

ext InitSound, SoundHandler
ext InitVram
ext Main_

InterruptPort equ 0c6h
JoystickPort equ 0efh
TimerPort equ 0e4h

dseg
MemMapSave:
    defs 8
TimerCount: public TimerCount
    defb 0

cseg
Startup:
    ld sp,Startup

    di
        ld a,6 | out (MemMapPort),a
        ld a,MemMap_PCG | out (MemMapPort+1),a
        ld a,MemMap_Text | out (MemMapPort+1),a
    ei

    ld a,01h | out (0f7h),a
    
    ld a,0 | out (CRTPort),a
    ld a,07h | out (CRTPort+1),a
    ld bc,(15 shl 8) or 1
    do
        ld a,c | or 80h | out (CRTPort),a
        ld a,c
        cp 8
        if z
            xor a
        endif
        or 10h
        out (CRTPort+1),a
        inc c
    dwnz

    ld a,0eh | out (GraphPort),a
    ld a,14h | out (GraphPort+1),a

    ld a,0fh | out (JoystickPort),a

    call InitSound
    di
        ld a,44h | out (InterruptPort),a
        ld a,0fch | out (InterruptPort+1),a

        ld hl,HandlerHead
        ld de,0f00h| ld (02fch),de
        ld bc,HandlerTail-HandlerHead
        ldir

        call StartTimer
    ei

    call InitVram
jp Main_

MemMapValues:
    defb 0,1,2,3,4,5,MemMap_PCG,MemMap_Text

StartTimer:
    push af | push hl
        ld hl,31250/60
        ld a,30h | out (TimerPort+3),a
        ld a,l | out (TimerPort),a
        ld a,h | out (TimerPort),a
    pop hl | pop af
ret

HandlerHead:
    push af | push hl | push bc
        ld bc,(4 shl 8)or MemMapPort
        ld a,2 | out (c),a
        inc c
        ld hl,MemMapSave+2
        inir

        ld bc,(4 shl 8)or MemMapPort
        ld a,2 | out (c),a
        inc c
        ld hl,MemMapValues+2
        outir

        call Handler

        ld bc,(4 shl 8)or MemMapPort
        ld a,2 | out (c),a
        inc c
        ld hl,MemMapSave+2
        outir
    pop bc | pop hl | pop af
ei | reti
HandlerTail:


Handler: public Handler
    call StartTimer
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
    call SoundHandler
ret


WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        di
            xor a
            ld (TimerCount),a
        ei
    pop de | pop af
ret
