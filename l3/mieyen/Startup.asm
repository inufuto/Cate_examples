ext Direct
ext InitVram
ext InitSound
ext Main_

dseg
TimerCount: defb 0 public TimerCount
DpBackup: defb 0

cseg
    ; lda #$08 | sta $FFE0
    clr $FFE0

    tfr dp,a
    sta DpBackup
    lda #high Direct
    tfr a,dp

    clr TimerCount

    orcc #$60
        ldd $0110
        std Handler_end+1
        ldd #Handler
        std $0110
    andcc #not $60

    jsr InitVram
    jsr InitSound
    jsr Main_

    ldd Handler_end+1
    std $0110
    
    lda DpBackup
    tfr a,dp

    lda #$c0
    sta $FFE0

    ;lda $0249
    ;sta $FFD0   ; MODE-SEL
rts


Handler:
    inc TimerCount
Handler_end:
jmp $e131


dseg
WaitTimer_param:
    defb 0
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
