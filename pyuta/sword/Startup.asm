include "Vram.inc"
include "Vdp.inc"

ext InitVram
ext InitSound, SoundHandler
ext InitSprites, UpdateSprites
ext Main_

dseg
PrevSync:
    defb 0
TimerCount:
    defb 0


cseg
    defw $5555
    
    limi >0000
    lwpi >f0e0-4
    li r10,>f0e0-4

    bl @InitVram
    bl @InitSprites
    bl @InitSound
b @Main_


cseg
PollVSync_: public PollVSync_
    dect r10 | mov r0,*r10
    dect r10 | mov r11,*r10
        ; socb @>1b13,@>f070
        movb @VdpPort+2,r0
        ; szcb @>1b13,@>f070
        andi r0,>8000
        if ne
            movb @PrevSync,r0
            if eq
                movb @TimerCount,r0
                ai r0,>0100
                movb r0,@TimerCount
                bl @SoundHandler
                bl @UpdateSprites
                li r0,>8000
            endif
        endif
        movb r0,@PrevSync
    mov *r10+,r11
    mov *r10+,r0
rt


WaitTimer_: public WaitTimer_
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r11,*r10
        do
            bl @PollVSync_
            clr r1 | movb @TimerCount,r1
            c r1,r0
        while l | wend
        clr r0 | movb r0,@TimerCount
    mov *r10+,r11
    mov *r10+,r1
    mov *r10+,r0
rt
