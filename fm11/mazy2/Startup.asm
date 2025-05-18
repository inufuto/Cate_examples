ext @Temp@word
ext SendSubProgram, StartSubProgram
ext InitVram
ext InitSound, SoundHandler
ext InitKey, KeyHandler
ext Main_

dseg
TimerCount: public TimerCount
    defb 0
WaitTimer_param:
    defb 0


cseg
    lda #high @Temp@word | tfr a,dp
    jsr InitKey
    jsr InitSound

    orcc #$10    
        lda #$90 | sta $FD02
        ldd #Handler | std $FFF8
    andcc #not $10

    lda #$41 | sta $FD39
    ldd #320 | std $FD3C ; 1/60 sec

    lda #$82 | sta $FD38
    ldd #4545 | std $FD3A
    lda $FD39

    jsr SendSubProgram
    jsr StartSubProgram
    lda #$0c | sta $FDA0 ; Video Control

    jsr InitVram
jmp Main_


Handler: public Handler
    lda $FD03
    bita #$01
    if ne
        pshs a
            lda $FD39
            ldd $FD3C
            inc TimerCount
            jsr SoundHandler
        puls a
    endif
    bita #$40
    if ne
        pshs a
            jsr KeyHandler
        puls a
    endif
rti


cseg
WaitTimer_: public WaitTimer_
    sta WaitTimer_param
        do
            lda TimerCount
            cmpa WaitTimer_param
        while cs | wend
    lda WaitTimer_param
    orcc #$50
        clr TimerCount
    andcc #not $50
rts
