ext InitSound, SoundHandler
ext InitVram
ext Main_

zseg
DirectPage:
WaitTimer_param:
    defb 0

dseg
TimerCount:  public TimerCount
    defb 0
division:
    defb 0


cseg
    jsr InitSound

    lda #high DirectPage
    tfr a,dp

    lda #$40 | sta $fd12 ; submode status
    lda #$02 | sta $fd13 ; subbank
    clr $fd0f ; bank : RAM mode
    bsr HaltSubsys
    bsr InitMMR

    lda #$04 | sta $fd02 ; interrupt mask
    orcc #$50
        ldx #Handler | stx $fff8
    andcc #not $50

    jsr InitVram
    bsr InitEncorder
jmp Main_


HaltSubsys:
    pshs a
        do
            lda $FD05
        while mi | wend
        lda #$80
        sta $FD05
    puls a
rts

InitMMR:
    ldx #$fd80 ; MMR
    lda #$30
    do
        sta ,x+
        inca
        cmpa #$3b
    while ne | wend
    lda #$1d | sta $fd8f ; MMR $f000
    lda #$80 | sta $fd93 ; enable MMR
rts

InitEncorder:
    clr $f431
    do
        lda $f432
        anda #$01
    while eq | wend

    lda #$02 | sta  $f431
    do
        lda $f432
        anda #$01
    while eq | wend
rts
				

Handler: public Handler
    pshs a
        lda $fd03 ; interrupt flags
        bita #$04
        if eq
            lda division
            if pl
                suba #50
                sta division

                inc TimerCount
                jsr SoundHandler
            else
                adda #6
                sta division
            endif
        endif
    puls a
rti


cseg
WaitTimer_: public WaitTimer_
    sta <WaitTimer_param
        do
            lda TimerCount
            cmpa <WaitTimer_param
        while cs | wend
    lda <WaitTimer_param
    pshs cc | orcc #$50
        clr TimerCount
    puls cc
rts
