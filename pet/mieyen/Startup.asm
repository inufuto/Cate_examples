ext Main_
ext InitSound, SoundHandler

Interval equ 1000000/60

dseg
IntSave:
    defw 0
TimerCount:
    defb 0
cseg
    lda #12 | sta $E84C ; Character Map

    jsr InitSound
    ldy #low Handler | ldx #high Handler
    sei
        lda $fffe | cmp #$6b
        if eq
            lda $0219 | sta IntSave
            lda $0219+1 | sta IntSave+1
            sty $0219 | stx $0219+1
        else
            lda $0090 | sta IntSave
            lda $0090+1 | sta IntSave+1
            sty $0090 | stx $0090+1
        endif
        lda #$c0 | sta $E84B ; Via
        lda #low Interval | sta $E844 ; T1
        lda #high Interval | sta $E844+1
    cli
    lda #$7f | sta $E84E
    lda #$80 or $40 | sta $E84E
jmp Main_


Handler: public Handler
    pha
        lda $E84D
        and #$40
        if ne
            lda $E84D | and #$40 | sta $E84D
            inc TimerCount
            jsr SoundHandler
        endif
    pla
jmp (IntSave)


; void WaitTimer(byte t);
dseg
WaitTimer_t:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    pha
        sty WaitTimer_t
        do
            lda TimerCount
            cmp WaitTimer_t
        while cc | wend
        sei
            lda #0 | sta TimerCount
        cli
    pla
rts