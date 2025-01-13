include "Vram.inc"

ext Main_
ext InitSound

dseg
TimerCount:
    defb 0
PrevSync:
    defb 0

cseg
    lda #VideoMode | sta $b000
    jsr InitSound
jmp Main_


PollVSync:
    lda $b002
    and #$80
    if eq
        lda PrevSync
        if ne
            inc TimerCount
        endif
        lda #0
    endif
    sta PrevSync
rts


; void PollVSync();
PollVSync_: public PollVSync_
    pha
        jsr PollVSync
    pla
rts


WaitVSync: public WaitVSync
    pha
        do
            jsr PollVSync
            and #$80
        while ne | wend
    pla
rts


; void WaitTimer(byte t);
dseg
WaitTimer_t:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    pha
        sty WaitTimer_t
        do
            jsr PollVSync_
            lda TimerCount
            cmp WaitTimer_t
        while cc | wend
        sei
            lda #0 | sta TimerCount
        cli
    pla
rts