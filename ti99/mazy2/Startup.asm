include "Vram.inc"
include "Vdp.inc"

ext InitSound, SoundHandler
ext InitVram
ext InitSprites, UpdateSprites
ext Main_

dseg
PrevSync:
    defb 0
TimerCount:
    defb 0

cseg
    bl @InitSound
    bl @InitVram
    bl @InitSprites
b @Main_

cseg
PollVSync_: public PollVSync_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
        movb @VdpRead+2,r0
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
    mov *r10+,r0
    mov *r10+,r11
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
        waitExit:
        clr r0 | movb r0,@TimerCount
    mov *r10+,r11
    mov *r10+,r1
    mov *r10+,r0
rt
