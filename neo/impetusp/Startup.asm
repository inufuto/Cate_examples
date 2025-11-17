include "neo6502.inc"

ext InitVram
ext InitSprites, UpdateSprites
ext InitSound
ext Main_

dseg
oldTime:
    defb 0
den:
    defb 0
TimerCount: 
    defb 0

cseg
Startup:
    jsr InitVram
    jsr InitSprites
    jsr InitSound
    stz den
    jsr ReadTimer | sta oldTime
jmp Main_


; void WaitTimer(byte t);
dseg
WaitTimer_t:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    pha
        sty WaitTimer_t
        do
            jsr PollTimer
            lda TimerCount
            cmp WaitTimer_t
        while cc | wend
        stz TimerCount
    pla
rts

PollTimer: public PollTimer
    jsr ReadTimer
    do
        cmp oldTime
    while ne
        inc oldTime
        pha
            lda den
            sec|sbc #6
            if cc
                adc #10
                inc TimerCount
                jsr UpdateSprites
            endif
            sta den
        pla
    wend
rts


ReadTimer:
    lda #API_GROUP_SYSTEM | sta API_FUNCTION
    lda #API_FN_TIMER | sta API_COMMAND
    lda API_PARAMETERS
rts
