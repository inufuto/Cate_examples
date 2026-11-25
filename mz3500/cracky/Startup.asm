include "Share.inc"

ext InitVram
ext Main_
ext TimerCount
ext HaltSub, ResumeSub
ext JoystickAvailable_

cseg
    xor a | out (0f8h),a ; Motor off
    ld (JoystickAvailable_),a
    call InitVram
jp Main_


; void WaitTimer(byte t);
cseg
WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            call HaltSub
            ld a,SubCommand_Nop | ld (MainShareRam+Share_Command),a
            call ResumeSub
            ld a,(TimerCount)
            cp e
        while c | wend
        call HaltSub
        ld a,SubCommand_ResetTimerCount | ld (MainShareRam+Share_Command),a
        call ResumeSub
    pop de | pop af
ret
