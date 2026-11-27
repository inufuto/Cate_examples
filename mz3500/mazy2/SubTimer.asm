include "Share.inc"
include "Sub.inc"

ext CmdLoop
ext SoundHandler
ext ReadJoystick

Interval equ 2450760/60

dseg
PrevCount:
    defw 0
Accum:
    defw 0
TimerCount:
    defb 0

cseg
InitTimer: public InitTimer
    ld a,34h | out (PitPort+3),a
    xor a
    out (PitPort+0),a
    out (PitPort+0),a

    ld (TimerCount),a
    ld hl,0
    ld (PrevCount),hl
    ld (Accum),hl
ret

PollTimer: public PollTimer
    xor a | out (PitPort+3),a ; latch command
    in a,(PitPort+0) | ld e,a
    in a,(PitPort+0) | ld d,a

    ld hl,(PrevCount)
    ld (PrevCount),de
    or a | sbc hl,de
    ld de,(Accum) | add hl,de

    ld bc,Interval
    do
        or a | sbc hl,bc
    while nc
        ld a,(TimerCount)
        inc a
        ld (TimerCount),a
        call SoundHandler
    wend
    add hl,bc
    ld (Accum),hl

    ld a,(TimerCount)
    ld (SubShareRam+Share_TimerCount),a
ret

ResetTimerCount: public ResetTimerCount
    xor a
    ld (TimerCount),a
    ld (SubShareRam+Share_TimerCount),a
jp CmdLoop